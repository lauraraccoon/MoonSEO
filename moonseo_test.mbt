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
  assert_true(draft.article_html.contains("<h2>"))
  assert_true(draft.export_html.contains("<!DOCTYPE html>"))
  assert_true(report.score >= 80)
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
}

///|
test "has_real_sources only treats actual source text as source material" {
  assert_true(!@moonseo.has_real_sources(""))
  assert_true(@moonseo.has_real_sources("Official website copy"))
}
