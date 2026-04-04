///|
test "parse_facts removes blank lines" {
  let facts = @moonseo.parse_facts(
    "Fast static export\n\nBuilt-in SEO audit \n  \nEvidence anchors",
  )
  assert_eq(facts.length(), 3)
  assert_eq(facts[1], "Built-in SEO audit")
}

///|
test "generate_demo returns article artifacts" {
  let (draft, report) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.slug.contains("seo-content-audit"))
  assert_true(draft.article_html.contains("<h2"))
  assert_true(draft.export_html.contains("<!DOCTYPE html>"))
  assert_eq(report.total_count, 8)
  assert_true(report.pass_count >= 1)
}

///|
test "generate_demo uses custom article title when provided" {
  let (draft, _) = @moonseo.generate_demo(
    "Custom SEO Title", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_eq(draft.title, "Custom SEO Title")
  assert_true(draft.slug.contains("custom-seo-title"))
}

///|
test "generate_demo does not invent fallback source facts" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "",
  )
  assert_eq(draft.evidence_count, 0)
  assert_eq(draft.claims.length(), 7)
  assert_true(!draft.article_html.contains("approved facts."))
  assert_true(!draft.article_html.contains("Search intent focus"))
  assert_true(!draft.article_html.contains("SEO checklist"))
}

///|
test "generate_demo now includes faq section" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.article_html.contains("Frequently asked questions"))
  assert_true(draft.article_html.contains("<div class=\"faq-item\">"))
}

///|
test "generate_demo renders opening as three editable paragraphs" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.article_html.contains("claim-C1"))
  assert_true(
    draft.article_html.contains("This guide uses the approved source material"),
  )
}

///|
test "has_real_sources only treats actual source text as source material" {
  assert_true(!@moonseo.has_real_sources(""))
  assert_true(@moonseo.has_real_sources("Official website copy"))
}
