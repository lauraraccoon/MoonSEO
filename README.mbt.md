# MoonSEO

MoonSEO is a MoonBit-first MVP for the 2026 Software Challenge Contest (SCC).
It turns a short brand brief into a grounded SEO landing page draft, audits that
draft with deterministic checks, and exports a static HTML deliverable.

## Current MVP

- Input a brand name, primary keyword, audience, and approved facts
- Generate a controlled SEO page draft in the browser
- Run a MoonBit audit for:
  title length, slug hygiene, meta description, body length, keyword footprint,
  heading structure, claim safety, and evidence coverage
- Preview the final static landing page
- Export the generated page as a standalone HTML file

## What MoonBit Does

MoonBit is not just a small helper module in this prototype. It currently owns:

- Draft generation logic
- SEO rule evaluation
- Evidence anchor rendering
- Static HTML export generation
- Browser-side UI behavior through the JS target and `extern "js"` bindings

Core implementation lives in:

- [moonseo.mbt](/Users/apple/Desktop/MoonSEO/moonseo.mbt)
- [cmd/web/main.mbt](/Users/apple/Desktop/MoonSEO/cmd/web/main.mbt)

## How To Run

Make sure MoonBit is installed and available in `~/.moon/bin`.

From the project root:

```bash
./scripts/start_demo.sh
```

Then open:

```text
http://localhost:4173/web/
```

The script will:

1. Build the browser entrypoint with MoonBit
2. Sync the browser bundle to `web/app.js`
3. Start a local static server on port `4173`

## Online / Hosted Run

The hosted version now builds the browser bundle at startup inside the container
or process host, so the compiled JS bundle is no longer checked into Git.

The demo server respects standard hosting env vars:

- `HOST` or `MOONSEO_HOST`
- `PORT` or `MOONSEO_PORT`
- `DEEPSEEK_API_KEY`, `OPENAI_API_KEY`, or `GEMINI_API_KEY`

### Docker platforms

This repository now includes a [Dockerfile](/Users/apple/Desktop/MoonSEO/Dockerfile),
so the easiest deployment path is:

1. Connect the GitHub repo to a Docker-friendly host such as Render or Railway
2. Set your model API keys in the host environment
3. Deploy and open:

```text
https://<your-app-domain>/web/
```

### Render Blueprint

This repository also includes [render.yaml](/Users/apple/Desktop/MoonSEO/render.yaml),
so Render can create the web service directly from the repo.

On Render:

1. Choose `New +` -> `Blueprint`
2. Select this GitHub repository
3. Keep the generated web service
4. Fill at least one of:
   - `DEEPSEEK_API_KEY`
   - `OPENAI_API_KEY`
   - `GEMINI_API_KEY`
5. Deploy, then open:

```text
https://<your-render-domain>/web/
```

### Plain process hosts

If your platform prefers a process command or `Procfile`, use:

```bash
HOST=0.0.0.0 PORT=4173 ./scripts/start_hosted.sh
```

This repository also includes a [Procfile](/Users/apple/Desktop/MoonSEO/Procfile)
for platforms that support it.

Once the app is deployed, add the public URL near the top of this README, for
example:

```md
## Live Demo

[https://your-moonseo-demo.example.com/web/](https://your-moonseo-demo.example.com/web/)
```

## Validation

These commands are currently passing for the JS target:

```bash
moon check --target js
moon test --target js
moon build cmd/web --target js
moon info --target js
```

## Project Structure

```text
moonseo.mbt            # Draft generation, audit logic, export rendering
cmd/web/main.mbt       # Browser entrypoint and DOM bindings
cmd/main/main.mbt      # Simple CLI smoke entrypoint
web/index.html         # Demo shell
web/styles.css         # Demo styling
scripts/start_demo.sh  # Local demo startup script
```

## Current Scope

This version is intentionally a competition MVP, not a full product.

It currently uses MoonBit-driven template generation rather than a live LLM API.
That makes the demo more stable, more deterministic, and better for showing the
value of MoonBit in generation, auditing, and export.

## Next Iterations

- Improve the evaluator-facing page copy and demo narrative
- Make the generated copy feel closer to real SEO deliverables
- Optionally add an LLM layer for richer drafting while keeping MoonBit in
  charge of deterministic auditing and export
