///|
pub struct ClaimAnchor {
  id : String
  text : String
} derive(Show)

///|
pub struct Draft {
  title : String
  slug : String
  meta_description : String
  article_html : String
  evidence_html : String
  preview_html : String
  export_html : String
  plain_text : String
  keyword : String
  evidence_count : Int
  claims : Array[ClaimAnchor]
} derive(Show)

///|
pub struct AuditFinding {
  title : String
  passed : Bool
  detail : String
} derive(Show)

///|
pub struct AuditReport {
  score : Int
  pass_count : Int
  total_count : Int
  summary_text : String
  summary_html : String
  findings_html : String
} derive(Show)

///|
pub struct ClaimReviewReport {
  supported_count : Int
  needs_review_count : Int
  unsupported_count : Int
  total_count : Int
  audit_available : Bool
  summary_html : String
  findings_html : String
} derive(Show)

///|
pub fn parse_facts(raw : String) -> Array[String] {
  let facts = []
  let normalized = raw.replace_all(old="\r", new="")
  for line in normalized.split("\n") {
    let trimmed = line.to_string().trim().to_string()
    if trimmed != "" {
      facts.push(trimmed)
    }
  }
  facts
}

///|
pub fn has_real_sources(facts_raw : String) -> Bool {
  parse_facts(facts_raw).length() > 0
}

///|
pub fn localized_ai_error(message : String, lang : String) -> String {
  let trimmed = message.trim().to_string()
  if !is_chinese_ui(lang) || trimmed == "" {
    return trimmed
  }
  let lower = trimmed.to_lower()
  if lower.contains("request timed out while connecting to the upstream api") ||
    lower.contains("timed out while connecting to the upstream api") {
    "连接上游 AI 服务超时，通常是网络或 TLS 连通性问题，不是内容质量问题。原始错误：\{trimmed}"
  } else if lower.contains("network or tls connectivity problem") {
    "AI 服务连接异常，通常是网络或 TLS 连通性问题，不是内容质量问题。原始错误：\{trimmed}"
  } else if lower.contains("returned an empty payload") {
    "AI 服务返回了空结果，请稍后重试。原始错误：\{trimmed}"
  } else if lower.contains("request failed with status") {
    "AI 请求失败，请稍后重试。原始错误：\{trimmed}"
  } else if lower.contains("unknown request error") {
    "AI 请求出现未知错误，请稍后重试。"
  } else {
    trimmed
  }
}

///|
pub fn generate_demo(
  article_title : String,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
) -> (Draft, AuditReport) {
  generate_demo_localized(
    article_title, brand_name, primary_keyword, audience, facts_raw, "en",
  )
}

///|
pub fn generate_demo_localized(
  article_title : String,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
  lang : String,
) -> (Draft, AuditReport) {
  ignore(lang)
  let chinese = false
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = inferred_keyword(
    primary_keyword, article_title, safe_brand,
  )
  let safe_audience = normalize_or_default(audience, "readers")
  let facts = parse_facts(facts_raw)
  let title = normalize_or_default(
    article_title,
    safe_generated_title(safe_keyword, safe_audience, "en"),
  )
  let slug = slugify(title)
  let first_fact = fact_or_empty(facts, 0)
  let second_fact = fact_or_empty(facts, 1)
  let third_fact = fact_or_empty(facts, 2)
  let opening_answer = if has_real_sources(facts_raw) {
    "\{safe_brand} stands out when the article answers the core question quickly and stays anchored in concrete product details readers can verify."
  } else {
    "\{safe_brand} needs a careful draft that answers the main question directly without drifting into unsupported marketing language."
  }
  let opening_problem = if has_real_sources(facts_raw) {
    "\{safe_audience} usually need clear proof of value, a simple explanation of how the experience works, and enough context to judge whether the product fits their needs."
  } else {
    "\{safe_audience} still need a practical overview of what matters most, even when the supporting source material has not been fully added yet."
  }
  let opening_value = if has_real_sources(facts_raw) {
    "This guide uses the approved source material to show what matters most, how the experience works, and which details deserve a closer look before deciding."
  } else {
    "This draft therefore stays conservative, focuses on the safest practical takeaways, and leaves room for later verification once real source material is available."
  }
  let opening = join_opening(opening_answer, opening_problem, opening_value)
  let section_one_heading = if chinese {
    "品牌概览"
  } else {
    "What \{safe_brand} offers"
  }
  let section_two_heading = if chinese {
    "使用体验"
  } else {
    "How the experience works"
  }
  let section_three_heading = if chinese {
    "补充说明"
  } else {
    "What readers should verify"
  }
  let key_points_heading = if chinese {
    "\{safe_brand} 的关键亮点"
  } else {
    "Key reasons to consider \{safe_brand}"
  }
  let comparison_table_heading = if chinese {
    "\{safe_brand} 对比速览"
  } else {
    "Quick comparison view"
  }
  let summary_heading = if chinese {
    "\{safe_brand} 更适合哪些人"
  } else {
    "Where \{safe_brand} fits best"
  }
  let faq_heading = if chinese {
    "常见问题"
  } else {
    "Frequently asked questions"
  }
  let section_one = if first_fact != "" {
    "The clearest way to introduce \{safe_brand} is to stay close to the product facts readers can verify. One concrete detail already available is: \{first_fact}. That gives the article a grounded starting point and keeps the opening focused on actual value instead of vague claims."
  } else {
    "The opening section should explain what \{safe_brand} helps users do and why that matters in practice. Without concrete source facts, the copy should stay careful, specific, and free of broad promises."
  }
  let section_two = if second_fact != "" && third_fact != "" {
    "\{safe_brand} becomes more credible when the article explains how the experience works in concrete terms. Here, the available materials point to details such as \{second_fact} and \{third_fact}. Framing those points as practical user-facing benefits creates a clearer and more believable middle section."
  } else if first_fact != "" {
    "The middle section should translate the available product facts into a practical experience readers can picture. It should stay close to what the source material actually supports, rather than stretching those facts into category-wide claims."
  } else {
    "The middle section should focus on concrete usage and practical value, while avoiding any details the source material cannot support yet. This keeps the draft useful without pretending the missing evidence already exists."
  }
  let section_three = if first_fact != "" ||
    second_fact != "" ||
    third_fact != "" {
    "\{safe_brand} becomes more convincing when the article closes by separating clearly supported value from details that may still vary by user, merchant, or region. A careful final section can reinforce the strongest product advantages, explain who is most likely to benefit, and point out the main limitation readers should confirm before they rely on it."
  } else {
    "Even without dense source coverage, \{safe_brand} can still be presented responsibly by gathering the clearest takeaways and naming the limits of what is currently confirmed. That kind of ending helps readers leave with a practical impression instead of a sweeping claim that the materials cannot yet support."
  }
  let summary_body = if first_fact != "" ||
    second_fact != "" ||
    third_fact != "" {
    "For readers comparing options, \{safe_brand} becomes easier to judge when its practical value and everyday usage model are considered together. That makes the final section less about repeating claims and more about clarifying who will actually benefit most.\n\nThe most useful takeaway is usually the fit between the product's strongest supported advantages and the reader's real buying habits. If one key limitation or verification point still matters, this is the right place to surface it plainly before the FAQ."
  } else {
    "Before readers move into FAQs, \{safe_brand} benefits from one last section that gathers the clearest practical value in plain language. That helps the article land on a usable decision point instead of trailing off.\n\nIf some details still need confirmation, they should be framed as a practical reminder rather than a dramatic warning. Readers can then leave with a grounded sense of whether the product is worth exploring further."
  }
  let key_points_items = default_key_points(facts, safe_brand, "en")
  let comparison_table_columns = default_comparison_table_columns("en")
  let comparison_table_rows = default_comparison_table_rows(
    facts, safe_brand, safe_keyword, "en",
  )
  let faq_one_question = if chinese {
    "\{safe_brand} 适合追求即时返现的用户吗？"
  } else {
    "Is \{safe_brand} a strong fit for users who want immediate cashback?"
  }
  let faq_one_answer = if chinese {
    "是。只要来源事实已经支持即时返现、余额可见或下单抵扣，这些就足以说明它适合更关注实际价值的用户。"
  } else {
    "Yes. When the sources already support instant cashback, visible balances, or checkout value, those facts are enough to show why it fits readers who care about practical savings."
  }
  let faq_two_question = if chinese {
    "使用 \{safe_brand} 前还有哪些细节需要确认？"
  } else {
    "Are there still any details readers should verify before using \{safe_brand}?"
  }
  let faq_two_answer = if chinese {
    "是。商户覆盖、地区差异、支付方式和余额使用限制等细节，如果来源没有完全写清楚，就应提醒读者进一步确认。"
  } else {
    "Yes. Merchant coverage, regional differences, payment options, and balance limitations should still be verified whenever the available sources do not fully confirm them."
  }
  let faq_three_question = if chinese {
    "\{safe_brand} 的核心价值是否已经足够明确？"
  } else {
    "Is \{safe_brand}'s core value proposition already clear from the available sources?"
  }
  let faq_three_answer = if chinese {
    "是。只要来源事实已经说明返现机制、余额可见性或使用便利性，这些信息就足以支撑一篇围绕实际价值展开的品牌文章。"
  } else {
    "Yes. When the sources already explain cashback, balance visibility, or practical usability, those points are enough to support a value-led brand article."
  }
  let claims = build_claims(opening, section_one, section_two, section_three)
  let article_html = build_ai_article_html(
    title, opening_answer, opening_problem, opening_value, section_one_heading, section_one,
    key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns,
    comparison_table_rows, section_two_heading, section_two, section_three_heading,
    section_three, summary_heading, summary_body, faq_heading, faq_one_question,
    faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer,
    facts, safe_keyword, lang,
  )
  let description = meta_description(title, opening)
  let preview_html = build_preview_html(article_html)
  let plain_text = "\{title} \{opening} \{section_one} \{join_slice(key_points_items, 0, key_points_items.length())} \{join_slice(comparison_table_rows, 0, comparison_table_rows.length())} \{section_two} \{section_three} \{summary_body} \{faq_one_question} \{faq_one_answer} \{faq_two_question} \{faq_two_answer} \{faq_three_question} \{faq_three_answer}"
  let draft : Draft = {
    title,
    slug,
    meta_description: description,
    article_html,
    evidence_html: "",
    preview_html,
    export_html: build_export_html(title, description, article_html, slug, lang),
    plain_text,
    keyword: safe_keyword,
    evidence_count: facts.length(),
    claims,
  }
  let report = audit_draft(draft, lang)
  (draft, report)
}

