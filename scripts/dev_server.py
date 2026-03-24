#!/usr/bin/env python3
import json
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parent.parent
HOST = "127.0.0.1"
PORT = 4173
DEFAULT_BASE_URL = os.environ.get("MOONSEO_OPENAI_BASE_URL", "https://api.openai.com/v1")
DEFAULT_MODEL = os.environ.get("MOONSEO_OPENAI_MODEL", "gpt-4.1-mini")
API_KEY = os.environ.get("OPENAI_API_KEY", "")


class MoonSEOHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def do_POST(self):
        if self.path != "/api/draft":
            self.send_error(404, "Not found")
            return

        length = int(self.headers.get("Content-Length", "0"))
        raw = self.rfile.read(length)
        try:
            payload = json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            self.respond_json(400, {"error": "Invalid JSON body."})
            return

        prompt = str(payload.get("prompt", "")).strip()
        if prompt == "":
            self.respond_json(400, {"error": "Prompt is required."})
            return
        if API_KEY == "":
            self.respond_json(500, {"error": "OPENAI_API_KEY is not configured on the local server."})
            return

        endpoint = DEFAULT_BASE_URL.rstrip("/") + "/chat/completions"
        upstream_body = {
            "model": DEFAULT_MODEL,
            "temperature": 0.7,
            "messages": [
                {
                    "role": "system",
                    "content": "You are an SEO writer. Respond with raw JSON only and no markdown fences.",
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
                "Authorization": f"Bearer {API_KEY}",
            },
            method="POST",
        )

        try:
            with urlopen(req, timeout=60) as resp:
                data = json.loads(resp.read().decode("utf-8"))
        except HTTPError as exc:
            try:
                body = exc.read().decode("utf-8")
                parsed = json.loads(body)
                message = parsed.get("error", {}).get("message", body)
            except Exception:
                message = exc.reason
            self.respond_json(exc.code or 500, {"error": str(message)})
            return
        except URLError as exc:
            self.respond_json(502, {"error": f"Upstream request failed: {exc.reason}"})
            return

        choice = ((data.get("choices") or [{}])[0]).get("message", {})
        content = choice.get("content", "")
        if isinstance(content, list):
            text = "".join(str(part.get("text", "")) for part in content if isinstance(part, dict))
        else:
            text = str(content or "")

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

        packed = "\u001F".join(
            [
                str(parsed.get("title", "")),
                str(parsed.get("meta_description", "")),
                str(parsed.get("intro", "")),
                str(parsed.get("section_one_heading", "")),
                str(parsed.get("section_one_body", "")),
                str(parsed.get("section_two_heading", "")),
                str(parsed.get("section_two_body", "")),
                str(parsed.get("section_three_heading", "")),
                str(parsed.get("section_three_body", "")),
            ]
        )
        self.respond_json(200, {"payload": packed})

    def respond_json(self, status: int, payload: dict):
        body = json.dumps(payload).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == "__main__":
    server = ThreadingHTTPServer((HOST, PORT), MoonSEOHandler)
    print(f"Serving MoonSEO on http://{HOST}:{PORT}/")
    server.serve_forever()
