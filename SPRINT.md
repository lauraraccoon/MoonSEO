# MoonSEO Sprint Plan

This sprint covers the roughly 20-day push toward the MoonBit 2026 Software
Synthesis Challenge submission and demo. The goal is not just to add features,
but to raise the project to a level that can compete for an excellence award.

## North Star

- Build a demo that feels like a real, focused product rather than an AI toy.
- Keep the main logic on the MoonBit side, with JS as thin DOM/network bridges.
- Prioritize real user value over feature count.

## Priority Lines

### A. Source Ingestion

Goal: make uploaded sources and website content reliable, visible, and truly
usable in generation and review.

Current pain points:

- Fact sheet format support is weak.
- Users cannot clearly tell what content was actually parsed and used.
- Uploaded materials still feel like an attachment workflow instead of a source
  pipeline.

Target outcomes:

- Stable support for the highest-value formats: TXT, MD, PDF, DOCX.
- Clear source states: parsed, attached-but-not-parsed, failed.
- A visible source preview so users can inspect what the system actually read.
- Website copy and uploaded source text flow through one consistent source
  pipeline.

### B. Generation Quality

Goal: raise output quality until the draft feels close to the user's normal
standard when using strong AI writing workflows.

Current pain points:

- Drafts still drift into generic SEO language.
- Brand, audience, and framing can still be polluted by defaults.
- The copy often sounds templated instead of grounded and intentional.

Target outcomes:

- Clear separation between facts, writing instructions, and forbidden behavior.
- Better prompt structure and pre-generation fact organization.
- Guardrails against brand drift, audience drift, and unrelated SEO framing.
- At least one benchmark brand example that feels truly demo-ready.

### C. Review and Interaction

Goal: make the product easy to understand in a short demo and easy to trust in
real usage.

Current pain points:

- The review panel still has room to become more intuitive.
- Evidence and claim relationships are better than before, but not yet perfect.
- AI rewrite and manual editing need to feel like one workflow.

Target outcomes:

- Faster understanding of claim review, evidence, and rewrite flow.
- Cleaner right-rail information hierarchy.
- Smooth editing flow from AI suggestion to manual final polish.
- Stable demo path from source input to export.

## Time Allocation

- Source ingestion: 35%
- Generation quality: 40%
- Review and interaction: 25%

The most important rule is: if time becomes tight, protect generation quality
and source reliability first.

## Milestones

### Milestone 1: Source Pipeline and Prompt Reset

Target:

- Source ingestion works for the most important formats.
- Source status becomes visible.
- Prompt structure gets its first major rewrite.

Done means:

- Most real source files used for testing can be parsed or clearly reported.
- Users can tell which sources were actually used.
- Prompt v1 no longer relies on stale defaults like unrelated SEO framing.

### Milestone 2: Demo-Quality Draft Flow

Target:

- Draft quality reaches a demoable baseline.
- Claim review path feels understandable.
- At least one brand case can be shown end to end with confidence.

Done means:

- A full flow works: source -> draft -> review -> rewrite -> manual edit ->
  export.
- The draft no longer feels obviously templated or polluted.
- One benchmark case is strong enough for external demo.

### Milestone 3: Award-Ready Demo Pack

Target:

- Two to three stable benchmark cases.
- README, screenshots, and demo narrative are ready.
- The product feels coherent and intentionally built.

Done means:

- Demo path is stable and easy to explain.
- Two to three examples are good enough to reuse in submission material or
  presentation.
- Engineering story and user story line up cleanly.

## What Counts as Off-Track

The sprint is considered off-track if we start spending large amounts of time
on any of the following before A/B/C priorities are in good shape:

- Fancy visual polish that does not improve the core demo path.
- Broad platform features such as CMS-like workflows or multi-channel publishing.
- Large refactors with little visible product or evaluation value.
- Edge-case feature work that does not improve ingestion, generation quality, or
  review clarity.

## How to Evaluate New Requests

Every new task should be tagged mentally as one of:

- A-line: source ingestion
- B-line: generation quality
- C-line: review and interaction
- Not-now work

When a request does not clearly move A, B, or C forward, it should be
challenged before implementation.

## Operating Rules

- Prefer small, meaningful commits.
- Prefer visible improvements over abstract cleanup.
- Keep MoonBit ownership clear when implementing logic changes.
- Keep at least one benchmark demo case working at all times.
- Do not trade away reliability for novelty during the sprint.