///|
pub fn generate_ai_demo_localized(
  article_title : String,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
  notes_raw : String,
  ai_payload : String,
  lang : String,
) -> (Draft, AuditReport) {
  let output_lang = requested_output_lang(notes_raw)
  let chinese_output = output_lang == "zh"
  let omit_faq = notes_request_no_faq(notes_raw)
  let omit_key_points = notes_request_no_key_points(notes_raw)
  let omit_comparison_table = notes_request_no_comparison_table(notes_raw)
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = inferred_keyword(
    primary_keyword, article_title, safe_brand,
  )
  let safe_audience = normalize_or_default(audience, "readers")
  let facts = parse_facts(facts_raw)
  let parts = []
  for part in ai_payload.split("\u001F") {
    parts.push(part.to_string())
  }
  let first_fact = fact_or_empty(facts, 0)
  let second_fact = fact_or_empty(facts, 1)
  let third_fact = fact_or_empty(facts, 2)
  let opening_answer_fallback = if has_real_sources(facts_raw) {
    if chinese_output {
      "\{safe_brand} 更适合用结论先行的方式来介绍，这样读者能立刻明白它是否值得进一步了解。"
    } else {
      "\{safe_brand} is strongest when the article answers the core question immediately and stays anchored in concrete product value."
    }
  } else if chinese_output {
    "\{safe_brand} 需要一篇谨慎、具体、可信的品牌文章，而不是没有依据的营销文案。"
  } else {
    "\{safe_brand} needs a careful, specific, credible article rather than unsupported marketing copy."
  }
  let opening_problem_fallback = if has_real_sources(facts_raw) {
    if chinese_output {
      "对大多数读者来说，真正重要的不是空泛卖点，而是它提供了什么、怎么用、以及是否适合自己的场景。"
    } else {
      "Readers care less about generic category hype and more about what it offers, how it works, and whether it fits their real shopping needs."
    }
  } else if chinese_output {
    "在真实来源还不充分时，读者仍然需要一份围绕核心问题展开、而不是泛泛铺陈的概览。"
  } else {
    "Even when source support is still thin, readers still need a practical answer to the main question instead of vague setup copy."
  }
  let opening_value_fallback = if has_real_sources(facts_raw) {
    if chinese_output {
      "这篇文章会基于现有来源材料，帮助读者快速看清 \{safe_brand} 的核心价值、使用方式以及仍需确认的细节。"
    } else {
      "This guide uses the available source material to show \{safe_brand}'s core value, explain the experience clearly, and highlight the details readers should still verify."
    }
  } else if chinese_output {
    "因此草稿会先聚焦最可靠的结论，再明确哪些信息仍待核实。"
  } else {
    "The draft therefore focuses on the safest practical takeaways first and stays explicit about what still needs verification."
  }
  let section_one_heading_fallback = if chinese_output {
    "品牌概览"
  } else {
    "What \{safe_brand} offers"
  }
  let section_two_heading_fallback = if chinese_output {
    "使用体验"
  } else {
    "How the experience works"
  }
  let section_three_heading_fallback = if chinese_output {
    "补充说明"
  } else {
    "What readers should verify"
  }
  let key_points_heading_fallback = if chinese_output {
    "\{safe_brand} 的关键亮点"
  } else {
    "Key reasons to consider \{safe_brand}"
  }
  let comparison_table_heading_fallback = if chinese_output {
    "\{safe_brand} 对比速览"
  } else {
    "Quick comparison view"
  }
  let summary_heading_fallback = if chinese_output {
    "\{safe_brand} 更适合哪些人"
  } else {
    "Where \{safe_brand} fits best"
  }
  let faq_heading_fallback = if chinese_output {
    "常见问题"
  } else {
    "Frequently asked questions"
  }
  let section_one_body_fallback = if chinese_output && first_fact != "" {
    "介绍 \{safe_brand} 时，最重要的是先说清楚它到底提供了什么，而不是写成空泛的品类介绍。当前可确认的一条来源事实是：\{first_fact}。这能帮助草稿在开头建立一个更可信、更具体的切入点。"
  } else if chinese_output {
    "介绍 \{safe_brand} 时，最重要的是先说清楚它到底提供了什么，而不是写成空泛的品类介绍。在来源材料还不充分时，草稿应先围绕最实用、最容易被验证的信息展开。"
  } else if first_fact != "" {
    "The opening section should explain what \{safe_brand} actually offers instead of drifting into generic category language. One concrete source detail already available is: \{first_fact}. Using that detail as the starting point keeps the article grounded and specific."
  } else {
    "The opening section should explain what \{safe_brand} helps readers do in practical terms, while avoiding details the sources cannot support yet. That gives the draft a clear point of view without overclaiming."
  }
  let section_two_body_fallback = if chinese_output &&
    second_fact != "" &&
    third_fact != "" {
    "中间部分应把产品体验写得更具体，同时紧扣已知来源。当前材料里已经出现了这些细节：\{second_fact}；\{third_fact}。把这些信息转成清晰的用户价值，会让文章比空泛的卖点描述更可信。"
  } else if chinese_output {
    "中间部分应把产品体验写得更具体，同时紧扣已知来源。只要某些结论还没有明确依据，就应保持保守表达，不要把备注、判断或猜测写成既成事实。"
  } else if second_fact != "" && third_fact != "" {
    "The middle section should make the experience more concrete while staying close to the sources. The available material already points to details such as \{second_fact} and \{third_fact}. Translating those into practical user-facing benefits creates a more believable draft."
  } else {
    "The middle section should make the experience more concrete while staying close to the sources. When support is still thin, the copy should remain explicit about what is known and avoid turning notes or guesses into facts."
  }
  let section_three_body_fallback = if chinese_output {
    "把文章收束得自然，关键在于把已经明确的价值和仍需确认的限制分开说明。这样既能再次强调最可靠的卖点，也能提醒读者关注适用条件、使用边界或地区差异，让判断更稳妥。"
  } else {
    "The article lands better when it separates clearly supported value from the details that may still depend on setup, region, or user needs. That gives readers a grounded final impression, reinforces the strongest takeaways, and leaves room for the practical caution a careful buyer would expect."
  }
  let summary_body_fallback = if chinese_output {
    "\{safe_brand} 是否值得继续了解，往往取决于读者能否在 FAQ 前快速抓住核心价值和适用人群。把这些重点收拢成一个贴主题的小节，会让判断更直接。\n\n如果仍有需要确认的限制，也应该在这里顺手点明，但不要写成空泛结论。这样读者在进入 FAQ 前，就已经知道自己最该关注什么。"
  } else {
    "\{safe_brand} becomes easier to evaluate when the article pauses before the FAQ and gathers the strongest supported takeaways around fit and value. That gives readers a more useful checkpoint than a generic wrap-up.\n\nIf there is one limitation or verification point worth remembering, it should appear here in plain language. The result feels more like decision guidance and less like a formal conclusion."
  }
  let key_points_items_fallback = default_key_points(
    facts, safe_brand, output_lang,
  )
  let comparison_table_columns_fallback = default_comparison_table_columns(
    output_lang,
  )
  let comparison_table_rows_fallback = default_comparison_table_rows(
    facts, safe_brand, safe_keyword, output_lang,
  )
  let faq_one_question_fallback = if chinese_output {
    "\{safe_brand} 适合重视即时价值的用户吗？"
  } else {
    "Is \{safe_brand} a good fit for readers who care about immediate value?"
  }
  let faq_one_answer_fallback = if chinese_output {
    "是。只要来源事实能支撑即时返现、余额可见或下单抵扣，这些就已经构成了对用户最有感知的价值。"
  } else {
    "Yes. When the sources support instant cashback, visible balances, or checkout value, those are already meaningful benefits for readers who care about practical savings."
  }
  let faq_two_question_fallback = if chinese_output {
    "选择 \{safe_brand} 前还需要确认哪些信息？"
  } else {
    "What should readers still confirm before choosing \{safe_brand}?"
  }
  let faq_two_answer_fallback = if chinese_output {
    "需要确认。商户范围、地区差异、支付方式和余额使用限制等信息，只要来源没有完全覆盖，就应提醒读者再核实。"
  } else {
    "Readers should still confirm merchant coverage, regional differences, payment options, and balance limitations whenever those details are not fully established by the sources."
  }
  let faq_three_question_fallback = if chinese_output {
    "\{safe_brand} 的优势是否已经足够清楚？"
  } else {
    "Is \{safe_brand}'s main advantage already clear from the available material?"
  }
  let faq_three_answer_fallback = if chinese_output {
    "是。只要返现机制、使用便利性和余额可见性已经被来源事实说明清楚，就足以形成一篇围绕实际价值展开的文章。"
  } else {
    "Yes. When cashback, usability, and balance visibility are already supported by the sources, they are enough to anchor a value-led article."
  }
  let raw_ai_title = payload_value_for_lang(
    parts,
    0,
    safe_generated_title(safe_keyword, safe_audience, output_lang),
    output_lang,
  )
  let opening_answer = payload_value_for_lang(
    parts, 2, opening_answer_fallback, output_lang,
  )
  let opening_problem = payload_value_for_lang(
    parts, 3, opening_problem_fallback, output_lang,
  )
  let opening_value = payload_value_for_lang(
    parts, 4, opening_value_fallback, output_lang,
  )
  let opening = join_opening(opening_answer, opening_problem, opening_value)
  let ai_title = if article_title.trim().to_string() != "" {
    article_title.trim().to_string()
  } else {
    sanitize_generated_title(
      raw_ai_title, safe_keyword, safe_audience, output_lang,
    )
  }
  let ai_meta = clamp_meta_description(
    payload_value_for_lang(
      parts,
      1,
      meta_description(ai_title, opening),
      output_lang,
    ),
    ai_title,
    opening,
  )
  let section_one_heading = payload_value_for_lang(
    parts, 5, section_one_heading_fallback, output_lang,
  )
  let section_one_body = payload_value_for_lang(
    parts, 6, section_one_body_fallback, output_lang,
  )
  let section_two_heading = payload_value_for_lang(
    parts, 7, section_two_heading_fallback, output_lang,
  )
  let section_two_body = payload_value_for_lang(
    parts, 8, section_two_body_fallback, output_lang,
  )
  let section_three_heading = payload_value_for_lang(
    parts, 9, section_three_heading_fallback, output_lang,
  )
  let section_three_body = payload_value_for_lang(
    parts, 10, section_three_body_fallback, output_lang,
  )
  let key_points_heading = if omit_key_points {
    ""
  } else {
    payload_value_for_lang(parts, 11, key_points_heading_fallback, output_lang)
  }
  let key_points_items = if omit_key_points {
    []
  } else {
    payload_lines_for_lang(parts, 12, key_points_items_fallback, output_lang)
  }
  let comparison_table_heading = if omit_comparison_table {
    ""
  } else {
    payload_value_for_lang(
      parts, 13, comparison_table_heading_fallback, output_lang,
    )
  }
  let comparison_table_columns = if omit_comparison_table {
    []
  } else {
    payload_lines_for_lang(
      parts, 14, comparison_table_columns_fallback, output_lang,
    )
  }
  let comparison_table_rows = if omit_comparison_table {
    []
  } else {
    payload_lines_for_lang(
      parts, 15, comparison_table_rows_fallback, output_lang,
    )
  }
  let summary_heading = payload_value_for_lang(
    parts, 16, summary_heading_fallback, output_lang,
  )
  let summary_body = payload_value_for_lang(
    parts, 17, summary_body_fallback, output_lang,
  )
  let faq_heading = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 18, faq_heading_fallback, output_lang)
  }
  let faq_one_question = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 19, faq_one_question_fallback, output_lang)
  }
  let faq_one_answer = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 20, faq_one_answer_fallback, output_lang)
  }
  let faq_two_question = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 21, faq_two_question_fallback, output_lang)
  }
  let faq_two_answer = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 22, faq_two_answer_fallback, output_lang)
  }
  let faq_three_question = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 23, faq_three_question_fallback, output_lang)
  }
  let faq_three_answer = if omit_faq {
    ""
  } else {
    payload_value_for_lang(parts, 24, faq_three_answer_fallback, output_lang)
  }
  let claims = build_claims(
    opening, section_one_body, section_two_body, section_three_body,
  )
  let article_html = build_ai_article_html(
    ai_title, opening_answer, opening_problem, opening_value, section_one_heading,
    section_one_body, key_points_heading, key_points_items, comparison_table_heading,
    comparison_table_columns, comparison_table_rows, section_two_heading, section_two_body,
    section_three_heading, section_three_body, summary_heading, summary_body, faq_heading,
    faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question,
    faq_three_answer, facts, safe_keyword, lang,
  )
  let plain_text = "\{ai_title} \{opening} \{section_one_body} \{join_slice(key_points_items, 0, key_points_items.length())} \{join_slice(comparison_table_rows, 0, comparison_table_rows.length())} \{section_two_body} \{section_three_body} \{summary_body} \{faq_one_question} \{faq_one_answer} \{faq_two_question} \{faq_two_answer} \{faq_three_question} \{faq_three_answer}"
  let draft : Draft = {
    title: ai_title,
    slug: slugify(ai_title),
    meta_description: ai_meta,
    article_html,
    evidence_html: "",
    preview_html: build_preview_html(article_html),
    export_html: build_export_html(
      ai_title,
      ai_meta,
      article_html,
      slugify(ai_title),
      lang,
    ),
    plain_text,
    keyword: safe_keyword,
    evidence_count: facts.length(),
    claims,
  }
  let report = audit_draft(draft, lang)
  (draft, report)
}

///|
pub fn audit_report_for_ui(draft : Draft, lang : String) -> AuditReport {
  audit_draft(draft, lang)
}

///|
pub fn audit_report_for_rendered(
  title : String,
  meta_description : String,
  slug : String,
  article_html : String,
  plain_text : String,
  keyword : String,
  evidence_count : Int,
  lang : String,
) -> AuditReport {
  audit_draft(
    {
      title,
      slug,
      meta_description,
      article_html,
      evidence_html: "",
      preview_html: "",
      export_html: "",
      plain_text,
      keyword,
      evidence_count,
      claims: [],
    },
    lang,
  )
}

///|
pub fn claim_review_report_snapshot(
  supported_count : Int,
  needs_review_count : Int,
  unsupported_count : Int,
  total_count : Int,
  audit_available : Bool,
  findings_html : String,
) -> ClaimReviewReport {
  {
    supported_count,
    needs_review_count,
    unsupported_count,
    total_count,
    audit_available,
    summary_html: "",
    findings_html,
  }
}

///|
pub fn claim_anchors_from_snapshot(payload : String) -> Array[ClaimAnchor] {
  let claims = []
  for record in payload.split("\u001E") {
    let current = record.trim().to_string()
    if current == "" {
      continue
    }
    let fields = []
    for field in current.split("\u001F") {
      fields.push(field.to_string())
    }
    if fields.length() >= 2 {
      let claim_id = fields[0].trim().to_string()
      let claim_text = fields[1].trim().to_string()
      if claim_id != "" && claim_text != "" {
        claims.push({ id: claim_id, text: claim_text })
      }
    }
  }
  claims
}

///|
pub fn empty_claim_review_report(
  total_count : Int,
  lang : String,
) -> ClaimReviewReport {
  let chinese = is_chinese_ui(lang)
  {
    supported_count: 0,
    needs_review_count: 0,
    unsupported_count: 0,
    total_count,
    audit_available: true,
    summary_html: "",
    findings_html: if chinese {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>事实支撑</strong><p>生成草稿后，会逐条核对 claim 是否被来源材料支撑。</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>等待 AI 审阅</strong><span>待生成</span></div><p>当前仅显示 MoonBit 的规则检查。生成草稿后，系统会补充逐条 claim 的语义审查结果。</p></article></div></details>"
    } else {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>Fact grounding</strong><p>After generation, each claim is checked against the uploaded source materials.</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Waiting for AI review</strong><span>Pending</span></div><p>Only the deterministic MoonBit checks are visible for now. After draft generation, the system adds semantic claim-level review here.</p></article></div></details>"
    },
  }
}

///|
pub fn loading_claim_review_report(
  total_count : Int,
  lang : String,
) -> ClaimReviewReport {
  let chinese = is_chinese_ui(lang)
  {
    supported_count: 0,
    needs_review_count: 0,
    unsupported_count: 0,
    total_count,
    audit_available: true,
    summary_html: "",
    findings_html: if chinese {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>事实支撑</strong><p>AI 正在逐条核对 claim 是否被上传资料支撑。</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>正在审阅关键 claim</strong><span>进行中</span></div><p>请稍候，系统正在将草稿中的核心事实表述与已上传资料进行语义比对。</p></article></div></details>"
    } else {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>Fact grounding</strong><p>AI is reviewing each claim against the uploaded source materials.</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Reviewing key claims</strong><span>In progress</span></div><p>Please wait while the system compares the draft's core factual claims against the uploaded source materials.</p></article></div></details>"
    },
  }
}

