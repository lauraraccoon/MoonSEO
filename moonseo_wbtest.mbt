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

///|
test "build_ai_prompt includes long-form opening and keyword placement guidance" {
  let prompt = build_ai_prompt(
    "Best Gift Card App in Canada", "Snaplii", "best gift card app in canada", "consumers",
    "Instant cashback, not points", "Write from a consumer perspective", "en",
  )
  assert_true(prompt.contains("Keep the full draft around 1400 to 1700 words."))
  assert_true(
    prompt.contains(
      "Mention the brand at least once in the first 100 words, and place the primary keyword in both the title and the first 100 words.",
    ),
  )
  assert_true(
    prompt.contains(
      "In the first 40 to 80 words, lead with the conclusion or direct answer.",
    ),
  )
}

///|
test "build_ai_prompt forbids competitor brand names in comparisons" {
  let prompt = build_ai_prompt(
    "Best Gift Card App in Canada", "Snaplii", "", "consumers", "Instant cashback, not points",
    "", "en",
  )
  assert_true(
    prompt.contains(
      "For comparison language, use generic alternatives only and never mention competitor brand names.",
    ),
  )
}

///|
test "build_ai_prompt now requires faq fields in ai payload schema" {
  let prompt = build_ai_prompt(
    "Best Gift Card App in Canada", "Snaplii", "", "consumers", "Instant cashback, not points",
    "", "en",
  )
  assert_true(prompt.contains("faq_heading"))
  assert_true(prompt.contains("faq_one_question"))
  assert_true(prompt.contains("faq_three_answer"))
}

///|
test "payload value for english falls back when cjk is present" {
  let value = payload_value_for_lang(
    ["English text with 消费场景"],
    0,
    "Fallback english field",
    "en",
  )
  assert_eq(value, "Fallback english field")
}
