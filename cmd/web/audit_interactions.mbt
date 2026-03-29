///|
fn split_event_payload(payload : String, separator : String) -> Array[String] {
  let parts = []
  for part in payload.split(separator) {
    parts.push(part.to_string())
  }
  parts
}

///|
fn handle_summary_button(target_id : String) -> Unit {
  if target_id.trim().to_string() != "" {
    open_details_and_scroll(target_id)
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
    open_details_and_scroll("factAuditSection")
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
  handle_claim_selection(claim_id)
}

///|
fn handle_evidence_selection(payload : String) -> Unit {
  let parts = split_event_payload(payload, "\u001F")
  if parts.length() < 5 {
    return
  }
  let claim_id = parts[0].trim().to_string()
  let source_id = parts[1].trim().to_string()
  let title = parts[2].trim().to_string()
  let body = parts[3].trim().to_string()
  let source = parts[4].trim().to_string()
  set_text("evidenceCoverageSource", source)
  set_text("evidenceCoverageTitle", title)
  set_text("evidenceCoverageBody", body)
  show_evidence_detail_dom("previewPanel", "evidenceCoverageCard")
  activate_evidence_ref_dom("previewPanel", source_id)
  activate_claim_block_dom("previewPanel", claim_id)
  open_details_and_scroll("seoRuleSection")
}