///|
pub fn failed_claim_review_report(
  message : String,
  total_count : Int,
  lang : String,
) -> ClaimReviewReport {
  let chinese = is_chinese_ui(lang)
  let localized_message = localized_ai_error(message, lang)
  let retry_button = if chinese {
    "<button type=\"button\" class=\"claim-review-retry secondary\">重新审计</button>"
  } else {
    "<button type=\"button\" class=\"claim-review-retry secondary\">Retry review</button>"
  }
  {
    supported_count: 0,
    needs_review_count: 0,
    unsupported_count: 0,
    total_count,
    audit_available: true,
    summary_html: "",
    findings_html: if chinese {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>事实支撑</strong><p>逐条事实核对暂时不可用，但 MoonBit 规则检查仍然有效。</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim 审阅暂不可用</strong><span>待重试</span></div><p>\{escape_html(localized_message)}</p>\{retry_button}</article></div></details>"
    } else {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>Fact grounding</strong><p>The semantic review is unavailable for now, but the MoonBit rule checks still ran.</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim review unavailable</strong><span>Retry needed</span></div><p>\{escape_html(localized_message)}</p>\{retry_button}</article></div></details>"
    },
  }
}

///|
pub fn insufficient_claim_review_report(lang : String) -> ClaimReviewReport {
  let chinese = is_chinese_ui(lang)
  {
    supported_count: 0,
    needs_review_count: 0,
    unsupported_count: 0,
    total_count: 0,
    audit_available: false,
    summary_html: "",
    findings_html: if chinese {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>事实支撑</strong><p>当前没有可核对的真实来源材料，因此不会触发逐条 claim 审计。</p></div><span class=\"audit-summary-count\">资料不足</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>资料不足，无法做事实支撑审计</strong><span>待补充</span></div><p>请上传 fact sheet，或填写官网 URL 让系统抓取官网正文，再进行逐条事实支撑审计。</p></article></div></details>"
    } else {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>Fact grounding</strong><p>No real source material is available yet, so claim-by-claim auditing is skipped for this draft.</p></div><span class=\"audit-summary-count\">Insufficient sources</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>Insufficient sources for fact-grounding audit</strong><span>Add sources</span></div><p>Upload a fact sheet or enter a website URL so the app can fetch website copy before running claim-by-claim review.</p></article></div></details>"
    },
  }
}

///|
pub fn build_claim_review_prompt(
  article_title : String,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
  notes_raw : String,
  claims : Array[ClaimAnchor],
  lang : String,
) -> String {
  let chinese = is_chinese_ui(lang)
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = inferred_keyword(
    primary_keyword, article_title, safe_brand,
  )
  let safe_audience = normalize_or_default(audience, "general readers")
  let safe_title = normalize_or_default(
    article_title,
    safe_generated_title(safe_keyword, safe_audience, lang),
  )
  let facts = parse_facts(facts_raw)
  let notes = parse_facts(notes_raw)
  let fact_lines = if facts.length() == 0 {
    if chinese {
      "（没有可审计的来源材料）"
    } else {
      "(no source materials available for audit)"
    }
  } else {
    numbered_facts(facts)
  }
  let note_lines = if notes.length() == 0 {
    if chinese {
      "（没有额外写作要求）"
    } else {
      "(no additional writing instructions)"
    }
  } else {
    numbered_facts(notes)
  }
  let claim_lines = numbered_claims(claims)
  if chinese {
    "请对下面这篇草稿做逐条事实支撑审计，只返回原始 JSON，不要返回 Markdown。\n\n文章标题：\{safe_title}\n品牌名称：\{safe_brand}\n主关键词：\{safe_keyword}\n目标受众：\{safe_audience}\n\n来源事实：\n\{fact_lines}\n\n补充写作要求：\n\{note_lines}\n\n待审阅 claims：\n\{claim_lines}\n\n任务要求：\n1. 必须逐条审阅上面的 claims，不要新增 claim，也不要改动 claim_id。\n2. 对每条 claim 判断 verdict，只能是 supported、needs_review、unsupported 三者之一。\n3. evidence_numbers 必须是来源事实编号数组，例如 [1, 3]；如果完全没有支撑，可以返回空数组 []。\n4. reason 必须使用自然、完整的简体中文解释，除非直接引用英文原文；不要写成英文说明。\n5. reason 要简洁说明为什么这样判定，必须优先基于给定来源事实；如果某个视角、人称或写法是补充写作要求明确指定的，不要把这种写法本身判为问题。\n6. reason 里不要再写“source [1]”“source [4]”这类来源编号引用，因为界面会在下方单独展示对应摘录。\n7. rewrite 给出一句更安全、且更贴近来源的改写建议；如果 claim 已经 fully supported，也可以返回空字符串。\n8. rewrite 必须沿用原 claim 的正文语言，直接返回一条可贴回正文的句子。如果原 claim 是英文，rewrite 必须是英文；即使 reason 使用中文，也不要把 rewrite 写成中文。\n9. rewrite 必须尽量保留原 claim 的叙述视角、人称和语气。如果补充写作要求明确要求第一人称、消费者视角或某种叙述角度，rewrite 必须延续该视角，不要改写成第三方说明文口吻。\n10. 如果 claim 使用了超出来源事实的信息、夸张措辞、过度概括或偷换概念，应判为 needs_review 或 unsupported；但不要仅因为它采用了用户明确要求的写作视角就判错。\n11. 只返回 JSON，格式必须严格为：{\"claims\":[{\"claim_id\":\"C1\",\"claim\":\"...\",\"verdict\":\"supported|needs_review|unsupported\",\"evidence_numbers\":[1,2],\"reason\":\"...\",\"rewrite\":\"...\"}]}"
  } else {
    "Review the draft below claim by claim for factual grounding and return raw JSON only, with no markdown fences.\n\nArticle title: \{safe_title}\nBrand name: \{safe_brand}\nPrimary keyword: \{safe_keyword}\nAudience: \{safe_audience}\n\nSource facts:\n\{fact_lines}\n\nAdditional writing instructions:\n\{note_lines}\n\nClaims to review:\n\{claim_lines}\n\nRequirements:\n1. Review each provided claim ID. Do not invent new claims and do not change the claim_id values.\n2. For each claim, set verdict to exactly one of: supported, needs_review, unsupported.\n3. evidence_numbers must be an array of source-note numbers such as [1, 3]. If no source supports the claim, return an empty array [].\n4. reason should briefly explain the decision using the provided source facts first. If a viewpoint, narrative angle, or person is explicitly required by the additional writing instructions, do not treat that framing alone as a problem.\n5. Do not mention source-number references like \"source [4]\" inside reason, because the UI will show the matched excerpt separately below.\n6. rewrite should offer a safer replacement sentence when the claim is risky or unsupported. It may be empty if the claim is fully supported.\n7. Keep rewrite in the same body-copy language as the original claim so it can be pasted back into the draft directly.\n8. Preserve the original narrative perspective, person, and tone whenever possible. If the writing instructions explicitly ask for first-person, consumer perspective, or another specific viewpoint, the rewrite must keep that viewpoint instead of switching to detached third-person copy.\n9. If a claim introduces information beyond the provided sources, overgeneralizes, exaggerates, or shifts the meaning of a source fact, mark it as needs_review or unsupported. But do not mark a claim problematic only because it follows a user-requested writing perspective.\n10. Return JSON only, in exactly this shape: {\"claims\":[{\"claim_id\":\"C1\",\"claim\":\"...\",\"verdict\":\"supported|needs_review|unsupported\",\"evidence_numbers\":[1,2],\"reason\":\"...\",\"rewrite\":\"...\"}]}"
  }
}

///|
pub fn claim_review_report_from_payload(
  payload : String,
  claims : Array[ClaimAnchor],
  facts_raw : String,
  lang : String,
) -> ClaimReviewReport {
  let chinese = is_chinese_ui(lang)
  let items = []
  let record_sep = "\u001E"
  let field_sep = "\u001F"
  for record in payload.split(record_sep) {
    let current = record.to_string()
    if current.trim().to_string() != "" {
      let fields = []
      for field in current.split(field_sep) {
        fields.push(field.to_string())
      }
      items.push(fields)
    }
  }
  let source_notes = parse_facts(facts_raw)
  let mut supported = 0
  let mut needs_review = 0
  let mut unsupported = 0
  let needs_builder = StringBuilder::new()
  let supported_builder = StringBuilder::new()
  for claim in claims {
    let fields = find_claim_record(items, claim.id)
    let reviewed_claim = normalize_or_default(
      field_or_empty(fields, 1),
      claim.text,
    )
    let verdict = if fields.length() == 0 {
      "needs_review"
    } else {
      normalize_claim_verdict(field_or_empty(fields, 2))
    }
    let evidence_numbers = field_or_empty(fields, 3)
    let reason = normalize_or_default(
      field_or_empty(fields, 4),
      if chinese {
        "当前没有返回这条 claim 的结构化审阅结果，建议人工复核。"
      } else {
        "No structured review was returned for this claim, so it should be checked manually."
      },
    )
    let rewrite = field_or_empty(fields, 5)
    match verdict {
      "supported" => supported += 1
      "unsupported" => unsupported += 1
      _ => needs_review += 1
    }
    if verdict == "supported" {
      render_claim_review_item(
        supported_builder,
        claim.id,
        reviewed_claim,
        verdict,
        evidence_numbers,
        reason,
        rewrite,
        source_notes,
        lang,
      )
    } else {
      render_claim_review_item(
        needs_builder,
        claim.id,
        reviewed_claim,
        verdict,
        evidence_numbers,
        reason,
        rewrite,
        source_notes,
        lang,
      )
    }
  }
  let total = claims.length()
  let review_count = needs_review + unsupported
  let builder = StringBuilder::new()
  builder.write_string(
    "<details id=\"factAuditSection\" class=\"audit-accordion\" open>",
  )
  builder.write_string(
    "<summary class=\"audit-accordion-summary\"><div><strong>",
  )
  builder.write_string(if chinese { "事实支撑" } else { "Fact grounding" })
  builder.write_string("</strong><p>")
  builder.write_string(
    escape_html(
      if chinese {
        "MoonBit 预编号 claim，AI 逐条判断是否被上传资料支撑。"
      } else {
        "MoonBit pre-numbers the claims, and AI reviews each one against the uploaded source materials."
      },
    ),
  )
  builder.write_string("</p></div><span class=\"audit-summary-count\">")
  builder.write_string("\{supported}/\{total}")
  builder.write_string("</span></summary><div class=\"audit-accordion-body\">")
  builder.write_string("<details class=\"claim-group claim-group-review\" open>")
  builder.write_string("<summary class=\"claim-group-head\"><h4>")
  builder.write_string(
    if chinese {
      "需复核 claims"
    } else {
      "Claims needing review"
    },
  )
  builder.write_string("</h4><span>")
  builder.write_string("\{review_count}")
  builder.write_string("</span></summary><div class=\"claim-list\">")
  if review_count == 0 {
    builder.write_string(
      "<article class=\"audit-item pass\"><div class=\"audit-top\"><strong>",
    )
    builder.write_string(
      if chinese {
        "当前没有高风险 claim"
      } else {
        "No high-risk claims right now"
      },
    )
    builder.write_string("</strong><span>")
    builder.write_string(if chinese { "通过" } else { "Pass" })
    builder.write_string("</span></div><p>")
    builder.write_string(
      escape_html(
        if chinese {
          "这一轮审阅没有发现需要人工复核的关键表述。"
        } else {
          "This run did not flag any key claims for manual review."
        },
      ),
    )
    builder.write_string("</p></article>")
  } else {
    builder.write_string(needs_builder.to_string())
  }
  builder.write_string("</div></details>")
  builder.write_string("<details class=\"claim-group claim-group-supported\" open>")
  builder.write_string("<summary class=\"claim-group-head\"><h4>")
  builder.write_string(
    if chinese {
      "已支撑 claims"
    } else {
      "Supported claims"
    },
  )
  builder.write_string("</h4><span>")
  builder.write_string("\{supported}")
  builder.write_string("</span></summary><div class=\"claim-list\">")
  if supported == 0 {
    builder.write_string(
      "<article class=\"audit-item warn\"><div class=\"audit-top\"><strong>",
    )
    builder.write_string(
      if chinese {
        "当前还没有已支撑 claim"
      } else {
        "No supported claims yet"
      },
    )
    builder.write_string("</strong><span>")
    builder.write_string(if chinese { "待补强" } else { "Needs work" })
    builder.write_string("</span></div><p>")
    builder.write_string(
      escape_html(
        if chinese {
          "当前草稿里的关键表述还没有形成明确的事实支撑闭环。"
        } else {
          "The draft has not yet established clear source support for its key claims."
        },
      ),
    )
    builder.write_string("</p></article>")
  } else {
    builder.write_string(supported_builder.to_string())
  }
  builder.write_string("</div></details></div></details>")
  {
    supported_count: supported,
    needs_review_count: needs_review,
    unsupported_count: unsupported,
    total_count: total,
    audit_available: true,
    summary_html: "",
    findings_html: builder.to_string(),
  }
}

///|
pub fn render_audit_overview(
  claim_report : ClaimReviewReport,
  seo_report : AuditReport,
  lang : String,
) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"audit-overview-grid\">")
  builder.write_string(
    "<button type=\"button\" class=\"audit-summary-button\" data-audit-target=\"factAuditSection\">",
  )
  builder.write_string("<span class=\"audit-summary-label\">")
  builder.write_string(if chinese { "事实支撑" } else { "Fact grounding" })
  builder.write_string("</span><strong>")
  if claim_report.audit_available {
    builder.write_string(
      "\{claim_report.supported_count}/\{claim_report.total_count}",
    )
  } else {
    builder.write_string(
      if chinese {
        "资料不足"
      } else {
        "Insufficient sources"
      },
    )
  }
  builder.write_string("</strong><span class=\"audit-summary-meta\">")
  builder.write_string(
    escape_html(
      if !claim_report.audit_available && chinese {
        "无法做事实支撑审计"
      } else if !claim_report.audit_available {
        "Fact-grounding audit unavailable"
      } else if chinese {
        "\{claim_report.needs_review_count + claim_report.unsupported_count} 条待复核"
      } else {
        "\{claim_report.needs_review_count + claim_report.unsupported_count} need review"
      },
    ),
  )
  builder.write_string("</span></button>")
  builder.write_string(
    "<button type=\"button\" class=\"audit-summary-button\" data-audit-target=\"seoRuleSection\">",
  )
  builder.write_string("<span class=\"audit-summary-label\">")
  builder.write_string(if chinese { "SEO 规则" } else { "SEO rules" })
  builder.write_string("</span><strong>")
  builder.write_string("\{seo_report.pass_count}/\{seo_report.total_count}")
  builder.write_string("</strong><span class=\"audit-summary-meta\">")
  builder.write_string(
    escape_html(
      if chinese {
        "MoonBit 确定性检查"
      } else {
        "MoonBit deterministic checks"
      },
    ),
  )
  builder.write_string("</span></button></div>")
  builder.to_string()
}

