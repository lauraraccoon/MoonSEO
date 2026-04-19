///|
fn split_event_payload(payload : String, separator : String) -> Array[String] {
  let parts = []
  for part in payload.split(separator) {
    parts.push(part.to_string())
  }
  parts
}

///|
fn escape_html_fragment(text : String) -> String {
  text
  .replace_all(old="&", new="&amp;")
  .replace_all(old="<", new="&lt;")
  .replace_all(old=">", new="&gt;")
  .replace_all(old="\"", new="&quot;")
}

///|
fn handle_summary_button(target_id : String) -> Unit {
  if target_id.trim().to_string() != "" {
    toggle_audit_section_dom(target_id)
  }
}

///|
fn handle_claim_selection(claim_id : String) -> Unit {
  let normalized = claim_id.trim().to_string()
  if normalized == "" {
    return
  }
  let current_selected = get_data_attr("previewPanel", "selectedClaim")
  if current_selected == normalized {
    set_data_attr("previewPanel", "selectedClaim", "")
    clear_claim_selection("previewPanel", "auditPanel")
  } else {
    set_data_attr("previewPanel", "selectedClaim", normalized)
    clear_claim_selection("previewPanel", "auditPanel")
    select_claim_dom("previewPanel", "auditPanel", normalized)
    show_audit_section_dom("factAuditSection")
  }
}

///|
fn handle_claim_apply(payload : String) -> Unit {
  let parts = split_event_payload(payload, "\u001F")
  if parts.length() < 2 {
    return
  }
  let claim_id = parts[0].trim().to_string()
  let rewrite = parts[1].trim().to_string()
  if claim_id == "" || rewrite == "" {
    return
  }
  apply_claim_rewrite_dom("previewPanel", "auditPanel", claim_id, rewrite)
  sync_export_from_preview("previewPanel", "exportButton")
  cache_claim_snapshot_from_preview()
  cache_draft_edit_state("dirty")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  set_status_loading(
    if get_lang_state() == "zh" {
      "已应用改写建议，当前 claim 与 SEO 审计结果需要重新计算。"
    } else {
      "The rewrite was applied. Refresh the claim and SEO audits to review the updated draft."
    },
  )
  handle_claim_selection(claim_id)
}

///|
fn evidence_selection_title(source_id : String) -> String {
  let normalized = source_id.trim().to_string()
  let ui_lang = get_lang_state()
  if ui_lang == "zh" {
    "正文证据标记 [S\{normalized}]"
  } else {
    "Body evidence marker [S\{normalized}]"
  }
}

///|
fn evidence_selection_source_label() -> String {
  let ui_lang = get_lang_state()
  if ui_lang == "zh" {
    "用于标记正文对应的来源摘录"
  } else {
    "Marks the source excerpt used beside the body"
  }
}

///|
fn source_origin_label(kind : String, name : String) -> String {
  let ui_lang = get_lang_state()
  let trimmed_name = name.trim().to_string()
  if kind == "website" {
    if ui_lang == "zh" {
      "来自官网：\{trimmed_name}"
    } else {
      "From website: \{trimmed_name}"
    }
  } else if ui_lang == "zh" {
    "来自上传文件：\{trimmed_name}"
  } else {
    "From uploaded file: \{trimmed_name}"
  }
}

///|
fn parse_source_index(source_id : String) -> Int {
  let mut value = 0
  for scalar in source_id.trim().iter() {
    let code = scalar.to_int()
    if code >= 48 && code <= 57 {
      value = value * 10 + (code - 48)
    }
  }
  value
}

///|
fn compact_evidence_excerpt(text : String) -> String {
  let normalized = text
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
  if normalized.length() <= 220 {
    normalized
  } else {
    "\{normalized.sub(end=220).to_string()}..."
  }
}

///|
fn evidence_excerpt_segments(text : String) -> Array[String] {
  let normalized = text.replace_all(old="\r", new="\n")
  let lines = []
  for raw_line in normalized.split("\n") {
    let line = raw_line.trim().to_string()
    if line != "" {
      lines.push(line)
    }
  }
  if lines.length() > 1 {
    let trimmed = []
    let mut total = 0
    for line in lines {
      if total >= 280 || trimmed.length() >= 4 {
        break
      }
      let compact = compact_evidence_excerpt(line)
      if compact != "" {
        trimmed.push(compact)
        total += compact.length()
      }
    }
    return trimmed
  }
  let compact = compact_evidence_excerpt(text)
  if compact == "" {
    return []
  }
  let sentences = []
  let mut current = ""
  for scalar in compact.iter() {
    current = current + scalar.to_string()
    if scalar == '\n' ||
      scalar == '。' ||
      scalar == '！' ||
      scalar == '？' ||
      scalar == '；' ||
      scalar == '.' ||
      scalar == '!' ||
      scalar == '?' ||
      scalar == ';' {
      let sentence = current.trim().to_string()
      if sentence != "" {
        sentences.push(sentence)
      }
      current = ""
    }
  }
  if current.trim().to_string() != "" {
    sentences.push(current.trim().to_string())
  }
  if sentences.length() <= 2 {
    return [compact]
  }
  let grouped = []
  let mut index = 0
  while index < sentences.length() && grouped.length() < 3 {
    let first = sentences[index]
    let second = if index + 1 < sentences.length() {
      sentences[index + 1]
    } else {
      ""
    }
    let paragraph = if second == "" { first } else { "\{first} \{second}" }
    grouped.push(paragraph.trim().to_string())
    index += 2
  }
  grouped
}

