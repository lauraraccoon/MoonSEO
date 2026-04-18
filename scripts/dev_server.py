#!/usr/bin/env python3
import json
import os
import re
import socket
import time
from html import unescape
from html.parser import HTMLParser
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parent.parent
HOST = os.environ.get("HOST", os.environ.get("MOONSEO_HOST", "127.0.0.1"))
PORT = int(os.environ.get("PORT", os.environ.get("MOONSEO_PORT", "4173")))
DEFAULT_BASE_URL = os.environ.get("MOONSEO_OPENAI_BASE_URL", "https://api.openai.com/v1")
DEFAULT_MODEL = os.environ.get("MOONSEO_OPENAI_MODEL", "gpt-4.1-mini")
API_KEY = os.environ.get("OPENAI_API_KEY", "")
DEEPSEEK_API_KEY = os.environ.get("DEEPSEEK_API_KEY", "")
DEEPSEEK_BASE_URL = os.environ.get("MOONSEO_DEEPSEEK_BASE_URL", "https://api.deepseek.com")
DEEPSEEK_MODEL = os.environ.get("MOONSEO_DEEPSEEK_MODEL", "deepseek-chat")
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "")
GEMINI_MODEL = os.environ.get("MOONSEO_GEMINI_MODEL", "gemini-2.5-flash")
UPSTREAM_TIMEOUT_SECONDS = float(os.environ.get("MOONSEO_UPSTREAM_TIMEOUT_SECONDS", "25"))
DRAFT_MAX_COMPLETION_TOKENS = int(
    os.environ.get("MOONSEO_DRAFT_MAX_COMPLETION_TOKENS", "2200")
)
DRAFT_RETRY_COUNT = int(
    os.environ.get("MOONSEO_DRAFT_RETRY_COUNT", "0")
)
CLAIM_REVIEW_TIMEOUT_SECONDS = float(
    os.environ.get("MOONSEO_CLAIM_REVIEW_TIMEOUT_SECONDS", "35")
)
CLAIM_REVIEW_MAX_COMPLETION_TOKENS = int(
    os.environ.get("MOONSEO_CLAIM_REVIEW_MAX_COMPLETION_TOKENS", "1800")
)
CLAIM_REVIEW_RETRY_COUNT = int(
    os.environ.get("MOONSEO_CLAIM_REVIEW_RETRY_COUNT", "0")
)


class UpstreamError(Exception):
    def __init__(self, status: int, message: str):
        super().__init__(message)
        self.status = status
        self.message = message


class WebsiteTextExtractor(HTMLParser):
    def __init__(self):
        super().__init__()
        self.skip_depth = 0
        self.body_depth = 0
        self.main_depth = 0
        self.body_parts = []
        self.main_parts = []
        self.block_tags = {
            "article",
            "aside",
            "br",
            "div",
            "footer",
            "h1",
            "h2",
            "h3",
            "h4",
            "header",
            "li",
            "main",
            "nav",
            "p",
            "section",
            "ul",
        }

    def handle_starttag(self, tag, attrs):
        lower = tag.lower()
        if lower in {"script", "style", "noscript", "svg"}:
            self.skip_depth += 1
            return
        if lower == "body":
            self.body_depth += 1
        if lower in {"main", "article"}:
            self.main_depth += 1
        if lower in self.block_tags:
            self._push_break()

    def handle_endtag(self, tag):
        lower = tag.lower()
        if lower in {"script", "style", "noscript", "svg"}:
            if self.skip_depth > 0:
                self.skip_depth -= 1
            return
        if lower == "body" and self.body_depth > 0:
            self.body_depth -= 1
        if lower in {"main", "article"} and self.main_depth > 0:
            self.main_depth -= 1
        if lower in self.block_tags:
            self._push_break()

    def handle_data(self, data):
        if self.skip_depth > 0:
            return
        text = re.sub(r"\s+", " ", unescape(data or "")).strip()
        if text == "":
            return
        if self.body_depth > 0:
            self.body_parts.append(text)
        if self.main_depth > 0:
            self.main_parts.append(text)

    def extracted_text(self) -> str:
        preferred = self._normalize(self.main_parts)
        if preferred:
            return preferred
        return self._normalize(self.body_parts)

    def _push_break(self):
        if self.body_depth > 0:
            self.body_parts.append("\n")
        if self.main_depth > 0:
            self.main_parts.append("\n")

    def _normalize(self, parts) -> str:
        raw = "".join(parts)
        raw = raw.replace("\r", "")
        lines = []
        for line in raw.split("\n"):
            cleaned = re.sub(r"\s+", " ", line).strip()
            if len(cleaned) < 20:
                continue
            lowered = cleaned.lower()
            if lowered in {"home", "menu", "navigation"}:
                continue
            lines.append(cleaned)
            if len(lines) >= 16:
                break
        return "\n".join(lines)


class MoonSEOHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def do_GET(self):
        if self.path == "/healthz":
            self.respond_json(200, {"ok": True, "provider": self.configured_provider_chain()})
            return
        super().do_GET()

    def do_POST(self):
        if self.path not in {"/api/draft", "/api/claim-review", "/api/fetch-website"}:
            self.send_error(404, "Not found")
            return

        length = int(self.headers.get("Content-Length", "0"))
        raw = self.rfile.read(length)
        try:
            payload = json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            self.respond_json(400, {"error": "Invalid JSON body."})
            return

        if self.path == "/api/fetch-website":
            url = str(payload.get("url", "")).strip()
            if url == "":
                self.respond_json(400, {"error": "URL is required."})
                return
            try:
                text = self.fetch_website_text(url)
            except UpstreamError as exc:
                self.respond_json(exc.status, {"error": exc.message})
                return
            self.respond_json(200, {"url": url, "text": text})
            return

        prompt = str(payload.get("prompt", "")).strip()
        if prompt == "":
            self.respond_json(400, {"error": "Prompt is required."})
            return
        try:
            text = self.request_upstream(
                prompt,
                task="claim_review" if self.path == "/api/claim-review" else "draft",
            )
        except UpstreamError as exc:
            self.respond_json(exc.status, {"error": exc.message})
            return

        cleaned = text.strip()
        if cleaned.startswith("```json"):
            cleaned = cleaned[7:].lstrip()
        elif cleaned.startswith("```"):
            cleaned = cleaned[3:].lstrip()
        if cleaned.endswith("```"):
            cleaned = cleaned[:-3].rstrip()

        try:
            parsed = json.loads(cleaned)
        except json.JSONDecodeError:
            self.respond_json(502, {"error": "The model did not return valid JSON.", "raw": text})
            return

        if self.path == "/api/draft":
            packed = self.pack_draft_payload(parsed)
        else:
            packed = self.pack_claim_review_payload(parsed)
        self.respond_json(200, {"payload": packed})

    def fetch_website_text(self, url: str) -> str:
        parsed = urlparse(url)
        if parsed.scheme not in {"http", "https"} or parsed.netloc == "":
            raise UpstreamError(400, "Please enter a valid http or https website URL.")

        request = Request(
            url,
            headers={
                "User-Agent": "MoonSEO/1.0 (+https://moonseo.local)",
                "Accept": "text/html,application/xhtml+xml",
            },
            method="GET",
        )

        try:
            with urlopen(request, timeout=UPSTREAM_TIMEOUT_SECONDS) as resp:
                body = resp.read()
                content_type = resp.headers.get("Content-Type", "")
                charset = resp.headers.get_content_charset() or "utf-8"
        except HTTPError as exc:
            raise UpstreamError(exc.code or 502, f"Website fetch failed: {exc.reason}")
        except TimeoutError:
            raise UpstreamError(504, "Website fetch timed out.")
        except socket.timeout:
            raise UpstreamError(504, "Website fetch timed out.")
        except URLError as exc:
            if self.is_timeout_error(exc.reason):
                raise UpstreamError(504, "Website fetch timed out.")
            raise UpstreamError(502, f"Website fetch failed: {exc.reason}")
        except ConnectionResetError as exc:
            raise UpstreamError(502, f"Website fetch failed: {exc}")

        if "html" not in content_type.lower():
            raise UpstreamError(415, "The website did not return HTML content.")

        html = body.decode(charset, errors="replace")
        extractor = WebsiteTextExtractor()
        extractor.feed(html)
        text = extractor.extracted_text().strip()
        if text == "":
            raise UpstreamError(422, "The website was fetched, but no usable body text could be extracted.")
        return text

    def request_upstream(self, prompt: str, *, task: str) -> str:
        errors = []
        if DEEPSEEK_API_KEY != "":
            try:
                return self.request_openai_compatible(
                    prompt,
                    api_key=DEEPSEEK_API_KEY,
                    base_url=DEEPSEEK_BASE_URL,
                    model=DEEPSEEK_MODEL,
                    provider_name="DeepSeek",
                    task=task,
                )
            except UpstreamError as exc:
                errors.append(("DeepSeek", exc))
        if GEMINI_API_KEY != "":
            try:
                return self.request_gemini(prompt, task=task)
            except UpstreamError as exc:
                errors.append(("Gemini", exc))
        if API_KEY != "":
            try:
                return self.request_openai_compatible(
                    prompt,
                    api_key=API_KEY,
                    base_url=DEFAULT_BASE_URL,
                    model=DEFAULT_MODEL,
                    provider_name="OpenAI-compatible model",
                    task=task,
                )
            except UpstreamError as exc:
                errors.append(("OpenAI-compatible", exc))
        if errors:
            raise self.combine_upstream_errors(errors)
        raise UpstreamError(
            500,
            "No model key is configured. Set DEEPSEEK_API_KEY, GEMINI_API_KEY, or OPENAI_API_KEY on the local server.",
        )

    def request_openai_compatible(
        self,
        prompt: str,
        *,
        api_key: str,
        base_url: str,
        model: str,
        provider_name: str,
        task: str,
    ) -> str:
        endpoint = base_url.rstrip("/") + "/chat/completions"
        timeout_seconds = (
            CLAIM_REVIEW_TIMEOUT_SECONDS
            if task == "claim_review"
            else UPSTREAM_TIMEOUT_SECONDS
        )
        max_completion_tokens = (
            CLAIM_REVIEW_MAX_COMPLETION_TOKENS
            if task == "claim_review"
            else DRAFT_MAX_COMPLETION_TOKENS
        )
        temperature = 0.1 if task == "claim_review" else 0.25
        retry_count = (
            CLAIM_REVIEW_RETRY_COUNT if task == "claim_review" else DRAFT_RETRY_COUNT
        )
        upstream_body = {
            "model": model,
            "temperature": temperature,
            "max_completion_tokens": max_completion_tokens,
            "response_format": {"type": "json_object"},
            "messages": [
                {
                    "role": "system",
                    "content": (
                        "You are an SEO writer. Respond with raw JSON only and no markdown fences."
                    ),
                },
                {
                    "role": "user",
                    "content": prompt,
                },
            ],
        }

        req = Request(
            endpoint,
            data=json.dumps(upstream_body).encode("utf-8"),
            headers={
                "Content-Type": "application/json",
                "Authorization": f"Bearer {api_key}",
            },
            method="POST",
        )

        last_error = None
        for attempt in range(retry_count + 1):
            try:
                with urlopen(req, timeout=timeout_seconds) as resp:
                    data = json.loads(resp.read().decode("utf-8"))
                break
            except HTTPError as exc:
                last_error = self.http_error_to_upstream(exc)
            except TimeoutError:
                last_error = UpstreamError(504, self.timeout_message(provider_name))
            except socket.timeout:
                last_error = UpstreamError(504, self.timeout_message(provider_name))
            except URLError as exc:
                if self.is_timeout_error(exc.reason):
                    last_error = UpstreamError(504, self.timeout_message(provider_name))
                else:
                    last_error = UpstreamError(502, f"{provider_name} request failed: {exc.reason}")
            except ConnectionResetError as exc:
                last_error = UpstreamError(502, f"{provider_name} request failed: {exc}")
            if not self.should_retry_upstream(last_error, attempt, retry_count):
                raise last_error
            time.sleep(0.8 * (attempt + 1))
        else:
            raise last_error
        if last_error is not None and "data" not in locals():
            raise last_error

        choice = ((data.get("choices") or [{}])[0]).get("message", {})
        content = choice.get("content", "")
        if isinstance(content, list):
            return "".join(str(part.get("text", "")) for part in content if isinstance(part, dict))
        return str(content or "")

    def request_gemini(self, prompt: str, *, task: str) -> str:
        endpoint = (
            "https://generativelanguage.googleapis.com/v1beta/models/"
            f"{GEMINI_MODEL}:generateContent"
        )
        timeout_seconds = (
            CLAIM_REVIEW_TIMEOUT_SECONDS
            if task == "claim_review"
            else UPSTREAM_TIMEOUT_SECONDS
        )
        max_output_tokens = (
            CLAIM_REVIEW_MAX_COMPLETION_TOKENS
            if task == "claim_review"
            else DRAFT_MAX_COMPLETION_TOKENS
        )
        temperature = 0.1 if task == "claim_review" else 0.25
        retry_count = (
            CLAIM_REVIEW_RETRY_COUNT if task == "claim_review" else DRAFT_RETRY_COUNT
        )
        upstream_body = {
            "contents": [
                {
                    "parts": [
                        {
                            "text": (
                                "You are an SEO writer. Respond with raw JSON only and no markdown fences.\n\n"
                                + prompt
                            )
                        }
                    ]
                }
            ],
            "generationConfig": {
                "temperature": temperature,
                "maxOutputTokens": max_output_tokens,
                "responseMimeType": "application/json",
            },
        }

        req = Request(
            endpoint,
            data=json.dumps(upstream_body).encode("utf-8"),
            headers={
                "Content-Type": "application/json",
                "x-goog-api-key": GEMINI_API_KEY,
            },
            method="POST",
        )

        last_error = None
        for attempt in range(retry_count + 1):
            try:
                with urlopen(req, timeout=timeout_seconds) as resp:
                    data = json.loads(resp.read().decode("utf-8"))
                break
            except HTTPError as exc:
                last_error = self.http_error_to_upstream(exc)
            except TimeoutError:
                last_error = UpstreamError(504, self.timeout_message("Gemini"))
            except socket.timeout:
                last_error = UpstreamError(504, self.timeout_message("Gemini"))
            except URLError as exc:
                if self.is_timeout_error(exc.reason):
                    last_error = UpstreamError(504, self.timeout_message("Gemini"))
                else:
                    last_error = UpstreamError(502, f"Gemini request failed: {exc.reason}")
            except ConnectionResetError as exc:
                last_error = UpstreamError(502, f"Gemini request failed: {exc}")
            if not self.should_retry_upstream(last_error, attempt, retry_count):
                raise last_error
            time.sleep(0.8 * (attempt + 1))
        else:
            raise last_error
        if last_error is not None and "data" not in locals():
            raise last_error

        candidate = (data.get("candidates") or [{}])[0]
        content = candidate.get("content", {})
        parts = content.get("parts", [])
        return "".join(str(part.get("text", "")) for part in parts if isinstance(part, dict))

    def http_error_to_upstream(self, exc: HTTPError):
        try:
            body = exc.read().decode("utf-8")
            parsed = json.loads(body)
            message = (
                parsed.get("error", {}).get("message")
                or parsed.get("error", {}).get("status")
                or body
            )
        except Exception:
            message = str(exc.reason)
        return UpstreamError(exc.code or 500, str(message))

    def is_timeout_error(self, reason) -> bool:
        text = str(reason).lower()
        return "timed out" in text or "timeout" in text

    def timeout_message(self, provider: str) -> str:
        return (
            f"{provider} request timed out while connecting to the upstream API. "
            "This is usually a network or TLS connectivity problem, not a writing-quality issue."
        )

    def should_retry_upstream(self, error: UpstreamError | None, attempt: int, retry_count: int) -> bool:
        if error is None or attempt >= retry_count:
            return False
        return error.status in {408, 429, 500, 502, 503, 504}

    def combine_upstream_errors(self, errors) -> UpstreamError:
        provider, exc = errors[-1]
        if len(errors) == 1:
            return exc
        details = " | ".join(f"{name}: {error.message}" for name, error in errors)
        return UpstreamError(exc.status, f"All configured providers failed. {details}")

    def pack_draft_payload(self, parsed: dict) -> str:
        return "\u001F".join(
            [
                str(parsed.get("title", "")),
                str(parsed.get("meta_description", "")),
                str(parsed.get("opening_answer", "")),
                str(parsed.get("opening_problem", "")),
                str(parsed.get("opening_value", "")),
                str(parsed.get("section_one_heading", "")),
                str(parsed.get("section_one_body", "")),
                str(parsed.get("section_two_heading", "")),
                str(parsed.get("section_two_body", "")),
                str(parsed.get("section_three_heading", "")),
                str(parsed.get("section_three_body", "")),
                str(parsed.get("key_points_heading", "")),
                "\n".join(parsed.get("key_points_items", []) or []),
                str(parsed.get("comparison_table_heading", "")),
                "\n".join(parsed.get("comparison_table_columns", []) or []),
                "\n".join(parsed.get("comparison_table_rows", []) or []),
                str(parsed.get("summary_heading", "")),
                str(parsed.get("summary_body", "")),
                str(parsed.get("faq_heading", "")),
                str(parsed.get("faq_one_question", "")),
                str(parsed.get("faq_one_answer", "")),
                str(parsed.get("faq_two_question", "")),
                str(parsed.get("faq_two_answer", "")),
                str(parsed.get("faq_three_question", "")),
                str(parsed.get("faq_three_answer", "")),
            ]
        )

    def pack_claim_review_payload(self, parsed: dict) -> str:
        claims = parsed.get("claims", [])
        records = []
        if not isinstance(claims, list):
            claims = []
        for item in claims:
            if not isinstance(item, dict):
                continue
            evidence_numbers = item.get("evidence_numbers", [])
            if isinstance(evidence_numbers, list):
                evidence_text = ",".join(str(value) for value in evidence_numbers)
            else:
                evidence_text = str(evidence_numbers or "")
            records.append(
                "\u001F".join(
                    [
                        str(item.get("claim_id", "")),
                        str(item.get("claim", "")),
                        str(item.get("verdict", "")),
                        evidence_text,
                        str(item.get("reason", "")),
                        str(item.get("rewrite", "")),
                    ]
                )
            )
        return "\u001E".join(records)

    def respond_json(self, status: int, payload: dict):
        body = json.dumps(payload).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def configured_provider_chain(self) -> str:
        configured = []
        if DEEPSEEK_API_KEY != "":
            configured.append("DeepSeek")
        if GEMINI_API_KEY != "":
            configured.append("Gemini")
        if API_KEY != "":
            configured.append("OpenAI-compatible")
        return " -> ".join(configured) if configured else "none"


if __name__ == "__main__":
    provider = MoonSEOHandler.configured_provider_chain(MoonSEOHandler)
    server = ThreadingHTTPServer((HOST, PORT), MoonSEOHandler)
    print(f"Serving MoonSEO on http://{HOST}:{PORT}/ (provider: {provider})")
    server.serve_forever()