///|
pub fn render_seo_rule_section(report : AuditReport, lang : String) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string(
    "<details id=\"seoRuleSection\" class=\"audit-accordion\">",
  )
  builder.write_string(
    "<summary class=\"audit-accordion-summary\"><div><strong>",
  )
  builder.write_string(
    if chinese {
      "SEO 规则检查"
    } else {
      "SEO rule checks"
    },
  )
  builder.write_string("</strong><p>")
  builder.write_string(
    escape_html(
      if chinese {
        "这部分是 MoonBit 的确定性规则检查，不依赖模型语义判断。"
      } else {
        "These are deterministic MoonBit checks and do not rely on model semantics."
      },
    ),
  )
  builder.write_string("</p></div><span class=\"audit-summary-count\">")
  builder.write_string("\{report.pass_count}/\{report.total_count}")
  builder.write_string("</span></summary><div class=\"audit-accordion-body\">")
  builder.write_string(report.findings_html)
  builder.write_string("</div></details>")
  builder.to_string()
}

///|
pub fn build_ai_prompt(
  article_title : String,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
  notes_raw : String,
  lang : String,
) -> String {
  ignore(lang)
  let output_lang = requested_output_lang(notes_raw)
  let chinese = output_lang == "zh"
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = inferred_keyword(
    primary_keyword, article_title, safe_brand,
  )
  let safe_audience = normalize_or_default(audience, "general readers")
  let requested_title = if article_title.trim().to_string() == "" {
    if chinese {
      "（未指定，可自行生成）"
    } else {
      "(not provided, generate one)"
    }
  } else {
    article_title.trim().to_string()
  }
  let facts = parse_facts(facts_raw)
  let notes = parse_facts(notes_raw)
  let fact_lines = if facts.length() == 0 {
    if chinese {
      "- 当前没有真实来源材料，请谨慎写作，不要臆造事实。"
    } else {
      "- No real source materials were provided. Write conservatively and do not invent facts."
    }
  } else {
    bullet_lines(draft_prompt_facts(facts), "")
  }
  let note_lines = if notes.length() == 0 {
    if chinese {
      "- 没有额外写作要求。"
    } else {
      "- No extra writing instructions."
    }
  } else {
    bullet_lines(notes, "")
  }
  if chinese {
    "请为一个品牌/产品主题页面生成文案，且只返回原始 JSON，不要返回 Markdown 代码块。\n\n品牌名称：\{safe_brand}\n主关键词：\{safe_keyword}\n目标受众：\{safe_audience}\n指定标题：\{requested_title}\n来源事实：\n\{fact_lines}\n补充写作要求：\n\{note_lines}\n要求：\n1. 全文必须使用自然、完整、专业的简体中文，除品牌名、产品名、官网域名外，不要夹杂英文句子或英文小标题。\n2. 请写成真正可发布的品牌文章，不要写成提纲、摘要或提示词回应。\n3. 总体长度控制在 1400 到 1800 个中文字符之间，确保像一篇完整长文，而不是短摘要。\n4. 写作前先在脑中规划清楚：结论先行的 opening、一个列表型亮点区块、一个紧凑的对比表格、三个不重复的核心小节、一个 FAQ 前的总结型主题小节，以及结尾如何自然收束；不要把这份规划直接输出。\n5. opening 必须采用倒金字塔逻辑：前 40 到 80 字先给出结论或答案；随后补充用户痛点/需求背景（不要提竞品）；再说明读完这篇文章能获得什么价值。\n6. 主关键词必须出现在标题里，并在前 100 个词内自然出现；品牌名也必须在前 100 个词内至少出现一次。\n7. 主关键词自然出现 3 到 5 次，并且不要集中堆在同一段里；至少要分别落在 opening、正文至少一个主 section，以及 summary 或 FAQ 其中一处。还要自然带出 3 到 4 个语义紧密的相关词，不要堆砌。\n8. 标题要清晰具体，像真实品牌文章标题，不要写成空泛模板或流程标题。\n9. meta_description 控制在 90 到 140 个中文字符之间，可直接用于搜索摘要。\n10. opening_answer、opening_problem、opening_value 三个字段必须分别承担三段开场职责：先给结论，再给背景，再给阅读价值；不要把三段内容混在一个字段里。\n11. 三个主 section 的标题都要具体、并列、互不重复，且围绕关键主题词展开，不要出现跨级跳跃或工作流式标题。\n12. 每个主 section 正文都要围绕一个核心主题展开，遵守 topic sentence first；优先按 claim → evidence → conclusion 的顺序推进，每段 2 到 4 句，最多不要超过 5 句。每个 section 最好像一个清晰的小点，分别回答不同的买家问题，而不是三段相似的长文。只要自然，就优先把主关键词放进 section_heading、topic sentence 或段落第一句，而不是只在全文中出现一次。\n13. 默认情况下，请额外返回一个列表区块：key_points_heading 和 key_points_items。key_points_items 必须是 3 到 4 条紧凑的列表项，且每条都是完整短句，用来概括品牌最值得关注的功能、优势或注意点。如果补充要求明确说不要列表、不要 bullet points、不要 key points，则返回空字符串 key_points_heading 和空数组 key_points_items。\n14. 默认情况下，请额外返回一个对比表格区块：comparison_table_heading、comparison_table_columns、comparison_table_rows。comparison_table_columns 必须是 3 个列标题组成的字符串数组。comparison_table_rows 必须是 3 到 4 行字符串数组，每一行都使用“特征 | \{safe_brand} | 通用替代方案”这种单行格式，便于后续渲染成 HTML 表格。如果补充要求没有明确要求竞品品牌名，则表格里也不要出现任何竞品品牌名。如果补充要求明确说不要表格、不要对比表、不要 comparison table 或 no table，则返回空字符串 comparison_table_heading 和空数组 comparison_table_columns、comparison_table_rows。\n15. FAQ 前默认必须再返回一个独立的总结型区块：summary_heading 和 summary_body。这个区块要放在 FAQ 前面，承担“把前文重点收拢并帮助读者做判断”的作用，但标题绝对不要写成 Conclusion、In conclusion、Final thoughts、结论、总结或类似套路词，也不要写成明显在宣布“这里开始总结”的标题。summary_heading 必须是一个具体、贴主题、偏买家判断或适用场景的 H2。\n16. summary_body 必须写成 2 个短段落，中间用空行分隔。每段只讲一件事，优先控制在 2 到 3 句，最多不要超过 5 句；第一段更偏向适用人群/核心价值，第二段更偏向限制、边界或决策提醒。\n17. 对比表格必须优先比较买家真正会拿来做决定的维度，例如适配范围、安装方式、调节体验、承重/稳定性、桌面占用、线缆管理或后续校准，而不是空泛口号。每一行第一列尽量控制在 2 到 6 个字或 2 到 5 个英文词；每个单元格优先使用紧凑短语，而不是完整长句。\n18. 如果某一段内容天然适合做功能列表、优点列表、步骤列表或结构化对比，请优先把这些信息压进 key_points_items、comparison_table_rows 或正文中的列表式表达，而不是堆成长句。\n19. 默认情况下，FAQ 必须写 3 个短问短答，只能回答正文已覆盖的主题；每个回答都要先给 Yes/No，再补一句理由，不要新增新话题。如果补充要求明确说不要 FAQ、不要 FAQs、不要常见问题，则 faq_heading 和所有 faq 字段都返回空字符串。\n20. 如果补充要求里明确要求某种写作角度、人称视角或结构，必须在 opening 和至少一个小节里体现。\n21. 不要臆造消费者调研、市场份额、使用习惯、口碑评价或功能细节，除非来源事实明确写出。\n22. 优先使用来源中明确出现的产品事实、功能细节和数字信息；有数据时要自然写进正文，而不是写成空泛判断。\n23. 除非标题、来源事实或补充要求明确提到 SEO、搜索流量、搜索引擎、关键词、内容审计，否则不要在正文里讨论 SEO、搜索意图、SEO 内容审计、写作流程或内容工作流。\n24. section_one_body 和 section_two_body 不要自己写 [1][2][3] 这种引用标记。\n25. 不要使用 best、guaranteed、perfect、#1、最强、第一、保证、绝对、顶级 这类高风险表述，除非用户明确要求并且来源可支持。\n26. 如果来源事实来自 PDF、断言清单或混合语言摘录，先提炼底层产品事实，再写成通顺中文；不要把“断言 / 备注 / 正确写法提示 / ✅ / ❌”这类判断符号或编辑备注直接抄进正文。\n27. 如果来源事实里同时出现中英文或提取噪声，正文必须仍然保持单一、干净的中文成稿，不要中英混写，也不要直接粘贴原始 checklist 片段。\n28. 语气要可信、克制，像真实品牌官网内容，不要像 AI 套话。\n29. 仅返回 JSON，字段必须严格为：title, meta_description, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer。其中 key_points_items、comparison_table_columns、comparison_table_rows 都必须是字符串数组。"
  } else {
    "Write copy for a brand or product page and return raw JSON only, with no markdown fences.\n\nBrand name: \{safe_brand}\nPrimary keyword: \{safe_keyword}\nAudience: \{safe_audience}\nRequested title: \{requested_title}\nSource facts:\n\{fact_lines}\nAdditional writing instructions:\n\{note_lines}\nRequirements:\n1. Default to polished, publishable English prose.\n2. If the source notes explicitly request another output language, honor that request and write the whole draft consistently in that language.\n3. The article subject is the requested topic/title, not SEO, search intent, keyword strategy, audits, or the writing workflow. Do not mention SEO, search engines, content audits, search intent, keyword usage, or the drafting tool unless the title, source facts, or additional instructions explicitly ask for those topics.\n4. Target a real long-form article of roughly 1450 to 1650 words. If the draft is materially shorter than 1300 words, expand it before finalizing.\n5. Before writing, silently plan a clear article blueprint: an answer-first opening, a compact list block of key reasons to care, a compact comparison table, three non-overlapping section roles, a pre-FAQ summary section with its own thematic H2, and a closing angle that ties the piece together. Do not output the plan itself.\n6. Use the provided source facts as the center of the article, not generic category commentary.\n7. In the first 40 to 80 words, lead with the conclusion or direct answer. Then introduce the reader need or pain point without naming competitors, and close the opening by clarifying the value of reading on.\n8. Mention the brand at least once in the first 100 words, and place the primary keyword in both the title and the first 100 words.\n9. Reflect any requested angle or perspective clearly in the opening and at least one section heading.\n10. Do not invent consumer sentiment, survey data, market trends, user behavior patterns, or feature details unless they are directly supported by the source notes.\n11. Use at least three concrete source facts directly in the prose when the sources provide them, and connect them with a claim → evidence → conclusion rhythm instead of loose assertions.\n12. Use the primary keyword naturally 3 to 5 times, do not bunch those mentions into a single paragraph, and spread them across the opening, at least one main section, and either the summary or FAQ. Also weave in 3 to 4 semantically related terms without keyword stuffing.\n13. Make the title specific, search-friendly, and free of risky claims like best, guaranteed, perfect, #1, unbeatable, or world-class unless those exact words were explicitly required by the user.\n14. Keep meta_description around 130 to 155 characters.\n15. Return the opening as three separate fields: opening_answer, opening_problem, and opening_value. Together they should read like a real inverted-pyramid opening instead of a generic scene-setter.\n16. Each section heading must be concrete, parallel in scope, and centered on the main topic rather than workflow language.\n17. Each section body should fully develop one idea at a time with short, readable paragraphs. Use topic sentence first, keep most paragraphs to 2 to 4 sentences, and avoid filler. Each section should feel like its own clear sub-point that answers a different buyer question rather than three similar blocks. When it stays natural, prefer placing the primary keyword in a section heading, topic sentence, or first paragraph rather than mentioning it only once in the whole article.\n18. Treat the three main sections as the bulk of the article, not placeholders. Aim for roughly 280 to 380 words for each main section body, and make sure the combined opening plus sections already puts the draft near long-form territory before the FAQ.\n19. Expand with concrete explanation, examples, use-case framing, caveats, and reader decision guidance when the source facts allow it. Do not stop after one short paragraph per section.\n20. By default, return an additional list block using key_points_heading and key_points_items. key_points_items must be an array of 3 to 4 short bullet-style statements that summarize the brand's most useful features, strengths, or cautions. If the additional instructions explicitly say no bullet points, no list, or no key points, return an empty string for key_points_heading and an empty array for key_points_items.\n21. By default, return an additional comparison block using comparison_table_heading, comparison_table_columns, and comparison_table_rows. comparison_table_columns must be a JSON array of exactly 3 column labels. comparison_table_rows must be a JSON array of 3 to 4 strings, each using a single-line format like \"Feature | \{safe_brand} | Generic alternative\" so it can be rendered into an HTML table later. Unless the user explicitly requests competitor brands, comparison language should stay generic and must not mention competitor brand names. If the additional instructions explicitly say no table, no tables, no comparison table, without table, or do not include a table, return an empty string for comparison_table_heading and empty arrays for comparison_table_columns and comparison_table_rows.\n22. Before the FAQ, return an additional summary block using summary_heading and summary_body. This block should synthesize the strongest takeaways, help the reader make a decision, and read like a thematic final section rather than a boilerplate conclusion. Do not use headings like Conclusion, In conclusion, Final thoughts, Summary, Wrap-up, 结论, 总结, or any close variant, and do not make the heading sound like it is announcing a recap. summary_heading should feel closer to a buyer lens, fit question, or use-case judgment than a summary label.\n23. summary_body must contain exactly 2 short paragraphs separated by a blank line. Each paragraph should focus on one idea, usually 2 to 3 sentences, and never more than 5 sentences. Prefer the first paragraph for fit/value and the second paragraph for caveat, limitation, or decision guidance.\n24. The comparison table should focus on buyer decision dimensions that genuinely help evaluation, such as fit range, mounting approach, adjustability, stability/load handling, desk footprint, cable management, or calibration. Keep first-column labels short, ideally 2 to 5 words, and keep cell content compact and scannable rather than full long sentences.\n25. If a feature set, advantage list, process, or buyer decision naturally benefits from structured comparison, prefer encoding that information in key_points_items, comparison_table_rows, or list-like prose instead of flattening everything into one dense paragraph.\n26. By default, add exactly 3 FAQ items. Each FAQ answer must start with a clear Yes or No, followed by a short reason. The FAQ must only address topics already covered in the article and must not introduce new claims. If the additional instructions explicitly say no FAQ, no FAQs, or no frequently asked questions, return an empty string for faq_heading and empty strings for every FAQ field.\n27. Do not include citation markers like [1], [2], or [3] in section_one_body or section_two_body.\n28. If the source notes come from a PDF, checklist, or mixed-language extraction, first infer the underlying product fact and rewrite it as clean prose. Do not paste editorial labels, verdict markers, checkmarks, correction notes, or bilingual fragments directly into the article.\n29. Keep the entire draft in one consistent output language. If the sources are mixed-language, silently translate the useful facts into the requested draft language instead of echoing the original wording.\n30. Keep the tone credible, restrained, and suitable for a real brand page.\n31. Return JSON only, with exactly these keys: title, meta_description, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer. key_points_items, comparison_table_columns, and comparison_table_rows must each be JSON arrays of strings."
  }
}

