///|
test "export filename ends with html" {
  let (draft, _) = generate_demo(
    "", "Orbit", "seo workflow", "content marketers", "Supports local review\nKeeps a clean HTML output",
  )
  assert_true(export_filename(draft).has_suffix(".html"))
}

///|
test "build_ai_prompt defaults to English even in zh UI" {
  let prompt = build_ai_prompt(
    "Best Gift Card App in Canada", "Snaplii", "", "consumers", "Instant cashback, not points",
    "从行业专家角度来写", "zh",
  )
  assert_true(
    prompt.contains("Default to polished, publishable English prose."),
  )
  assert_true(
    !prompt.contains(
      "全文必须使用自然、完整、专业的简体中文",
    ),
  )
}

///|
test "build_ai_prompt switches to Chinese only when notes ask for it" {
  let prompt = build_ai_prompt(
    "Best Gift Card App in Canada", "Snaplii", "", "consumers", "Instant cashback, not points",
    "请用简体中文写作", "en",
  )
  assert_true(
    prompt.contains("全文必须使用自然、完整、专业的简体中文"),
  )
}

///|
test "draft prompt facts strip checklist markers" {
  let facts = draft_prompt_facts([
    "断言 / 内容 判断 备注 / 正确写法提示 Snaplii 是一个平台 ✅ 正确 ❌ 不可写",
  ])
  assert_eq(facts.length(), 1)
  assert_true(!facts[0].contains("✅"))
  assert_true(!facts[0].contains("正确写法提示"))
}
