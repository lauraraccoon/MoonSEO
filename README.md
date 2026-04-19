---
title: MoonSEO
emoji: "🌙"
colorFrom: blue
colorTo: indigo
sdk: docker
app_port: 4173
---

# MoonSEO

MoonSEO is a MoonBit-first SEO landing-page copilot built for the 2026 MoonBit
Software Challenge Contest. It turns a short product brief plus approved source
material into an editable English landing page draft, keeps the draft grounded
to visible evidence, runs deterministic SEO and claim checks, and exports a
clean static HTML result.

## Live Demo

[https://lauraraccoon2-moonseo.hf.space/web/](https://lauraraccoon2-moonseo.hf.space/web/)

## What The Project Does

MoonSEO focuses on a practical writing workflow rather than a generic chatbot.
The current product flow is:

1. Start from a brand website, uploaded source files, and a short writing brief
2. Ask an LLM for a draft payload while keeping the output shape constrained
3. Render the article inside a MoonBit-driven web UI
4. Show claim grounding and SEO checks in the right audit rail
5. Let the user edit the draft inline
6. Export a standalone HTML landing page

## Current Features

- Website ingestion from the official site URL
- Optional source upload for TXT, MD, PDF, DOC, and DOCX materials
- AI-assisted landing-page draft generation
- MoonBit-side draft shaping, section rendering, and HTML export
- Claim-by-claim fact grounding with source references
- Deterministic SEO checks for title, slug, meta description, heading structure,
  body length, keyword distribution, and expression risk
- Inline editing in the preview pane before export
- Bilingual UI switching for Chinese and English interface text

## Why MoonBit

MoonBit is not only used for a small rules module here. In this project it owns
the product-critical deterministic layer:

- Draft rendering and article structure assembly
- SEO audit generation
- Claim review parsing and UI-ready report building
- Export HTML generation
- Browser-side application logic through the JS target and `extern "js"`
  bindings

Core implementation is concentrated in:

- [moonseo.mbt](/Users/apple/Desktop/MoonSEO/moonseo.mbt)
- [cmd/web/main.mbt](/Users/apple/Desktop/MoonSEO/cmd/web/main.mbt)
- [web/styles.css](/Users/apple/Desktop/MoonSEO/web/styles.css)
- [scripts/dev_server.py](/Users/apple/Desktop/MoonSEO/scripts/dev_server.py)

## Local Run

Make sure MoonBit is installed and available in `~/.moon/bin`.

Set at least one provider API key in your shell:

- `DEEPSEEK_API_KEY`
- `OPENAI_API_KEY`
- `GEMINI_API_KEY`

Then start the local demo:

```bash
./scripts/start_demo.sh
```

Open:

```text
http://127.0.0.1:4173/web/
```

## Hosted Run

For hosted environments:

```bash
HOST=0.0.0.0 PORT=4173 ./scripts/start_hosted.sh
```

This repo also includes:

- [Dockerfile](/Users/apple/Desktop/MoonSEO/Dockerfile)
- [render.yaml](/Users/apple/Desktop/MoonSEO/render.yaml)
- [Procfile](/Users/apple/Desktop/MoonSEO/Procfile)

## Recommended Validation

The most relevant checks for the current web flow are:

```bash
moon build cmd/web --target js
bash ./scripts/prepare_web_bundle.sh
```

Optional project checks:

```bash
moon check --target js
moon test --target js
moon info --target js
moon fmt
```

Note: `moon test` without `--target js` is not suitable for the browser entry
package because `extern "js"` bindings are intentionally used in the web app.

## Project Structure

```text
moonseo.mbt              Core draft shaping, audits, claim review, export HTML
cmd/web/main.mbt         Browser entrypoint and DOM bridges
cmd/web/ui_state.mbt     Frontend state helpers
cmd/web/audit_interactions.mbt
web/index.html           Demo shell
web/styles.css           Product UI styling
web/app.js               Built browser bundle
scripts/dev_server.py    Local/hosted server and provider bridge
scripts/start_demo.sh    Local startup script
scripts/start_hosted.sh  Hosted startup script
```

## Known Limitations

- The product is still an MVP tuned for evaluation and demo scenarios
- Draft quality depends on upstream model latency and provider stability
- Claim grounding currently prioritizes speed and visible traceability over a
  full research workflow
- The editing experience is intentionally lightweight, not a full document editor

## Competition Submission Notes

This repository is optimized around four evaluation goals:

- Project completeness
- Engineering quality
- Explainability
- User experience

To support explainability, the project keeps deterministic logic in MoonBit,
surfaces source-backed claim references in the UI, and exports a clean static
artifact that can be inspected independently from the web app.