///|
fn render_evidence_excerpt_html(text : String) -> String {
  let builder = StringBuilder::new()
  let segments = evidence_excerpt_segments(text)
  if segments.length() == 0 {
    return ""
  }
  for segment in segments {
    builder.write_string("<p>")
    builder.write_string(escape_html_fragment(segment))
    builder.write_string("</p>")
  }
  builder.to_string()
}

///|
fn evidence_selection_origin(source_id : String) -> String {
  let target = source_id.trim().to_string()
  let target_index = parse_source_index(target)
  let upload_payload = get_input_value("uploadSourceCache")
  let mut next_index = 1
  for record in upload_payload.split("\u001E") {
    let current = record.trim().to_string()
    if current == "" {
      continue
    }
    let fields = split_event_payload(current, "\u001F")
    if fields.length() < 3 {
      continue
    }
    let kind = fields[0].trim().to_string()
    let name = fields[1].trim().to_string()
    let content = fields[2].trim().to_string()
    if kind == "parsed" {
      let facts = @moonseo.parse_facts(content)
      if facts.length() > 0 {
        let start = next_index
        let end_ = next_index + facts.length() - 1
        if target_index >= start && target_index <= end_ {
          return source_origin_label("upload", name)
        }
        next_index = end_ + 1
      }
    }
  }
  let website_facts = @moonseo.parse_facts(get_input_value("websiteFacts"))
  if website_facts.length() > 0 {
    let start = next_index
    let end_ = next_index + website_facts.length() - 1
    let website_url = get_data_attr("websiteFacts", "sourceUrl")
      .trim()
      .to_string()
    if target_index >= start && target_index <= end_ && website_url != "" {
      return source_origin_label("website", website_url)
    }
  }
  evidence_selection_source_label()
}

///|
fn evidence_selection_excerpt(
  source_id : String,
  fallback_body : String,
) -> String {
  let combined_sources = combine_source_materials(
    get_input_value("sourceFacts"),
    get_input_value("websiteFacts"),
  )
  let source_notes = @moonseo.parse_facts(combined_sources)
  let target = source_id.trim().to_string()
  for index = 0; index < source_notes.length(); index = index + 1 {
    if "\{index + 1}" == target {
      let source_note = source_notes[index].trim().to_string()
      if source_note != "" {
        let preview = compact_evidence_excerpt(source_note)
        if preview.trim().to_string().length() >= 12 {
          return preview
        }
        break
      }
    }
  }
  let fallback = compact_evidence_excerpt(fallback_body)
  if fallback.trim().to_string().length() >= 12 {
    fallback
  } else {
    ""
  }
}

///|
fn handle_evidence_selection(payload : String) -> Unit {
  let parts = split_event_payload(payload, "\u001F")
  if parts.length() < 5 {
    return
  }
  let source_id = parts[1].trim().to_string()
  let body = evidence_selection_excerpt(source_id, parts[3].trim().to_string())
  let excerpt_html = render_evidence_excerpt_html(body)
  if excerpt_html == "" {
    set_text("evidenceCoverageSource", "")
    set_text("evidenceCoverageTitle", "")
    set_html("evidenceCoverageBody", "")
    hide_evidence_detail_dom("evidenceCoverageCard")
    activate_evidence_ref_dom("previewPanel", source_id)
    return
  }
  set_text("evidenceCoverageSource", evidence_selection_origin(source_id))
  set_text("evidenceCoverageTitle", evidence_selection_title(source_id))
  set_html("evidenceCoverageBody", excerpt_html)
  show_evidence_detail_dom("previewPanel", "evidenceCoverageCard")
  activate_evidence_ref_dom("previewPanel", source_id)
  activate_source_note_dom("auditPanel", source_id)
  show_audit_section_dom("seoRuleSection")
}
