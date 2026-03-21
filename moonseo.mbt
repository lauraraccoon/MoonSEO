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
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
) -> (Draft, AuditReport) {
  let safe_brand = normalize_or_default(brand_name, "MoonSEO")
  let safe_keyword = normalize_or_default(primary_keyword, "seo content audit")
  let safe_audience = normalize_or_default(audience, "content teams")
  let facts = parse_facts(facts_raw)
  let evidence = ensure_minimum_facts(facts, safe_brand, safe_keyword)
  let title = "\{safe_brand} \{title_case(safe_keyword)} for \{safe_audience}"
  let slug = slugify(title)
  let first_fact = evidence[0]
  let second_fact = evidence[1]
  let third_fact = evidence[2]
  let intro = "\{safe_brand} needs a \{safe_keyword} page that feels specific, credible, and easy to scan. This prototype turns a short fact sheet into a draft that stays grounded in approved claims, keeps search intent visible, and prepares the page for static publishing."
  let section_one = "For \{safe_audience}, \{safe_keyword} works best when the page answers a narrow, practical question instead of sounding like generic AI copy. In this draft, the opening message stays tied to a concrete brand proof point: \{first_fact} [1]."
  let section_two = "The page also keeps evidence close to the copy. Reviewers can trace the messaging back to approved notes such as \{second_fact} [2] and \{third_fact} [3], which makes stakeholder review faster and reduces the risk of unsupported claims."
  let section_three = "Before export, the workflow still checks the basics that matter in SEO production: a readable slug, a balanced keyword footprint, a usable meta description, clear H2 sections, evidence coverage, and wording that avoids risky overclaiming. That combination makes the page easier to review, easier to trust, and easier to publish."
  let article_html = build_article_html(
    title, safe_keyword, safe_audience, intro, section_one, section_two, section_three,
  )
  let evidence_html = build_evidence_html(evidence)
  let description = meta_description(title, intro)
  let preview_html = build_preview_html(
    title, description, article_html, evidence_html,
  )
  let plain_text = "\{title} \{intro} \{section_one} \{section_two} \{section_three}"
  let draft : Draft = {
    title,
    slug,
    meta_description: description,
    article_html,
    evidence_html,
    preview_html,
    export_html: build_export_html(
      title, description, article_html, evidence_html, slug,
    ),
    plain_text,
    keyword: safe_keyword,
    evidence_count: evidence.length(),
  }
  let report = audit_draft(draft)
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
  section_one : String,
  section_two : String,
  section_three : String,
) -> String {
  let escaped_title = escape_html(title)
  let escaped_keyword = escape_html(keyword)
  let escaped_audience = escape_html(audience)
  let escaped_intro = escape_html(intro)
  let escaped_section_one = escape_html(section_one)
  let escaped_section_two = escape_html(section_two)
  let escaped_section_three = escape_html(section_three)
  let builder = StringBuilder::new()
  builder.write_string("<article class=\"article-card\">")
  builder.write_string("<p class=\"eyebrow\">MoonBit-generated SEO draft</p>")
  builder.write_string("<h1>")
  builder.write_string(escaped_title)
  builder.write_string("</h1>")
  builder.write_string("<p class=\"lede\">")
  builder.write_string(escaped_intro)
  builder.write_string("</p>")
  builder.write_string("<div class=\"meta-row\"><span>Primary keyword: ")
  builder.write_string(escaped_keyword)
  builder.write_string("</span><span>Audience: ")
  builder.write_string(escaped_audience)
  builder.write_string("</span></div>")
  builder.write_string("<section><h2>Search intent focus</h2><p>")
  builder.write_string(escaped_section_one)
  builder.write_string("</p></section>")
  builder.write_string("<section><h2>Evidence-backed brand claims</h2><p>")
  builder.write_string(escaped_section_two)
  builder.write_string("</p></section>")
  builder.write_string("<section><h2>Pre-publish SEO checklist</h2><p>")
  builder.write_string(escaped_section_three)
  builder.write_string("</p></section>")
  builder.write_string("</article>")
  builder.to_string()
}

///|
fn build_evidence_html(evidence : Array[String]) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<aside class=\"evidence-card\"><h3>Evidence anchors</h3><p class=\"evidence-note\">Each key claim can point back to an approved source note.</p><ol>",
  )
  for i in 0..<evidence.length() {
    builder.write_string("<li><span class=\"evidence-id\">[")
    builder.write_string("\{i + 1}")
    builder.write_string("]</span> ")
    builder.write_string(escape_html(evidence[i]))
    builder.write_string("</li>")
  }
  builder.write_string("</ol></aside>")
  builder.to_string()
}

///|
fn build_preview_html(
  title : String,
  meta_description : String,
  article_html : String,
  evidence_html : String,
) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"preview-shell\">")
  builder.write_string(
    "<div class=\"preview-meta\"><strong>SEO title:</strong> ",
  )
  builder.write_string(escape_html(title))
  builder.write_string("<br /><strong>Meta description:</strong> ")
  builder.write_string(escape_html(meta_description))
  builder.write_string("</div>")
  builder.write_string("<div class=\"preview-grid\">")
  builder.write_string(article_html)
  builder.write_string(evidence_html)
  builder.write_string("</div></div>")
  builder.to_string()
}