///|
pub fn export_filename(draft : Draft) -> String {
  "\{draft.slug}.html"
}

///|
fn safe_generated_title(
  keyword : String,
  audience : String,
  lang : String,
) -> String {
  ignore(audience)
  let seed = keyword.trim().to_string()
  if seed == "" {
    if lang == "zh" {
      "品牌概览"
    } else {
      "Brand Overview"
    }
  } else if lang == "zh" {
    title_case(seed)
  } else {
    title_case(seed)
  }
}

///|
fn sanitize_generated_title(
  candidate : String,
  keyword : String,
  audience : String,
  lang : String,
) -> String {
  let normalized = normalize_or_default(
    candidate,
    safe_generated_title(keyword, audience, lang),
  )
  if contains_banned_claims(normalized) || normalized.length() < 24 {
    safe_generated_title(keyword, audience, lang)
  } else {
    normalized
  }
}

///|
fn clamp_meta_description(
  candidate : String,
  title : String,
  opening : String,
) -> String {
  let normalized = normalize_or_default(
    candidate,
    meta_description(title, opening),
  )
  let clipped = excerpt(normalized, 155)
  if clipped.length() < 110 {
    meta_description(title, opening)
  } else {
    clipped
  }
}

///|
fn normalize_or_default(value : String, fallback : String) -> String {
  let trimmed = value.trim().to_string()
  if trimmed == "" {
    fallback
  } else {
    trimmed
  }
}

///|
fn inferred_keyword(
  primary_keyword : String,
  article_title : String,
  brand_name : String,
) -> String {
  let trimmed = primary_keyword.trim().to_string()
  if trimmed != "" {
    return trimmed
  }
  let title = article_title.trim().to_string()
  if title != "" {
    return keyword_from_title(title)
  }
  "\{brand_name} guide"
}

///|
fn keyword_from_title(title : String) -> String {
  let without_suffix = title
    .replace_all(old="(2026 Updated Guide)", new="")
    .replace_all(old="(2025 Updated Guide)", new="")
    .replace_all(old="(2024 Updated Guide)", new="")
    .replace_all(old="(2026 Guide)", new="")
    .replace_all(old="(2025 Guide)", new="")
    .replace_all(old="(2024 Guide)", new="")
    .replace_all(old="2026 Updated Guide", new="")
    .replace_all(old="2025 Updated Guide", new="")
    .replace_all(old="2024 Updated Guide", new="")
    .replace_all(old="2026 Guide", new="")
    .replace_all(old="2025 Guide", new="")
    .replace_all(old="2024 Guide", new="")
    .replace_all(old="Updated Guide", new="")
    .replace_all(old="Guide", new="")
    .trim()
    .to_string()
  let collapsed = collapse_spaces(
    without_suffix
    .replace_all(old="()", new=" ")
    .replace_all(old="（", new=" ")
    .replace_all(old="）", new=" ")
    .replace_all(old="(", new=" ")
    .replace_all(old=")", new=" "),
  )
  let without_leadin = if collapsed.has_prefix("Best ") {
    collapsed.replace_all(old="Best ", new="").trim().to_string()
  } else if collapsed.has_prefix("Top ") {
    collapsed.replace_all(old="Top ", new="").trim().to_string()
  } else {
    collapsed
  }
  if without_leadin == "" {
    title
  } else {
    without_leadin
  }
}

///|
fn requested_output_lang(notes_raw : String) -> String {
  let notes = notes_raw.to_lower()
  if notes.contains("简体中文") ||
    notes.contains("中文") ||
    notes.contains("汉语") ||
    notes.contains("chinese") ||
    notes.contains("mandarin") {
    "zh"
  } else if notes.contains("英文") ||
    notes.contains("英语") ||
    notes.contains("english") {
    "en"
  } else {
    "en"
  }
}

///|
fn draft_prompt_facts(facts : Array[String]) -> Array[String] {
  let cleaned = []
  for fact in facts {
    let normalized = normalize_prompt_fact(fact)
    if normalized != "" {
      cleaned.push(normalized)
    }
  }
  cleaned
}

///|
fn normalize_prompt_fact(fact : String) -> String {
  let cleaned = collapse_spaces(
    fact
    .replace_all(old="✅", new=" ")
    .replace_all(old="❌", new=" ")
    .replace_all(old="✔", new=" ")
    .replace_all(old="✘", new=" ")
    .replace_all(old="☑", new=" ")
    .replace_all(old="☒", new=" ")
    .replace_all(old="断言", new=" ")
    .replace_all(old="内容", new=" ")
    .replace_all(old="判断", new=" ")
    .replace_all(old="备注", new=" ")
    .replace_all(old="正确写法提示", new=" ")
    .replace_all(old="（", new="(")
    .replace_all(old="）", new=")")
    .trim()
    .to_string(),
  )
  if cleaned == "" {
    ""
  } else {
    excerpt(cleaned, 220)
  }
}

///|
fn collapse_spaces(input : String) -> String {
  let current = input
    .replace_all(old="\n", new=" ")
    .replace_all(old="\t", new=" ")
    .replace_all(old="  ", new=" ")
  loop current {
    next =>
      if next.contains("  ") {
        continue next.replace_all(old="  ", new=" ")
      } else {
        next.trim().to_string()
      }
  }
}

///|
fn payload_value(
  parts : Array[String],
  index : Int,
  fallback : String,
) -> String {
  if index < parts.length() {
    normalize_or_default(parts[index], fallback)
  } else {
    fallback
  }
}

///|
fn payload_value_for_lang(
  parts : Array[String],
  index : Int,
  fallback : String,
  lang : String,
) -> String {
  let value = payload_value(parts, index, fallback)
  if lang == "en" && contains_cjk(value) {
    fallback
  } else {
    value
  }
}

///|
fn payload_lines_for_lang(
  parts : Array[String],
  index : Int,
  fallback : Array[String],
  lang : String,
) -> Array[String] {
  let fallback_joined = join_slice(fallback, 0, fallback.length())
  let value = payload_value_for_lang(parts, index, fallback_joined, lang)
  let lines = []
  for line in value.split("\n") {
    let current = line.to_string().trim().to_string()
    if current != "" {
      lines.push(current)
    }
  }
  if lines.length() == 0 {
    fallback
  } else {
    lines
  }
}

///|
fn contains_cjk(input : String) -> Bool {
  for scalar in input.iter() {
    let code = scalar.to_int()
    if (code >= 0x4E00 && code <= 0x9FFF) ||
      (code >= 0x3400 && code <= 0x4DBF) ||
      (code >= 0x3000 && code <= 0x303F) {
      return true
    }
  }
  false
}

///|
fn bullet_lines(lines : Array[String], empty_line : String) -> String {
  if lines.length() == 0 {
    return empty_line
  }
  let builder = StringBuilder::new()
  for line in lines {
    builder.write_string("- ")
    builder.write_string(line)
    builder.write_string("\n")
  }
  builder.to_string()
}

///|
fn fact_or_empty(facts : Array[String], index : Int) -> String {
  if index < facts.length() {
    facts[index]
  } else {
    ""
  }
}

///|
fn default_key_points(
  facts : Array[String],
  brand : String,
  lang : String,
) -> Array[String] {
  let items = []
  if facts.length() > 0 {
    let limit = if facts.length() < 3 { facts.length() } else { 3 }
    for index = 0; index < limit; index = index + 1 {
      items.push(facts[index])
    }
  }
  if items.length() == 0 {
    if lang == "zh" {
      [
        "\{brand} 的介绍应优先围绕可验证的产品事实展开。",
        "用户最关心的是实际价值、使用方式和仍需确认的细节。",
        "结论应保持克制，避免超出来源材料的判断。",
      ]
    } else {
      [
        "\{brand} should be introduced through concrete, verifiable product facts.",
        "Readers care most about practical value, usability, and what still needs verification.",
        "The draft should stay restrained and avoid conclusions that go beyond the available sources.",
      ]
    }
  } else {
    items
  }
}

///|
fn default_comparison_table_columns(lang : String) -> Array[String] {
  if lang == "zh" {
    ["对比维度", "本产品", "通用替代方案"]
  } else {
    ["Feature", "This option", "Generic alternative"]
  }
}

///|
fn default_comparison_table_rows(
  facts : Array[String],
  brand : String,
  keyword : String,
  lang : String,
) -> Array[String] {
  let rows = []
  let first_fact = fact_or_empty(facts, 0)
  let second_fact = fact_or_empty(facts, 1)
  let third_fact = fact_or_empty(facts, 2)
  let keyword_label = if lang == "zh" {
    normalize_or_default(keyword, "核心亮点")
  } else {
    normalize_or_default(keyword, "Core benefit")
  }
  if lang == "zh" {
    rows.push(
      if first_fact != "" {
        "核心亮点 | \{first_fact} | 需要用户自己从零判断是否匹配需求"
      } else {
        "\{keyword_label} | \{brand} 优先强调可验证的产品信息 | 通用替代方案往往先讲泛泛卖点"
      },
    )
    rows.push(
      if second_fact != "" {
        "使用体验 | \{second_fact} | 常见替代方案可能只给笼统描述"
      } else {
        "使用体验 | 围绕实际使用场景说明价值 | 往往缺少具体场景说明"
      },
    )
    rows.push(
      if third_fact != "" {
        "决策信息 | \{third_fact} | 还需要额外查找和比对"
      } else {
        "决策信息 | 直接指出哪些细节值得进一步确认 | 常见替代方案容易省略限制条件"
      },
    )
  } else {
    rows.push(
      if first_fact != "" {
        "Core benefit | \{first_fact} | Readers often need to infer the practical benefit themselves"
      } else {
        "\{keyword_label} | \{brand} focuses on verifiable product value | Generic alternatives often lean on broad category claims"
      },
    )
    rows.push(
      if second_fact != "" {
        "Daily use | \{second_fact} | Generic alternatives may stay vague about real usage"
      } else {
        "Daily use | Explains the experience through practical use cases | Generic alternatives may rely on softer generalities"
      },
    )
    rows.push(
      if third_fact != "" {
        "Decision detail | \{third_fact} | Readers may need extra comparison work before deciding"
      } else {
        "Decision detail | Makes remaining verification points explicit | Generic alternatives often skip tradeoffs and caveats"
      },
    )
  }
  rows
}

///|
fn notes_request_no_faq(notes_raw : String) -> Bool {
  let notes = notes_raw.to_lower()
  notes.contains("不要faq") ||
  notes.contains("不需要faq") ||
  notes.contains("不要常见问题") ||
  notes.contains("不需要常见问题") ||
  notes.contains("no faq") ||
  notes.contains("no faqs") ||
  notes.contains("without faq") ||
  notes.contains("without faqs") ||
  notes.contains("no frequently asked questions")
}

///|
fn notes_request_no_key_points(notes_raw : String) -> Bool {
  let notes = notes_raw.to_lower()
  notes.contains("不要列表") ||
  notes.contains("不需要列表") ||
  notes.contains("不要bullet") ||
  notes.contains("不要 bullet") ||
  notes.contains("不要key points") ||
  notes.contains("不要 key points") ||
  notes.contains("no bullet") ||
  notes.contains("no bullets") ||
  notes.contains("no bullet points") ||
  notes.contains("without bullet") ||
  notes.contains("without bullet points") ||
  notes.contains("no key points") ||
  notes.contains("without key points") ||
  notes.contains("no list") ||
  notes.contains("without list")
}

