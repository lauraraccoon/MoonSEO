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
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = normalize_or_default(primary_keyword, "seo content audit")
  let safe_audience = normalize_or_default(audience, "content teams")
  let facts = parse_facts(facts_raw)
  let evidence = ensure_minimum_facts(facts, safe_brand, safe_keyword)
  let title = normalize_or_default(
    article_title,
    "\{safe_brand} \{title_case(safe_keyword)} for \{safe_audience}",
  )
  let slug = slugify(title)
  let first_fact = evidence[0]
  let second_fact = evidence[1]
  let third_fact = evidence[2]
  let intro = "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This prototype turns a short fact sheet into a draft that stays grounded in approved claims, keeps search intent visible, and prepares the page for static publishing."
  let section_one = "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays tied to a concrete brand proof point: \{first_fact} [1]."
  let section_two = "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes such as \{second_fact} [2] and \{third_fact} [3], which makes stakeholder review faster and reduces the risk of unsupported claims."
  let section_three = "Before export, the workflow still checks the basics that matter in SEO production: a readable slug, a balanced keyword footprint, a usable meta description, clear H2 sections, evidence coverage, and wording that avoids risky overclaiming. That combination makes the page easier to review, easier to trust, and easier to publish."
  let article_html = build_article_html(
    title,
    safe_keyword,
    safe_audience,
    intro,
    first_fact,
    second_fact,
    third_fact,
    section_three,
    lang,
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
    export_html: build_export_html(
      title, description, article_html, slug, lang,
    ),
    plain_text,
    keyword: safe_keyword,
    evidence_count: evidence.length(),
  }
  let report = audit_draft(draft, lang)
  (draft, report)
}

///|
pub fn export_filename(draft : Draft) -> String {
  "\{draft.slug}.html"
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
fn ensure_minimum_facts(
  facts : Array[String],
  brand_name : String,
  keyword : String,
) -> Array[String] {
  let ensured = facts.copy()
  if ensured.length() == 0 {
    ensured.push("\{brand_name} keeps messaging aligned with approved facts.")
  }
  if ensured.length() == 1 {
    ensured.push("\{brand_name} ships a lightweight \{keyword} workflow.")
  }
  if ensured.length() == 2 {
    ensured.push("\{brand_name} can export static HTML for fast publishing.")
  }
  ensured
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
fn build_article_html(
  title : String,
  keyword : String,
  audience : String,
  intro : String,
  first_fact : String,
  second_fact : String,
  third_fact : String,
  section_three : String,
  lang : String,
) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string("<article class=\"article-card\">")
  builder.write_string("<h1>")
  builder.write_string(escape_html(title))
  builder.write_string("</h1>")
  builder.write_string("<p class=\"lede\">")
  builder.write_string(escape_html(intro))
  builder.write_string("</p>")
  builder.write_string("<section><h2>")
  builder.write_string(
    if chinese {
      "搜索意图聚焦"
    } else {
      "Search intent focus"
    },
  )
  builder.write_string("</h2><p>")
  builder.write_string(escape_html(if chinese {
    "对 \{audience} 来说，\{keyword} 最有效的写法，是回答一个具体且实用的问题，而不是泛泛的 AI 文案。当前草稿把开场信息绑定到一条明确的品牌依据："
  } else {
    "For \{audience}, \{keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays tied to a concrete brand proof point:"
  }))
  builder.write_string(" ")
  builder.write_string(
    evidence_ref_html(1, first_fact, lang),
  )
  builder.write_string(".")
  builder.write_string("</p></section>")
  builder.write_string("<section><h2>")
  builder.write_string(
    if chinese {
      "有依据支撑的品牌表达"
    } else {
      "Evidence-backed brand claims"
    },
  )
  builder.write_string("</h2><p>")
  let leading = if chinese {
    "页面也会把证据保持在文案附近。审阅者可以追溯到这些已批准来源："
  } else {
    "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes such as"
  }
  builder.write_string(escape_html(leading))
  builder.write_string(" ")
  builder.write_string(
    evidence_ref_html(2, second_fact, lang),
  )
  builder.write_string(
    if chinese {
      " 和 "
    } else {
      " and "
    },
  )
  builder.write_string(
    evidence_ref_html(3, third_fact, lang),
  )
  builder.write_string(
    if chinese {
      "，这样可以加快审阅并降低无依据表述的风险。"
    } else {
      ", which makes stakeholder review faster and reduces the risk of unsupported claims."
    },
  )
  builder.write_string("</p></section>")
  builder.write_string("<section><h2>")
  builder.write_string(
    if chinese {
      "发布前 SEO 检查清单"
    } else {
      "Pre-publish SEO checklist"
    },
  )
  builder.write_string("</h2><p>")
  builder.write_string(escape_html(section_three))
  builder.write_string("</p></section>")
  builder.write_string("</article>")
  builder.to_string()
}

///|
fn evidence_ref_html(index : Int, evidence_text : String, lang : String) -> String {
  let chinese = is_chinese_ui(lang)
  let builder = StringBuilder::new()
  builder.write_string("<button class=\"evidence-ref\" type=\"button\" data-evidence-label=\"")
  builder.write_string(
    escape_html(
      if chinese {
        "证据 [\{index}]"
      } else {
        "Evidence [\{index}]"
      },
    ),
  )
  builder.write_string("\" data-evidence-text=\"")
  builder.write_string(escape_html(evidence_text))
  builder.write_string("\" data-evidence-source=\"")
  builder.write_string(
    escape_html(
      if chinese {
        "来源于已上传资料"
      } else {
        "Source note from uploaded materials"
      },
    ),
  )
  builder.write_string("\">[")
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
      passed: word_count >= 140 && word_count <= 340,
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
      render_single_finding(
        builder,
        finding,
        chinese,
        evidence_coverage_title,
      )
    }
  }
  for finding in findings {
    if finding.passed {
      render_single_finding(
        builder,
        finding,
        chinese,
        evidence_coverage_title,
      )
    }
  }
  builder.write_string("</div>")
  builder.to_string()
}

///|
fn render_single_finding(
  builder : StringBuilder,
  finding : AuditFinding,
  chinese : Bool,
  evidence_coverage_title : String
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
    builder.write_string("\" id=\"evidenceCoverageCard\"><div class=\"audit-top\"><strong>")
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
    builder.write_string("<div id=\"evidenceCoverageDetail\" class=\"audit-detail-panel\">")
    builder.write_string(
      if chinese {
        "<p class=\"detail-kicker\">当前校对证据</p><h4>等待选择</h4><p>点击正文中的证据编号后，这里会展开对应来源内容。</p>"
      } else {
        "<p class=\"detail-kicker\">Current evidence</p><h4>Waiting for selection</h4><p>Click an inline evidence marker in the draft to inspect the matching source note here.</p>"
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
