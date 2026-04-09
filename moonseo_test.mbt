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
test "generate_demo renders key points bullet list" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.article_html.contains("<ul class=\"article-bullets\">"))
  assert_true(draft.article_html.contains("<li class=\"editable-field\""))
}

///|
test "generate_demo renders comparison table" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.article_html.contains("<table class=\"article-table\">"))
  assert_true(draft.article_html.contains("<td class=\"editable-field\""))
}

///|
test "generate_demo renders body h3 subheadings" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(
    draft.article_html.contains(
      "<h3 class=\"editable-field article-subheading\"",
    ),
  )
  assert_true(draft.article_html.contains("The Clearest Way To"))
}

///|
test "generate_demo renders summary section before faq" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
  )
  assert_true(draft.article_html.contains("Where Northstar AI fits best"))
  assert_true(
    draft.article_html.contains(
      "Northstar AI becomes easier to judge when its practical value",
    ),
  )
  assert_true(draft.article_html.contains("Frequently asked questions"))
}

///|
test "generate_demo does not leak instruction-style h3 text" {
  let (draft, _) = @moonseo.generate_demo(
    "", "Northstar AI", "seo content audit", "growth teams", "",
  )
  assert_false(draft.article_html.contains("The Closing Section Should"))
  assert_false(draft.article_html.contains("Rather Than Forcing"))
}

///|
test "summary body renders as multiple short paragraphs" {
  let payload = "Custom comparison title\u001FCompact meta description for tests\u001FOpening answer\u001FOpening problem\u001FOpening value\u001FSection one\u001FFirst body paragraph. Second body paragraph.\u001FSection two\u001FSecond section body. Another supported detail.\u001FSection three\u001FThird section body. Final verification note.\u001FKey points\u001FFirst point\nSecond point\u001FComparison\u001FFeature\nThis option\nGeneric alternative\u001FFit range | Wide support | Narrower support\nMounting | Clamp and grommet | Clamp only\u001FWhere this fits best\u001FFirst summary point. Second summary point.\n\nFinal caveat sentence. Decision guidance sentence.\u001FFAQ\u001FQuestion one\u001FYes. Because of supported details.\u001FQuestion two\u001FNo. Because it depends on setup.\u001FQuestion three\u001FYes. Because the sources cover it."
  let (draft, _) = @moonseo.generate_ai_demo_localized(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
    "", payload, "en",
  )
  assert_true(
    draft.article_html.contains(
      "<p class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">First summary point. Second summary point.</p><p class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">Final caveat sentence. Decision guidance sentence.</p>",
    ),
  )
}

///|
test "generate_ai_demo omits comparison table when notes forbid it" {
  let payload = "Custom comparison title\u001FCompact meta description for tests\u001FOpening answer\u001FOpening problem\u001FOpening value\u001FSection one\u001FFirst body paragraph. Second body paragraph.\u001FSection two\u001FSecond section body. Another supported detail.\u001FSection three\u001FThird section body. Final verification note.\u001FKey points\u001FFirst point\nSecond point\u001FComparison\u001FFeature\nThis option\nGeneric alternative\u001FFit range | Wide support | Narrower support\nMounting | Clamp and grommet | Clamp only\u001FWhy this fits real buyers\u001FSummary body before faq.\u001FFAQ\u001FQuestion one\u001FYes. Because of supported details.\u001FQuestion two\u001FNo. Because it depends on setup.\u001FQuestion three\u001FYes. Because the sources cover it."
  let (draft, _) = @moonseo.generate_ai_demo_localized(
    "", "Northstar AI", "seo content audit", "growth teams", "Publishes in 1 click\nKeeps claims aligned with approved facts\nExports static HTML",
    "不要表格", payload, "en",
  )
  assert_true(!draft.article_html.contains("<table class=\"article-table\">"))
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