///|
fn notes_request_no_comparison_table(notes_raw : String) -> Bool {
  let notes = notes_raw.to_lower()
  notes.contains("不要表格") ||
  notes.contains("不需要表格") ||
  notes.contains("不要对比表") ||
  notes.contains("不需要对比表") ||
  notes.contains("不要比较表") ||
  notes.contains("no table") ||
  notes.contains("no tables") ||
  notes.contains("without table") ||
  notes.contains("without tables") ||
  notes.contains("no comparison table") ||
  notes.contains("no comparison chart") ||
  notes.contains("do not include a table")
}

///|
fn join_slice(parts : Array[String], start : Int, end_ : Int) -> String {
  let builder = StringBuilder::new()
  for index = start; index < end_; index = index + 1 {
    if index > start {
      builder.write_string(" ")
    }
    builder.write_string(parts[index])
  }
  builder.to_string()
}

///|
fn split_sentences(text : String) -> Array[String] {
  let parts = []
  let normalized = text
    .replace_all(old="。", new="。\n")
    .replace_all(old="！", new="！\n")
    .replace_all(old="？", new="？\n")
    .replace_all(old=". ", new=". \n")
    .replace_all(old="! ", new="! \n")
    .replace_all(old="? ", new="? \n")
  for part in normalized.split("\n") {
    let trimmed = part.to_string().trim().to_string()
    if trimmed != "" {
      parts.push(trimmed)
    }
  }
  parts
}

///|
fn split_claim_pair(text : String) -> (String, String) {
  let trimmed = text.trim().to_string()
  let sentences = split_sentences(trimmed)
  if sentences.length() >= 2 {
    let pivot = (sentences.length() + 1) / 2
    return (
      join_slice(sentences, 0, pivot),
      join_slice(sentences, pivot, sentences.length()),
    )
  }
  let midpoint = trimmed.length() / 2
  let left = trimmed.sub(end=midpoint).to_string().trim().to_string()
  let right = trimmed.sub(start=midpoint).to_string().trim().to_string()
  if left != "" && right != "" {
    (left, right)
  } else {
    (trimmed, trimmed)
  }
}

///|
fn build_claims(
  intro : String,
  section_one : String,
  section_two : String,
  section_three : String,
) -> Array[ClaimAnchor] {
  let (section_one_a, section_one_b) = split_claim_pair(section_one)
  let (section_two_a, section_two_b) = split_claim_pair(section_two)
  let (section_three_a, section_three_b) = split_claim_pair(section_three)
  [
    { id: "C1", text: intro },
    { id: "C2", text: section_one_a },
    { id: "C3", text: section_one_b },
    { id: "C4", text: section_two_a },
    { id: "C5", text: section_two_b },
    { id: "C6", text: section_three_a },
    { id: "C7", text: section_three_b },
  ]
}

///|
fn numbered_facts(facts : Array[String]) -> String {
  let builder = StringBuilder::new()
  for index = 0; index < facts.length(); index = index + 1 {
    builder.write_string("[")
    builder.write_string("\{index + 1}")
    builder.write_string("] ")
    builder.write_string(facts[index])
    if index + 1 < facts.length() {
      builder.write_string("\n")
    }
  }
  builder.to_string()
}

///|
fn numbered_claims(claims : Array[ClaimAnchor]) -> String {
  let builder = StringBuilder::new()
  for index = 0; index < claims.length(); index = index + 1 {
    let claim = claims[index]
    builder.write_string(claim.id)
    builder.write_string(": ")
    builder.write_string(claim.text)
    if index + 1 < claims.length() {
      builder.write_string("\n")
    }
  }
  builder.to_string()
}

///|
fn title_case(input : String) -> String {
  let builder = StringBuilder::new()
  let mut first_word = true
  for word in input.split(" ") {
    let current = word.to_string().trim().to_string()
    if current != "" {
      if !first_word {
        builder.write_string(" ")
      }
      builder.write_string(capitalize_ascii(current))
      first_word = false
    }
  }
  builder.to_string()
}

///|
fn capitalize_ascii(input : String) -> String {
  if input.length() == 0 {
    return input
  }
  let lower = input.to_lower()
  let first = lower.sub(end=1).to_string().to_upper()
  if lower.length() == 1 {
    first
  } else {
    "\{first}\{lower.sub(start=1).to_string()}"
  }
}

///|
fn slugify(input : String) -> String {
  let mut slug = input.to_lower()
  slug = slug.replace_all(old="'", new="")
  slug = slug.replace_all(old=":", new="")
  slug = slug.replace_all(old=",", new="")
  slug = slug.replace_all(old=".", new="")
  slug = slug.replace_all(old="(", new="")
  slug = slug.replace_all(old=")", new="")
  slug = slug.replace_all(old="/", new="-")
  slug = slug.replace_all(old=" ", new="-")
  loop slug {
    current =>
      if current.contains("--") {
        continue current.replace_all(old="--", new="-")
      } else {
        slug = current
      }
  }
  slug.trim(chars="-").to_string()
}

///|
fn meta_description(title : String, intro : String) -> String {
  excerpt("\{title}. \{intro}", 155)
}

///|
fn join_opening(
  opening_answer : String,
  opening_problem : String,
  opening_value : String,
) -> String {
  "\{opening_answer} \{opening_problem} \{opening_value}".trim().to_string()
}

///|
fn excerpt(input : String, max_length : Int) -> String {
  if input.length() <= max_length {
    input
  } else {
    "\{input.sub(end=max_length - 1).to_string().trim().to_string()}…"
  }
}

///|
fn build_ai_article_html(
  title : String,
  opening_answer : String,
  opening_problem : String,
  opening_value : String,
  section_one_heading : String,
  section_one_body : String,
  key_points_heading : String,
  key_points_items : Array[String],
  comparison_table_heading : String,
  comparison_table_columns : Array[String],
  comparison_table_rows : Array[String],
  section_two_heading : String,
  section_two_body : String,
  section_three_heading : String,
  section_three_body : String,
  summary_heading : String,
  summary_body : String,
  faq_heading : String,
  faq_one_question : String,
  faq_one_answer : String,
  faq_two_question : String,
  faq_two_answer : String,
  faq_three_question : String,
  faq_three_answer : String,
  facts : Array[String],
  keyword : String,
  lang : String,
) -> String {
  let (section_one_a, section_one_b) = split_claim_pair(section_one_body)
  let (section_two_a, section_two_b) = split_claim_pair(section_two_body)
  let (section_three_a, section_three_b) = split_claim_pair(section_three_body)
  let (section_one_h3a, section_one_h3b) = body_subheading_pair(
    section_one_a, section_one_b, 1, lang,
  )
  let (section_two_h3a, section_two_h3b) = body_subheading_pair(
    section_two_a, section_two_b, 2, lang,
  )
  let (section_three_h3a, section_three_h3b) = body_subheading_pair(
    section_three_a, section_three_b, 3, lang,
  )
  let builder = StringBuilder::new()
  builder.write_string("<article class=\"article-card\">")
  builder.write_string(
    "<h1 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(title))
  builder.write_string("</h1>")
  builder.write_string(
    opening_html("C1", opening_answer, opening_problem, opening_value, keyword),
  )
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_one_heading))
  builder.write_string("</h2>")
  builder.write_string(subheading_html(section_one_h3a))
  builder.write_string(
    claim_paragraph_html(
      "C2",
      section_one_a,
      evidence_html_for_claim(facts, 0, lang),
      false,
      keyword,
    ),
  )
  builder.write_string(subheading_html(section_one_h3b))
  builder.write_string(
    claim_paragraph_html(
      "C3",
      section_one_b,
      evidence_html_for_claim(facts, 1, lang),
      false,
      keyword,
    ),
  )
  builder.write_string("</section>")
  if key_points_heading.trim().to_string() != "" &&
    has_nonempty_items(key_points_items) {
    builder.write_string(
      "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
    )
    builder.write_string(escape_html(key_points_heading))
    builder.write_string("</h2>")
    builder.write_string(bullet_list_html(key_points_items, keyword))
    builder.write_string("</section>")
  }
  if comparison_table_heading.trim().to_string() != "" &&
    comparison_table_columns.length() == 3 &&
    has_nonempty_items(comparison_table_rows) {
    builder.write_string(
      "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
    )
    builder.write_string(escape_html(comparison_table_heading))
    builder.write_string("</h2>")
    builder.write_string(
      comparison_table_html(
        comparison_table_columns, comparison_table_rows, keyword,
      ),
    )
    builder.write_string("</section>")
  }
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_two_heading))
  builder.write_string("</h2>")
  builder.write_string(subheading_html(section_two_h3a))
  builder.write_string(
    claim_paragraph_html(
      "C4",
      section_two_a,
      evidence_html_for_claim(facts, 2, lang),
      false,
      keyword,
    ),
  )
  builder.write_string(subheading_html(section_two_h3b))
  builder.write_string(
    claim_paragraph_html(
      "C5",
      section_two_b,
      evidence_html_for_claim(facts, 3, lang),
      false,
      keyword,
    ),
  )
  builder.write_string("</section>")
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_three_heading))
  builder.write_string("</h2>")
  builder.write_string(subheading_html(section_three_h3a))
  builder.write_string(
    claim_paragraph_html(
      "C6",
      section_three_a,
      evidence_html_for_claim(facts, 4, lang),
      false,
      keyword,
    ),
  )
  builder.write_string(subheading_html(section_three_h3b))
  builder.write_string(
    claim_paragraph_html(
      "C7",
      section_three_b,
      evidence_html_for_claim(facts, 5, lang),
      false,
      keyword,
    ),
  )
  builder.write_string("</section>")
  if summary_heading.trim().to_string() != "" &&
    summary_body.trim().to_string() != "" {
    builder.write_string(
      "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
    )
    builder.write_string(escape_html(summary_heading))
    builder.write_string("</h2>")
    builder.write_string(editable_paragraphs_html(summary_body, keyword))
    builder.write_string("</section>")
  }
  if faq_heading.trim().to_string() != "" &&
    has_visible_faq(
      faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question,
      faq_three_answer,
    ) {
    builder.write_string(
      "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
    )
    builder.write_string(escape_html(faq_heading))
    builder.write_string("</h2>")
    builder.write_string(
      faq_item_html(faq_one_question, faq_one_answer, keyword),
    )
    builder.write_string(
      faq_item_html(faq_two_question, faq_two_answer, keyword),
    )
    builder.write_string(
      faq_item_html(faq_three_question, faq_three_answer, keyword),
    )
    builder.write_string("</section>")
  }
  builder.write_string("</article>")
  builder.to_string()
}

///|
fn has_nonempty_items(items : Array[String]) -> Bool {
  for item in items {
    if item.trim().to_string() != "" {
      return true
    }
  }
  false
}

///|
fn bullet_list_html(items : Array[String], keyword : String) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<ul class=\"article-bullets\">")
  for item in items {
    let trimmed = item.trim().to_string()
    if trimmed != "" {
      builder.write_string(
        "<li class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
      )
      builder.write_string(emphasize_keyword_html(trimmed, keyword))
      builder.write_string("</li>")
    }
  }
  builder.write_string("</ul>")
  builder.to_string()
}

///|
fn comparison_table_html(
  columns : Array[String],
  rows : Array[String],
  keyword : String,
) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<div class=\"article-table-wrap\"><table class=\"article-table\"><thead><tr>",
  )
  for column in columns {
    builder.write_string("<th>")
    builder.write_string(escape_html(column.trim().to_string()))
    builder.write_string("</th>")
  }
  builder.write_string("</tr></thead><tbody>")
  for row in rows {
    let cells = parse_table_row_cells(row)
    if cells.length() == 3 {
      builder.write_string("<tr>")
      for cell in cells {
        builder.write_string(
          "<td class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
        )
        builder.write_string(emphasize_keyword_html(cell, keyword))
        builder.write_string("</td>")
      }
      builder.write_string("</tr>")
    }
  }
  builder.write_string("</tbody></table></div>")
  builder.to_string()
}

///|
fn body_subheading_pair(
  first_text : String,
  second_text : String,
  section_index : Int,
  lang : String,
) -> (String, String) {
  let chinese = is_chinese_ui(lang)
  let fallback = match section_index {
    1 =>
      if chinese {
        ("核心判断", "支撑细节")
      } else {
        ("Core takeaway", "Supporting detail")
      }
    2 =>
      if chinese {
        ("实际体验", "关键差异")
      } else {
        ("Practical use", "Meaningful difference")
      }
    _ =>
      if chinese {
        ("确认重点", "适用边界")
      } else {
        ("What to verify", "Where it may vary")
      }
  }
  (
    infer_body_subheading(first_text, fallback.0, lang),
    infer_body_subheading(second_text, fallback.1, lang),
  )
}

///|
fn subheading_html(text : String) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<h3 class=\"editable-field article-subheading\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(text))
  builder.write_string("</h3>")
  builder.to_string()
}

///|
fn infer_body_subheading(
  text : String,
  fallback : String,
  lang : String,
) -> String {
  let trimmed = text.trim().to_string()
  if trimmed == "" {
    return fallback
  }
  let first_sentence = sentence_or_text(trimmed)
  let candidate = short_heading_candidate(first_sentence, lang)
  if candidate == "" {
    fallback
  } else {
    candidate
  }
}

///|
fn sentence_or_text(text : String) -> String {
  let sentences = split_sentences(text)
  if sentences.length() > 0 {
    sentences[0]
  } else {
    text
  }
}

///|
fn short_heading_candidate(text : String, lang : String) -> String {
  let cleaned = sanitize_heading_source(text)
  if cleaned == "" {
    return ""
  }
  if looks_like_meta_instruction(cleaned, lang) {
    return ""
  }
  if is_chinese_ui(lang) {
    excerpt(cleaned, 12).trim().to_string()
  } else {
    let words = []
    for raw in cleaned.split(" ") {
      let current = raw.to_string().trim().to_string()
      if current != "" {
        words.push(current)
      }
      if words.length() >= 4 {
        break
      }
    }
    if words.length() == 0 {
      ""
    } else {
      title_case(join_words(words))
    }
  }
}

