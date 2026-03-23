///|
test "export filename ends with html" {
  let (draft, _) = generate_demo(
    "",
    "Orbit", "seo workflow", "content marketers", "Supports local review\nKeeps a clean HTML output",
  )
  assert_true(export_filename(draft).has_suffix(".html"))
}