///|
fn build_export_html(
  title : String,
  meta_description : String,
  article_html : String,
  evidence_html : String,
  slug : String,
) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\" />",
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
    "body{margin:0;font-family:Georgia,'Times New Roman',serif;background:#f6f0e8;color:#1e1d1a;}main{max-width:1120px;margin:0 auto;padding:48px 24px 72px;}h1,h2,h3{font-family:'Avenir Next','Helvetica Neue',sans-serif;} .layout{display:grid;grid-template-columns:minmax(0,2fr) minmax(280px,1fr);gap:24px;align-items:start;} .article-card,.evidence-card{background:#fffdf9;border:1px solid #dfd4c5;border-radius:20px;box-shadow:0 18px 48px rgba(77,53,24,.08);} .article-card{padding:32px;} .evidence-card{padding:24px;position:sticky;top:20px;} .eyebrow{font-family:'Avenir Next','Helvetica Neue',sans-serif;letter-spacing:.18em;text-transform:uppercase;font-size:12px;color:#9b5c1d;} .lede{font-size:19px;line-height:1.7;} .meta-row{display:flex;flex-wrap:wrap;gap:12px;margin-bottom:20px;color:#6d604f;font-family:'Avenir Next','Helvetica Neue',sans-serif;} section+section{margin-top:20px;} li+li{margin-top:10px;} .evidence-id{font-weight:700;color:#9b5c1d;} @media (max-width:900px){.layout{grid-template-columns:1fr;}}",
  )
  builder.write_string("</style></head><body><main><div class=\"layout\">")
  builder.write_string(article_html)
  builder.write_string(evidence_html)
  builder.write_string("</div></main></body></html>")
  builder.to_string()
}

///|
fn audit_draft(draft : Draft) -> AuditReport {
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
      title: "Title length",
      passed: draft.title.length() >= 35 && draft.title.length() <= 70,
      detail: "The SEO title is \{draft.title.length()} characters long.",
    },
    {
      title: "Slug hygiene",
      passed: draft.slug.length() <= 60 && !draft.slug.contains("--"),
      detail: "Clean export slug: \{draft.slug}",
    },
    {
      title: "Meta description",
      passed: draft.meta_description.length() >= 110 &&
      draft.meta_description.length() <= 160,
      detail: "Meta description length: \{draft.meta_description.length()} characters.",
    },
    {
      title: "Body length",
      passed: word_count >= 140 && word_count <= 340,
      detail: "Draft length: \{word_count} words.",
    },
    {
      title: "Keyword footprint",
      passed: keyword_occurrences >= 2 &&
      keyword_occurrences <= 6 &&
      keyword_density <= 3,
      detail: "Primary keyword appears \{keyword_occurrences} times across the draft.",
    },
    {
      title: "Heading structure",
      passed: count_occurrences(draft.article_html, "<h2>") >= 3,
      detail: "The page includes three scannable H2 sections.",
    },
    {
      title: "Claim safety",
      passed: !contains_banned_claims(draft.plain_text),
      detail: claim_safety_detail(draft.plain_text),
    },
    {
      title: "Evidence coverage",
      passed: draft.evidence_count >= 3,
      detail: "The draft anchors \{draft.evidence_count} approved facts in the evidence sidebar.",
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
  let summary_text = "SEO readiness score: \{score}/100 (\{pass_count}/\{total_count} checks passed)"
  let summary_html = "<div class=\"score-card\"><span class=\"score-kicker\">MoonBit audit score</span><strong>\{score}/100</strong><p>\{pass_count} of \{total_count} deterministic checks passed.</p></div>"
  let findings_html = render_findings(findings)
  { score, pass_count, total_count, summary_text, summary_html, findings_html }
}

///|
fn render_findings(findings : Array[AuditFinding]) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"audit-list\">")
  for finding in findings {
    let tone = if finding.passed { "pass" } else { "warn" }
    let badge = if finding.passed { "Pass" } else { "Needs work" }
    builder.write_string("<article class=\"audit-item ")
    builder.write_string(tone)
    builder.write_string("\"><div class=\"audit-top\"><strong>")
    builder.write_string(escape_html(finding.title))
    builder.write_string("</strong><span>")
    builder.write_string(badge)
    builder.write_string("</span></div><p>")
    builder.write_string(escape_html(finding.detail))
    builder.write_string("</p></article>")
  }
  builder.write_string("</div>")
  builder.to_string()
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
fn claim_safety_detail(text : String) -> String {
  if contains_banned_claims(text) {
    "The draft includes a risky marketing superlative such as best, guaranteed, perfect, or #1."
  } else {
    "The current copy avoids risky marketing superlatives."
  }
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