///|
fn looks_like_meta_instruction(text : String, lang : String) -> Bool {
  let trimmed = text.trim().to_string()
  if trimmed == "" {
    return false
  }
  if is_chinese_ui(lang) {
    trimmed.contains("这一节应") ||
    trimmed.contains("本节应") ||
    trimmed.contains("小节应") ||
    trimmed.contains("文章应") ||
    trimmed.contains("FAQ 前") ||
    trimmed.contains("总结型小节")
  } else {
    let lower = trimmed.to_lower()
    lower.has_prefix("the opening section should") ||
    lower.has_prefix("the middle section should") ||
    lower.has_prefix("the closing section should") ||
    lower.has_prefix("this summary section should") ||
    lower.has_prefix("before the faq") ||
    lower.has_prefix("rather than forcing") ||
    lower.has_prefix("a strong closing section should")
  }
}

///|
fn sanitize_heading_source(text : String) -> String {
  text
  .replace_all(old=":", new=" ")
  .replace_all(old=";", new=" ")
  .replace_all(old=",", new=" ")
  .replace_all(old=".", new=" ")
  .replace_all(old="。", new=" ")
  .replace_all(old="！", new=" ")
  .replace_all(old="？", new=" ")
  .replace_all(old="(", new=" ")
  .replace_all(old=")", new=" ")
  .trim()
  .to_string()
}

///|
fn join_words(words : Array[String]) -> String {
  let builder = StringBuilder::new()
  for index = 0; index < words.length(); index = index + 1 {
    if index > 0 {
      builder.write_string(" ")
    }
    builder.write_string(words[index])
  }
  builder.to_string()
}

///|
fn parse_table_row_cells(row : String) -> Array[String] {
  let cells = []
  for part in row.split("|") {
    let cell = part.to_string().trim().to_string()
    if cell != "" {
      cells.push(cell)
    }
  }
  if cells.length() == 3 {
    cells
  } else {
    []
  }
}

///|
fn has_visible_faq(
  faq_one_question : String,
  faq_one_answer : String,
  faq_two_question : String,
  faq_two_answer : String,
  faq_three_question : String,
  faq_three_answer : String,
) -> Bool {
  faq_one_question.trim().to_string() != "" &&
  faq_one_answer.trim().to_string() != "" &&
  faq_two_question.trim().to_string() != "" &&
  faq_two_answer.trim().to_string() != "" &&
  faq_three_question.trim().to_string() != "" &&
  faq_three_answer.trim().to_string() != ""
}

///|
fn faq_item_html(
  question : String,
  answer : String,
  keyword : String,
) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"faq-item\">")
  builder.write_string(
    "<h3 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(emphasize_keyword_html(question, keyword))
  builder.write_string("</h3>")
  builder.write_string(
    "<p class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(emphasize_keyword_html(answer, keyword))
  builder.write_string("</p>")
  builder.write_string("</div>")
  builder.to_string()
}

///|
fn opening_html(
  claim_id : String,
  opening_answer : String,
  opening_problem : String,
  opening_value : String,
  keyword : String,
) -> String {
  claim_paragraphs_html(
    claim_id,
    join_nonempty_parts([opening_answer, opening_problem, opening_value]),
    "",
    true,
    keyword,
  )
}

///|
fn editable_paragraph_html(text : String, keyword : String) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<p class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(emphasize_keyword_html(text, keyword))
  builder.write_string("</p>")
  builder.to_string()
}

///|
fn editable_paragraphs_html(text : String, keyword : String) -> String {
  let paragraphs = split_paragraph_blocks(text)
  if paragraphs.length() == 0 {
    ""
  } else {
    let builder = StringBuilder::new()
    for paragraph in paragraphs {
      builder.write_string(editable_paragraph_html(paragraph, keyword))
    }
    builder.to_string()
  }
}

///|
fn split_paragraph_blocks(text : String) -> Array[String] {
  let normalized = text
    .replace_all(old="\r\n", new="\n")
    .replace_all(old="\n\n", new="\u001E")
  let explicit = []
  for part in normalized.split("\u001E") {
    let trimmed = part.to_string().trim().to_string()
    if trimmed != "" {
      for paragraph in sentence_groups(trimmed) {
        explicit.push(paragraph)
      }
    }
  }
  if explicit.length() > 0 {
    return explicit
  }
  sentence_groups(text)
}

///|
fn sentence_groups(text : String) -> Array[String] {
  let trimmed = text.trim().to_string()
  if trimmed == "" {
    return []
  }
  let sentences = split_sentences(trimmed)
  if sentences.length() <= 3 {
    return [trimmed]
  }
  let groups = []
  let mut index = 0
  while index < sentences.length() {
    let remaining = sentences.length() - index
    let take = if remaining <= 3 {
      remaining
    } else if remaining == 4 {
      2
    } else if remaining == 5 {
      3
    } else if remaining % 3 == 1 {
      2
    } else {
      3
    }
    groups.push(join_slice(sentences, index, index + take))
    index = index + take
  }
  groups
}

///|
fn join_nonempty_parts(parts : Array[String]) -> String {
  let builder = StringBuilder::new()
  let mut wrote = false
  for part in parts {
    let current = part.trim().to_string()
    if current != "" {
      if wrote {
        builder.write_string(" ")
      }
      builder.write_string(current)
      wrote = true
    }
  }
  builder.to_string()
}

///|
fn evidence_html_for_claim(
  facts : Array[String],
  fact_index : Int,
  lang : String,
) -> String {
  let fact = fact_or_empty(facts, fact_index)
  if fact == "" {
    ""
  } else {
    evidence_ref_html(fact_index + 1, fact, lang)
  }
}

///|
fn claim_paragraph_html(
  claim_id : String,
  text : String,
  evidence_html : String,
  is_lede : Bool,
  keyword : String,
) -> String {
  claim_paragraphs_html(claim_id, text, evidence_html, is_lede, keyword)
}

///|
fn claim_paragraphs_html(
  claim_id : String,
  text : String,
  evidence_html : String,
  is_lede : Bool,
  keyword : String,
) -> String {
  let paragraphs = split_paragraph_blocks(text)
  if paragraphs.length() == 0 {
    return ""
  }
  let builder = StringBuilder::new()
  for index = 0; index < paragraphs.length(); index = index + 1 {
    let paragraph = paragraphs[index]
    builder.write_string("<p")
    if index == 0 {
      builder.write_string(" id=\"claim-")
      builder.write_string(claim_id)
      builder.write_string("\"")
    }
    builder.write_string(" class=\"")
    if index == 0 && is_lede {
      builder.write_string("lede claim-block")
    } else {
      builder.write_string("claim-block")
    }
    builder.write_string("\" data-claim-id=\"")
    builder.write_string(claim_id)
    builder.write_string(
      "\"><span class=\"claim-copy editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
    )
    builder.write_string(emphasize_keyword_html(paragraph, keyword))
    builder.write_string("</span>")
    if index + 1 == paragraphs.length() &&
      evidence_html.trim().to_string() != "" {
      builder.write_string("<span class=\"claim-inline-evidence\"> ")
      builder.write_string(evidence_html)
      builder.write_string("</span>")
    }
    builder.write_string("</p>")
  }
  builder.to_string()
}

///|
fn evidence_ref_html(
  index : Int,
  evidence_text : String,
  lang : String,
) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string(
    "<button class=\"evidence-ref\" type=\"button\" data-evidence-label=\"",
  )
  builder.write_string(
    escape_html(
      if chinese {
        "正文证据标记 [S\{index}]"
      } else {
        "Body evidence marker [S\{index}]"
      },
    ),
  )
  builder.write_string("\" data-evidence-text=\"")
  builder.write_string(escape_html(evidence_text))
  builder.write_string("\" data-source-id=\"")
  builder.write_string("\{index}")
  builder.write_string("\" data-evidence-source=\"")
  builder.write_string(
    escape_html(
      if chinese {
        "用于标记正文对应的来源摘录"
      } else {
        "Marks the source excerpt used beside the body"
      },
    ),
  )
  builder.write_string("\">[S")
  builder.write_string("\{index}")
  builder.write_string("]</button>")
  builder.to_string()
}

///|
fn build_preview_html(article_html : String) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"preview-shell\">")
  builder.write_string("<div class=\"preview-grid\">")
  builder.write_string(article_html)
  builder.write_string("</div></div>")
  builder.to_string()
}

///|
fn build_export_html(
  title : String,
  meta_description : String,
  article_html : String,
  slug : String,
  lang : String,
) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string(
    if chinese {
      "<!DOCTYPE html><html lang=\"zh\"><head><meta charset=\"UTF-8\" />"
    } else {
      "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\" />"
    },
  )
  builder.write_string(
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />",
  )
  builder.write_string("<title>")
  builder.write_string(escape_html(title))
  builder.write_string("</title><meta name=\"description\" content=\"")
  builder.write_string(escape_html(meta_description))
  builder.write_string("\" /><meta name=\"slug\" content=\"")
  builder.write_string(escape_html(slug))
  builder.write_string("\" /><style>")
  builder.write_string(
    "body{margin:0;font-family:Georgia,'Times New Roman',serif;background:#f6f0e8;color:#1e1d1a;}main{max-width:1120px;margin:0 auto;padding:48px 24px 72px;}h1,h2,h3{font-family:'Avenir Next','Helvetica Neue',sans-serif;} .layout{display:grid;grid-template-columns:1fr;gap:24px;align-items:start;} .article-card{padding:0;background:transparent;border:0;border-radius:0;} .article-card h1{margin:0 0 12px;} .article-card p{margin:0;line-height:1.62;} .article-card p+p{margin-top:14px;} section+section{margin-top:20px;} .evidence-ref{display:inline-flex;align-items:center;justify-content:center;min-width:24px;height:24px;margin-left:4px;border:0;border-radius:999px;background:rgba(155,92,29,.12);color:#9b5c1d;font-size:12px;font-weight:700;vertical-align:middle;} @media (max-width:900px){.layout{grid-template-columns:1fr;}}",
  )
  builder.write_string("</style></head><body><main><div class=\"layout\">")
  builder.write_string(article_html)
  builder.write_string("</div></main></body></html>")
  builder.to_string()
}

///|
pub fn render_export_html_document(
  title : String,
  meta_description : String,
  article_html : String,
  slug : String,
  lang : String,
) -> String {
  build_export_html(title, meta_description, article_html, slug, lang)
}

///|
fn audit_draft(draft : Draft, lang : String) -> AuditReport {
  let chinese = is_chinese_ui(lang)
  let keyword_occurrences = count_keyword_occurrences(
    draft.plain_text,
    draft.keyword,
  )
  let keyword_label = if draft.keyword.trim().to_string() == "" {
    if chinese {
      "未指定"
    } else {
      "Not set"
    }
  } else {
    draft.keyword
  }
  let word_count = count_words(draft.plain_text)
  let keyword_density = if word_count == 0 {
    0
  } else {
    keyword_occurrences * 100 / word_count
  }
  let findings : Array[AuditFinding] = [
    {
      title: if chinese {
        "标题长度"
      } else {
        "Title length"
      },
      passed: draft.title.length() >= 35 && draft.title.length() <= 70,
      detail: if chinese {
        "当前 SEO 标题长度为 \{draft.title.length()} 个字符。"
      } else {
        "The SEO title is \{draft.title.length()} characters long."
      },
    },
    {
      title: if chinese {
        "Slug 规范"
      } else {
        "Slug hygiene"
      },
      passed: draft.slug.length() <= 60 && !draft.slug.contains("--"),
      detail: if chinese {
        "导出 slug：\{draft.slug}"
      } else {
        "Clean export slug: \{draft.slug}"
      },
    },
    {
      title: if chinese {
        "Meta 描述"
      } else {
        "Meta description"
      },
      passed: draft.meta_description.length() >= 110 &&
      draft.meta_description.length() <= 160,
      detail: if chinese {
        "Meta 描述长度为 \{draft.meta_description.length()} 个字符。"
      } else {
        "Meta description length: \{draft.meta_description.length()} characters."
      },
    },
    {
      title: if chinese {
        "正文长度"
      } else {
        "Body length"
      },
      passed: word_count >= 1300 && word_count <= 1800,
      detail: if chinese {
        "当前草稿长度为 \{word_count} 个单词。"
      } else {
        "Draft length: \{word_count} words."
      },
    },
    {
      title: if chinese {
        "关键词分布"
      } else {
        "Keyword footprint"
      },
      passed: keyword_occurrences >= 2 &&
      keyword_occurrences <= 6 &&
      keyword_density <= 3,
      detail: if chinese {
        "当前主关键词：\{keyword_label}；在草稿中共出现 \{keyword_occurrences} 次。"
      } else {
        "Current primary keyword: \{keyword_label}. It appears \{keyword_occurrences} times across the draft."
      },
    },
    {
      title: if chinese {
        "标题结构"
      } else {
        "Heading structure"
      },
      passed: count_occurrences(draft.article_html, "<h2") >= 3 &&
      count_occurrences(draft.article_html, "<h3") >= 3,
      detail: if chinese {
        "页面包含可扫描的 H2 分节，并且正文里出现了 H3 小标题。"
      } else {
        "The page includes scannable H2 sections plus H3 subheadings in the body."
      },
    },
    {
      title: if chinese {
        "表述风险"
      } else {
        "Claim safety"
      },
      passed: !contains_banned_claims(draft.plain_text),
      detail: claim_safety_detail(draft.plain_text, lang),
    },
    {
      title: if chinese {
        "证据覆盖"
      } else {
        "Evidence coverage"
      },
      passed: draft.evidence_count >= 3,
      detail: if chinese {
        "当前草稿可按需展开 \{draft.evidence_count} 条来源事实。"
      } else {
        "The draft exposes \{draft.evidence_count} source notes on demand."
      },
    },
  ]
  let mut pass_count = 0
  for finding in findings {
    if finding.passed {
      pass_count += 1
    }
  }
  let total_count = findings.length()
  let score = pass_count * 100 / total_count
  let summary_text = if chinese {
    "SEO 就绪度：\{score}/100（通过 \{pass_count}/\{total_count} 项）"
  } else {
    "SEO readiness score: \{score}/100 (\{pass_count}/\{total_count} checks passed)"
  }
  let summary_html = if chinese {
    "<div class=\"score-card\"><strong>\{score}/100</strong><p>共通过 \{pass_count}/\{total_count} 项确定性检查。</p></div>"
  } else {
    "<div class=\"score-card\"><strong>\{score}/100</strong><p>\{pass_count} of \{total_count} deterministic checks passed.</p></div>"
  }
  let findings_html = render_findings(findings, lang)
  { score, pass_count, total_count, summary_text, summary_html, findings_html }
}

