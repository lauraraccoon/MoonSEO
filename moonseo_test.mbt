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
    "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.slug.contains("seo-content-audit"))
  assert_true(draft.article_html.contains("<h2>"))
  assert_true(draft.export_html.contains("<!DOCTYPE html>"))
  assert_true(report.score >= 80)
}
