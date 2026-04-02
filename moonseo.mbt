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
  let chinese = is_chinese_ui(lang)
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = inferred_keyword(
    primary_keyword, article_title, safe_brand,
  )
  let safe_audience = normalize_or_default(audience, "readers")
  let facts = parse_facts(facts_raw)
  let title = normalize_or_default(
    article_title,
    "\{safe_brand} \{title_case(safe_keyword)} for \{safe_audience}",
  )
  let slug = slugify(title)
  let first_fact = fact_or_empty(facts, 0)
  let second_fact = fact_or_empty(facts, 1)
  let third_fact = fact_or_empty(facts, 2)
  let intro = if has_real_sources(facts_raw) {
    "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This prototype turns approved source material into a fuller draft that stays grounded in documented claims, keeps search intent visible, and prepares the page for static publishing. Instead of relying on vague marketing copy, it frames the topic around what \{safe_audience} actually need to evaluate before they publish."
  } else {
    "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This prototype sketches a publishable draft structure while keeping factual claims conservative until real source material is added. It frames the topic around what \{safe_audience} actually need to evaluate before they publish, without pretending the evidence is already there."
  }
  let section_one_heading = if chinese {
    "搜索意图聚焦"
  } else {
    "Search intent focus"
  }
  let section_two_heading = if chinese {
    "有依据支撑的品牌表达"
  } else {
    "Evidence-backed brand claims"
  }
  let section_three_heading = if chinese {
    "发布前 SEO 检查清单"
  } else {
    "Pre-publish SEO checklist"
  }
  let section_one = if first_fact != "" {
    "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays tied to a concrete source note: \{first_fact}. That keeps the first section useful for readers who want evidence quickly, while also giving search engines a clearer signal about the page's core topic and intent."
  } else {
    "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening section stays focused on the reader problem and the publishing decision in front of them. That keeps the page specific enough to be useful, even before detailed source material has been added."
  }
  let section_two = if second_fact != "" && third_fact != "" {
    "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes such as \{second_fact} and \{third_fact}, which makes stakeholder review faster and reduces the risk of unsupported claims. When every core point is backed by a visible source note, the draft becomes easier to edit, safer to approve, and more credible once published."
  } else if first_fact != "" {
    "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes instead of guessing what the brand can actually support. That makes stakeholder review faster, reduces the risk of unsupported claims, and keeps the final page closer to what the source material really says."
  } else {
    "The page also keeps unsupported claims in check. Reviewers can see where the draft is still generic, where a real source excerpt is still needed, and which statements should stay conservative until material arrives. That makes stakeholder review faster and reduces the risk of overclaiming."
  }
  let section_three = "Before export, the workflow still checks the basics that matter in SEO production: a readable slug, a balanced keyword footprint, a usable meta description, clear H2 sections, evidence coverage, and wording that avoids risky overclaiming. That combination makes the page easier to review, easier to trust, and easier to publish. It also helps teams move from draft to launch without losing the factual discipline that strong SEO content needs."
  let claims = build_claims(intro, section_one, section_two, section_three)
  let article_html = build_ai_article_html(
    title, intro, section_one_heading, section_one, section_two_heading, section_two,
    section_three_heading, section_three, facts, lang,
  )
  let description = meta_description(title, intro)
  let preview_html = build_preview_html(article_html)
  let plain_text = "\{title} \{intro} \{section_one} \{section_two} \{section_three}"
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
  ai_payload : String,
  lang : String,
) -> (Draft, AuditReport) {
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
  let intro_fallback = if has_real_sources(facts_raw) {
    "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This AI-assisted draft stays grounded in approved claims, keeps search intent visible, and prepares the page for static publishing."
  } else {
    "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This AI-assisted draft keeps search intent visible while staying conservative until real source material is added."
  }
  let section_one_heading_fallback = if is_chinese_ui(lang) {
    "搜索意图聚焦"
  } else {
    "Search intent focus"
  }
  let section_two_heading_fallback = if is_chinese_ui(lang) {
    "有依据支撑的品牌表达"
  } else {
    "Evidence-backed brand claims"
  }
  let section_three_heading_fallback = if is_chinese_ui(lang) {
    "发布前 SEO 检查清单"
  } else {
    "Pre-publish SEO checklist"
  }
  let section_one_body_fallback = if is_chinese_ui(lang) && first_fact != "" {
    "对 \{safe_audience} 来说，\{safe_keyword} 最有效的写法，是回答一个具体且实用的问题，而不是泛泛的 AI 文案。当前草稿把开场信息绑定到一条明确的来源依据：\{first_fact}。"
  } else if is_chinese_ui(lang) {
    "对 \{safe_audience} 来说，\{safe_keyword} 最有效的写法，是回答一个具体且实用的问题，而不是泛泛的 AI 文案。当前草稿会先聚焦真实的受众问题，并在缺少来源时保持表述克制。"
  } else if first_fact != "" {
    "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays tied to a concrete source note: \{first_fact}."
  } else {
    "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays focused on the reader problem and keeps unsupported details out."
  }
  let section_two_body_fallback = if is_chinese_ui(lang) &&
    second_fact != "" &&
    third_fact != "" {
    "页面也会把证据保持在文案附近。审阅者可以追溯到这些已批准来源：\{second_fact}；\{third_fact}。"
  } else if is_chinese_ui(lang) {
    "页面也会把证据与文案分开处理。只要来源还不充分，草稿就会提示需要补充材料，而不是把备注或推测写成既成事实。"
  } else if second_fact != "" && third_fact != "" {
    "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes such as \{second_fact} and \{third_fact}."
  } else {
    "The page also keeps evidence and writing intent separate. When source support is thin, the draft stays explicit about where materials are still missing instead of turning notes or guesses into facts."
  }
  let section_three_body_fallback = if is_chinese_ui(lang) {
    "在导出之前，流程仍会检查 SEO 发布里最重要的基础项：可读的 slug、合理的关键词分布、可用的 meta 描述、清晰的 H2 结构、证据覆盖，以及规避高风险营销表述。"
  } else {
    "Before export, the workflow still checks the basics that matter in SEO production: a readable slug, a balanced keyword footprint, a usable meta description, clear H2 sections, evidence coverage, and wording that avoids risky overclaiming."
  }
  let raw_ai_title = payload_value(
    parts,
    0,
    safe_generated_title(safe_keyword, safe_audience, lang),
  )
  let ai_intro = payload_value(parts, 2, intro_fallback)
  let ai_title = if article_title.trim().to_string() != "" {
    article_title.trim().to_string()
  } else {
    sanitize_generated_title(raw_ai_title, safe_keyword, safe_audience, lang)
  }
  let ai_meta = clamp_meta_description(
    payload_value(parts, 1, meta_description(ai_title, ai_intro)),
    ai_title,
    ai_intro,
  )
  let section_one_heading = payload_value(
    parts, 3, section_one_heading_fallback,
  )
  let section_one_body = payload_value(parts, 4, section_one_body_fallback)
  let section_two_heading = payload_value(
    parts, 5, section_two_heading_fallback,
  )
  let section_two_body = payload_value(parts, 6, section_two_body_fallback)
  let section_three_heading = payload_value(
    parts, 7, section_three_heading_fallback,
  )
  let section_three_body = payload_value(parts, 8, section_three_body_fallback)
  let claims = build_claims(
    ai_intro, section_one_body, section_two_body, section_three_body,
  )
  let article_html = build_ai_article_html(
    ai_title, ai_intro, section_one_heading, section_one_body, section_two_heading,
    section_two_body, section_three_heading, section_three_body, facts, lang,
  )
  let plain_text = "\{ai_title} \{ai_intro} \{section_one_body} \{section_two_body} \{section_three_body}"
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
  {
    supported_count: 0,
    needs_review_count: 0,
    unsupported_count: 0,
    total_count,
    audit_available: true,
    summary_html: "",
    findings_html: if chinese {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>事实支撑</strong><p>逐条事实核对暂时不可用，但 MoonBit 规则检查仍然有效。</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim review unavailable</strong><span>待重试</span></div><p>\{escape_html(message)}</p></article></div></details>"
    } else {
      "<details id=\"factAuditSection\" class=\"audit-accordion\"><summary class=\"audit-accordion-summary\"><div><strong>Fact grounding</strong><p>The semantic review is unavailable for now, but the MoonBit rule checks still ran.</p></div><span class=\"audit-summary-count\">0/\{total_count}</span></summary><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim review unavailable</strong><span>Retry needed</span></div><p>\{escape_html(message)}</p></article></div></details>"
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
  builder.write_string("<section class=\"claim-group claim-group-review\">")
  builder.write_string("<div class=\"claim-group-head\"><h4>")
  builder.write_string(
    if chinese {
      "需复核 claims"
    } else {
      "Claims needing review"
    },
  )
  builder.write_string("</h4><span>")
  builder.write_string("\{review_count}")
  builder.write_string("</span></div><div class=\"claim-list\">")
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
  builder.write_string("</div></section>")
  builder.write_string("<section class=\"claim-group claim-group-supported\">")
  builder.write_string("<div class=\"claim-group-head\"><h4>")
  builder.write_string(
    if chinese {
      "已支撑 claims"
    } else {
      "Supported claims"
    },
  )
  builder.write_string("</h4><span>")
  builder.write_string("\{supported}")
  builder.write_string("</span></div><div class=\"claim-list\">")
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
  builder.write_string("</div></section></div></details>")
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
  let chinese = is_chinese_ui(lang)
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
    bullet_lines(facts, "")
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
    "请为一个品牌/产品主题页面生成文案，且只返回原始 JSON，不要返回 Markdown 代码块。\n\n品牌名称：\{safe_brand}\n主关键词：\{safe_keyword}\n目标受众：\{safe_audience}\n指定标题：\{requested_title}\n来源事实：\n\{fact_lines}\n补充写作要求：\n\{note_lines}\n要求：\n1. 全文必须使用自然、完整、专业的简体中文，除品牌名、产品名、官网域名外，不要夹杂英文句子或英文小标题。\n2. 请写成真正可发布的品牌文章，不要写成提纲、摘要或提示词回应。\n3. 总体长度控制在 700 到 1100 个中文字符之间，确保篇幅明显长于普通摘要。\n4. 主关键词自然出现 3 到 5 次，避免生硬堆砌。\n5. 标题要像真实 SEO 标题，清晰具体，避免空泛。\n6. meta_description 控制在 90 到 140 个中文字符之间，可直接用于搜索摘要。\n7. intro 写 2 到 3 句，说明问题、受众和价值。\n8. 三个 section 的标题都要具体，不能重复，正文每节至少 2 到 3 句，内容要完整展开。\n9. 如果补充要求里明确要求某种写作角度、人称视角或结构，必须在引言和至少一个小节里体现。\n10. 不要臆造消费者调研、市场份额、使用习惯、口碑评价或功能细节，除非来源事实明确写出。\n11. 除非标题、来源事实或补充要求明确提到 SEO、搜索流量、搜索引擎、关键词、内容审计，否则不要在正文里讨论 SEO、搜索意图、SEO 内容审计、写作流程或内容工作流。\n12. section_one_body 和 section_two_body 不要自己写 [1][2][3] 这种引用标记。\n13. 不要使用 best、guaranteed、perfect、#1、最强、第一、保证、绝对、顶级 这类高风险表述。\n14. 语气要可信、克制，像真实品牌官网内容，不要像 AI 套话。\n15. 仅返回 JSON，字段必须严格为：title, meta_description, intro, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body。"
  } else {
    "Write copy for a brand or product page and return raw JSON only, with no markdown fences.\n\nBrand name: \{safe_brand}\nPrimary keyword: \{safe_keyword}\nAudience: \{safe_audience}\nRequested title: \{requested_title}\nSource facts:\n\{fact_lines}\nAdditional writing instructions:\n\{note_lines}\nRequirements:\n1. Default to polished, publishable English prose.\n2. If the source notes explicitly request another output language, honor that request and write the whole draft consistently in that language.\n3. The article subject is the requested topic/title, not SEO, search intent, keyword strategy, audits, or the writing workflow. Do not mention SEO, search engines, content audits, search intent, keyword usage, or the drafting tool unless the title, source facts, or additional instructions explicitly ask for those topics.\n4. Keep the full draft around 650 to 900 words.\n5. Use the provided source facts as the center of the article, not generic category commentary.\n6. If the additional instructions request a specific angle or perspective, reflect that framing clearly in the intro and at least one section heading.\n7. Do not invent consumer sentiment, survey data, market trends, user behavior patterns, or feature details unless they are directly supported by the source notes.\n8. Use at least two concrete source facts directly in the prose when the sources provide them.\n9. Use the primary keyword naturally 3 to 5 times.\n10. Make the title specific, search-friendly, and free of risky claims like best, guaranteed, perfect, #1, unbeatable, or world-class unless those exact words were explicitly required by the user.\n11. Keep meta_description around 130 to 155 characters.\n12. Write an intro of 2 to 3 sentences.\n13. Each section heading must be concrete and distinct, and each section body should fully develop the point in 3 to 5 sentences.\n14. Do not include citation markers like [1], [2], or [3] in section_one_body or section_two_body.\n15. Keep the tone credible, restrained, and suitable for a real brand page.\n16. Return JSON only, with exactly these keys: title, meta_description, intro, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body."
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
  if is_chinese_ui(lang) {
    "\{title_case(keyword)} 实用指南"
  } else {
    "\{title_case(keyword)}: A Practical Guide for \{audience}"
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
  intro : String,
) -> String {
  let normalized = normalize_or_default(
    candidate,
    meta_description(title, intro),
  )
  let clipped = excerpt(normalized, 155)
  if clipped.length() < 110 {
    meta_description(title, intro)
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
    return title
  }
  "\{brand_name} guide"
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
  intro : String,
  section_one_heading : String,
  section_one_body : String,
  section_two_heading : String,
  section_two_body : String,
  section_three_heading : String,
  section_three_body : String,
  facts : Array[String],
  lang : String,
) -> String {
  let (section_one_a, section_one_b) = split_claim_pair(section_one_body)
  let (section_two_a, section_two_b) = split_claim_pair(section_two_body)
  let (section_three_a, section_three_b) = split_claim_pair(section_three_body)
  let builder = StringBuilder::new()
  builder.write_string("<article class=\"article-card\">")
  builder.write_string(
    "<h1 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(title))
  builder.write_string("</h1>")
  builder.write_string(claim_paragraph_html("C1", intro, "", true))
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_one_heading))
  builder.write_string("</h2>")
  builder.write_string(
    claim_paragraph_html(
      "C2",
      section_one_a,
      evidence_html_for_claim(facts, 0, lang),
      false,
    ),
  )
  builder.write_string(
    claim_paragraph_html(
      "C3",
      section_one_b,
      evidence_html_for_claim(facts, 1, lang),
      false,
    ),
  )
  builder.write_string("</section>")
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_two_heading))
  builder.write_string("</h2>")
  builder.write_string(
    claim_paragraph_html(
      "C4",
      section_two_a,
      evidence_html_for_claim(facts, 2, lang),
      false,
    ),
  )
  builder.write_string(
    claim_paragraph_html(
      "C5",
      section_two_b,
      evidence_html_for_claim(facts, 3, lang),
      false,
    ),
  )
  builder.write_string("</section>")
  builder.write_string(
    "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(section_three_heading))
  builder.write_string("</h2>")
  builder.write_string(
    claim_paragraph_html(
      "C6",
      section_three_a,
      evidence_html_for_claim(facts, 4, lang),
      false,
    ),
  )
  builder.write_string(
    claim_paragraph_html(
      "C7",
      section_three_b,
      evidence_html_for_claim(facts, 5, lang),
      false,
    ),
  )
  builder.write_string("</section>")
  builder.write_string("</article>")
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
) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<p id=\"claim-")
  builder.write_string(claim_id)
  builder.write_string("\" class=\"")
  builder.write_string(if is_lede { "lede claim-block" } else { "claim-block" })
  builder.write_string("\" data-claim-id=\"")
  builder.write_string(claim_id)
  builder.write_string(
    "\"><span class=\"claim-copy editable-field\" contenteditable=\"true\" spellcheck=\"false\">",
  )
  builder.write_string(escape_html(text))
  builder.write_string("</span>")
  if evidence_html.trim().to_string() != "" {
    builder.write_string("<span class=\"claim-inline-evidence\"> ")
    builder.write_string(evidence_html)
    builder.write_string("</span>")
  }
  builder.write_string("</p>")
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
    "body{margin:0;font-family:Georgia,'Times New Roman',serif;background:#f6f0e8;color:#1e1d1a;}main{max-width:1120px;margin:0 auto;padding:48px 24px 72px;}h1,h2,h3{font-family:'Avenir Next','Helvetica Neue',sans-serif;} .layout{display:grid;grid-template-columns:1fr;gap:24px;align-items:start;} .article-card{padding:0;background:transparent;border:0;border-radius:0;} .article-card h1{margin:0 0 12px;} .article-card p{margin:0;line-height:1.62;} section+section{margin-top:20px;} .evidence-ref{display:inline-flex;align-items:center;justify-content:center;min-width:24px;height:24px;margin-left:4px;border:0;border-radius:999px;background:rgba(155,92,29,.12);color:#9b5c1d;font-size:12px;font-weight:700;vertical-align:middle;} @media (max-width:900px){.layout{grid-template-columns:1fr;}}",
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
      passed: word_count >= 260 && word_count <= 980,
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
        "主关键词在草稿中共出现 \{keyword_occurrences} 次。"
      } else {
        "Primary keyword appears \{keyword_occurrences} times across the draft."
      },
    },
    {
      title: if chinese {
        "标题结构"
      } else {
        "Heading structure"
      },
      passed: count_occurrences(draft.article_html, "<h2>") >= 3,
      detail: if chinese {
        "页面包含 3 个便于扫描阅读的 H2 小节。"
      } else {
        "The page includes three scannable H2 sections."
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
  for source_id in source_ids {
    let source_note = lookup_source_note(source_notes, source_id)
    let preview = compact_source_excerpt(source_note)
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
        "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">当前校对证据</p><h4 id=\"evidenceCoverageTitle\">等待选择</h4><p id=\"evidenceCoverageBody\">点击正文中的证据编号后，这里会展开对应来源内容。</p>"
      } else {
        "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">Current evidence</p><h4 id=\"evidenceCoverageTitle\">Waiting for selection</h4><p id=\"evidenceCoverageBody\">Click an inline evidence marker in the draft to inspect the matching source note here.</p>"
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