///|
fn render_findings(findings : Array[AuditFinding], lang : String) -> String {
  let chinese = is_chinese_ui(lang)
  let evidence_coverage_title = if chinese {
    "证据覆盖"
  } else {
    "Evidence coverage"
  }
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"audit-list\">")
  for finding in findings {
    if !finding.passed {
      render_single_finding(builder, finding, chinese, evidence_coverage_title)
    }
  }
  for finding in findings {
    if finding.passed {
      render_single_finding(builder, finding, chinese, evidence_coverage_title)
    }
  }
  builder.write_string("</div>")
  builder.to_string()
}

///|
fn field_or_empty(fields : Array[String], index : Int) -> String {
  if index < fields.length() {
    fields[index]
  } else {
    ""
  }
}

///|
fn find_claim_record(
  items : Array[Array[String]],
  claim_id : String,
) -> Array[String] {
  for fields in items {
    if field_or_empty(fields, 0).trim().to_string() == claim_id {
      return fields
    }
  }
  []
}

///|
fn normalize_claim_verdict(value : String) -> String {
  let lower = value.trim().to_string().to_lower()
  if lower == "supported" {
    "supported"
  } else if lower == "unsupported" {
    "unsupported"
  } else {
    "needs_review"
  }
}

///|
fn render_claim_review_item(
  builder : StringBuilder,
  claim_id : String,
  _claim : String,
  verdict : String,
  evidence_numbers : String,
  reason : String,
  rewrite : String,
  source_notes : Array[String],
  lang : String,
) -> Unit {
  let chinese = is_chinese_ui(lang)
  let tone = if verdict == "supported" { "pass" } else { "warn" }
  let badge = if verdict == "supported" {
    if chinese {
      "已支撑"
    } else {
      "Supported"
    }
  } else if verdict == "unsupported" {
    if chinese {
      "不支撑"
    } else {
      "Unsupported"
    }
  } else if chinese {
    "需复核"
  } else {
    "Needs review"
  }
  builder.write_string("<article class=\"claim-card ")
  builder.write_string(tone)
  builder.write_string("\" id=\"review-")
  builder.write_string(claim_id)
  builder.write_string("\" data-claim-id=\"")
  builder.write_string(claim_id)
  builder.write_string("\" data-stale-status=\"")
  builder.write_string(
    escape_html(
      if chinese {
        "待重审"
      } else {
        "Re-review needed"
      },
    ),
  )
  builder.write_string("\">")
  builder.write_string(
    "<button type=\"button\" class=\"claim-link\" data-claim-id=\"",
  )
  builder.write_string(claim_id)
  builder.write_string("\"><span class=\"claim-chip\">")
  builder.write_string(claim_id)
  builder.write_string("</span><span class=\"claim-status\">")
  builder.write_string(badge)
  builder.write_string("</span></button>")
  builder.write_string("<div class=\"claim-detail\">")
  builder.write_string("<p class=\"claim-reason claim-reason-lead\"><strong>")
  builder.write_string(
    if chinese {
      "为什么判定"
    } else {
      "Why it was flagged"
    },
  )
  builder.write_string("</strong><span>")
  builder.write_string(escape_html(reason))
  builder.write_string("</span></p>")
  builder.write_string("<div class=\"source-stack\">")
  render_source_excerpt_list(builder, evidence_numbers, source_notes, lang)
  builder.write_string("</div>")
  if verdict != "supported" && rewrite.trim().to_string() != "" {
    builder.write_string(
      "<div class=\"claim-rewrite-box\"><p class=\"claim-rewrite\">",
    )
    builder.write_string(
      escape_html(
        if chinese {
          "建议改写：\{rewrite}"
        } else {
          "Suggested rewrite: \{rewrite}"
        },
      ),
    )
    builder.write_string(
      "</p><button type=\"button\" class=\"claim-apply\" data-claim-id=\"",
    )
    builder.write_string(claim_id)
    builder.write_string("\" data-claim-rewrite=\"")
    builder.write_string(escape_html(rewrite))
    builder.write_string("\">")
    builder.write_string(
      if chinese {
        "一键优化"
      } else {
        "Rewrite with sources"
      },
    )
    builder.write_string("</button><p class=\"claim-apply-note\" hidden>")
    builder.write_string(
      if chinese {
        "已应用到左侧草稿。"
      } else {
        "Applied to the draft on the left."
      },
    )
    builder.write_string("</p></div>")
  }
  builder.write_string("</div></article>")
}

///|
fn render_source_excerpt_list(
  builder : StringBuilder,
  evidence_numbers : String,
  source_notes : Array[String],
  lang : String,
) -> Unit {
  let chinese = is_chinese_ui(lang)
  let source_ids = parse_evidence_numbers(evidence_numbers)
  if source_ids.length() == 0 {
    builder.write_string("<div class=\"source-note empty\"><p>")
    builder.write_string(
      escape_html(
        if chinese {
          "当前没有找到可支撑这条 claim 的来源条目。"
        } else {
          "No source note was returned to support this claim."
        },
      ),
    )
    builder.write_string("</p></div>")
    return
  }
  let mut rendered = 0
  for source_id in source_ids {
    let source_note = lookup_source_note(source_notes, source_id)
    let preview = compact_source_excerpt(source_note)
    let usable_excerpt = preview.trim().to_string().length() >= 12
    if !usable_excerpt {
      continue
    }
    builder.write_string("<article class=\"source-note\" data-source-id=\"")
    builder.write_string(source_id)
    if source_note != "" {
      builder.write_string("\" title=\"")
      builder.write_string(escape_html(source_note))
    }
    builder.write_string(
      "\"><div class=\"source-note-head\"><span class=\"source-pill\">[",
    )
    builder.write_string(source_id)
    builder.write_string("]</span><strong>")
    builder.write_string(
      if chinese {
        "来源材料摘录"
      } else {
        "Source material excerpt"
      },
    )
    builder.write_string("</strong></div><p class=\"source-note-copy\">")
    builder.write_string(
      escape_html(
        if source_note == "" {
          if chinese {
            "当前没有找到对应的来源摘录。"
          } else {
            "No matching source excerpt was found for this source ID."
          }
        } else {
          preview
        },
      ),
    )
    builder.write_string("</p></article>")
    rendered += 1
  }
  if rendered == 0 {
    builder.write_string("<div class=\"source-note empty\"><p>")
    builder.write_string(
      escape_html(
        if chinese {
          "当前没有可展示的证据预览。请回看原文件，或补充更结构化的 fact sheet。"
        } else {
          "No usable evidence preview is available yet. Check the original file or add a more structured fact sheet."
        },
      ),
    )
    builder.write_string("</p></div>")
  }
}

///|
fn compact_source_excerpt(source_note : String) -> String {
  let normalized = source_note
    .replace_all(old="\r", new=" ")
    .replace_all(old="\n", new=" ")
    .split(" ")
    .filter_map(part => {
      let current = part.trim().to_string()
      if current == "" {
        None
      } else {
        Some(current)
      }
    })
    .join(" ")
  if normalized.length() <= 180 {
    normalized
  } else {
    "\{normalized.sub(end=180).to_string()}..."
  }
}

///|
fn parse_evidence_numbers(evidence_numbers : String) -> Array[String] {
  let source_ids = []
  for part in evidence_numbers.split(",") {
    let trimmed = part.to_string().trim().to_string()
    if trimmed != "" {
      source_ids.push(trimmed)
    }
  }
  source_ids
}

///|
fn lookup_source_note(
  source_notes : Array[String],
  source_id : String,
) -> String {
  let target = source_id.trim().to_string()
  for index = 0; index < source_notes.length(); index = index + 1 {
    if "\{index + 1}" == target {
      return source_notes[index]
    }
  }
  ""
}

///|
fn render_single_finding(
  builder : StringBuilder,
  finding : AuditFinding,
  chinese : Bool,
  evidence_coverage_title : String,
) -> Unit {
  let is_evidence_coverage = finding.title == evidence_coverage_title
  let tone = if finding.passed { "pass" } else { "warn" }
  let badge = if finding.passed {
    if chinese {
      "通过"
    } else {
      "Pass"
    }
  } else if chinese {
    "待优化"
  } else {
    "Needs work"
  }
  builder.write_string("<article class=\"audit-item ")
  builder.write_string(tone)
  if is_evidence_coverage {
    builder.write_string(
      "\" id=\"evidenceCoverageCard\"><div class=\"audit-top\"><strong>",
    )
  } else {
    builder.write_string("\"><div class=\"audit-top\"><strong>")
  }
  builder.write_string(escape_html(finding.title))
  builder.write_string("</strong><span>")
  builder.write_string(badge)
  builder.write_string("</span></div><p>")
  builder.write_string(escape_html(finding.detail))
  builder.write_string("</p>")
  if is_evidence_coverage {
    builder.write_string(
      "<div id=\"evidenceCoverageDetail\" class=\"audit-detail-panel\">",
    )
    builder.write_string(
      if chinese {
        "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">当前校对证据</p><h4 id=\"evidenceCoverageTitle\">等待选择</h4><div id=\"evidenceCoverageBody\" class=\"evidence-excerpt\"><p>点击正文中的证据编号后，这里会展开对应来源内容。</p></div>"
      } else {
        "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">Current evidence</p><h4 id=\"evidenceCoverageTitle\">Waiting for selection</h4><div id=\"evidenceCoverageBody\" class=\"evidence-excerpt\"><p>Click an inline evidence marker in the draft to inspect the matching source note here.</p></div>"
      },
    )
    builder.write_string("</div>")
  }
  builder.write_string("</article>")
}

///|
fn contains_banned_claims(text : String) -> Bool {
  let lower = text.to_lower()
  lower.contains("best") ||
  lower.contains("guaranteed") ||
  lower.contains("#1") ||
  lower.contains("perfect")
}

///|
fn claim_safety_detail(text : String, lang : String) -> String {
  let chinese = is_chinese_ui(lang)
  if contains_banned_claims(text) {
    if chinese {
      "草稿中包含 best、guaranteed、perfect 或 #1 这类高风险营销表述。"
    } else {
      "The draft includes a risky marketing superlative such as best, guaranteed, perfect, or #1."
    }
  } else if chinese {
    "当前草稿避开了高风险营销形容词。"
  } else {
    "The current copy avoids risky marketing superlatives."
  }
}

///|
fn is_chinese_ui(lang : String) -> Bool {
  lang == "zh"
}

///|
fn count_words(text : String) -> Int {
  let normalized = text
    .replace_all(old="\n", new=" ")
    .replace_all(old=",", new=" ")
    .replace_all(old=".", new=" ")
    .replace_all(old=":", new=" ")
    .replace_all(old=";", new=" ")
    .replace_all(old="(", new=" ")
    .replace_all(old=")", new=" ")
    .replace_all(old="[", new=" ")
    .replace_all(old="]", new=" ")
  let mut count = 0
  for token in normalized.split(" ") {
    if token.to_string().trim().to_string() != "" {
      count += 1
    }
  }
  count
}

///|
fn count_keyword_occurrences(text : String, keyword : String) -> Int {
  count_occurrences(text.to_lower(), keyword.to_lower())
}

///|
fn count_occurrences(text : String, needle : String) -> Int {
  if needle == "" || text.length() < needle.length() {
    return 0
  }
  let mut index = 0
  let mut count = 0
  let last_start = text.length() - needle.length()
  while index <= last_start {
    if text.sub(start=index, end=index + needle.length()).to_string() == needle {
      count += 1
      index += needle.length()
    } else {
      index += 1
    }
  }
  count
}

///|
fn escape_html(input : String) -> String {
  input
  .replace_all(old="&", new="&amp;")
  .replace_all(old="<", new="&lt;")
  .replace_all(old=">", new="&gt;")
  .replace_all(old="\"", new="&quot;")
}

///|
fn emphasize_keyword_html(text : String, keyword : String) -> String {
  let needle = keyword.trim().to_string()
  if needle == "" {
    return escape_html(text)
  }
  let lower_text = text.to_lower()
  let lower_needle = needle.to_lower()
  if lower_text == "" ||
    lower_needle == "" ||
    lower_text.length() < lower_needle.length() {
    return escape_html(text)
  }
  let builder = StringBuilder::new()
  let mut cursor = 0
  let mut start = 0
  let mut matched = false
  while cursor + lower_needle.length() <= lower_text.length() {
    let current = lower_text
      .sub(start=cursor, end=cursor + lower_needle.length())
      .to_string()
    if current == lower_needle {
      matched = true
      builder.write_string(
        escape_html(text.sub(start~, end=cursor).to_string()),
      )
      builder.write_string("<strong>")
      builder.write_string(
        escape_html(
          text.sub(start=cursor, end=cursor + lower_needle.length()).to_string(),
        ),
      )
      builder.write_string("</strong>")
      cursor = cursor + lower_needle.length()
      start = cursor
    } else {
      cursor = cursor + 1
    }
  }
  if !matched {
    return escape_html(text)
  }
  builder.write_string(escape_html(text.sub(start~).to_string()))
  builder.to_string()
}
