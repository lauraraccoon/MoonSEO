///|
fn has_prefix(input : String, prefix : String) -> Bool {
  input.length() >= prefix.length() &&
  input.sub(end=prefix.length()).to_string() == prefix
}

///|
fn strip_prefix(input : String, prefix : String) -> String {
  if has_prefix(input, prefix) {
    input.sub(start=prefix.length()).to_string()
  } else {
    input
  }
}

///|
fn first_segment(input : String, separator : String) -> String {
  for part in input.split(separator) {
    return part.to_string()
  }
  ""
}

///|
fn normalize_hostname(raw_website : String) -> String {
  let trimmed = raw_website.trim().to_string()
  let without_scheme = strip_prefix(
    strip_prefix(strip_prefix(trimmed, "https://"), "http://"),
    "//",
  )
  let without_path = first_segment(without_scheme, "/")
  let without_query = first_segment(first_segment(without_path, "?"), "#")
  let without_port = first_segment(without_query, ":")
  strip_prefix(without_port, "www.")
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
fn infer_brand_name(direct_brand : String, raw_website : String) -> String {
  let direct = direct_brand.trim().to_string()
  if direct != "" {
    return direct
  }
  let first_label = first_segment(normalize_hostname(raw_website), ".")
    .trim()
    .to_string()
  if first_label == "" {
    return ""
  }
  let normalized = first_label
    .replace_all(old="-", new=" ")
    .replace_all(old="_", new=" ")
  let builder = StringBuilder::new()
  let mut first_word = true
  for part in normalized.split(" ") {
    let current = part.trim().to_string()
    if current == "" {
      continue
    }
    if !first_word {
      builder.write_string(" ")
    }
    builder.write_string(capitalize_ascii(current))
    first_word = false
  }
  builder.to_string()
}

///|
fn persist_input_value(key : String, value : String) -> Unit {
  set_persistent_value(key, value)
}

///|
fn reset_persistent_brief_inputs() -> Unit {
  clear_persistent_value("moonseo.brand_name")
  clear_persistent_value("moonseo.website_url")
  clear_persistent_value("moonseo.article_title")
  clear_persistent_value("moonseo.primary_keyword")
  clear_persistent_value("moonseo.notes_input")
}

///|
fn current_page_mode() -> String {
  let mode = get_data_attr("previewPanel", "pageMode").trim().to_string()
  if mode == "" {
    "idle"
  } else {
    mode
  }
}

///|
fn set_page_mode(mode : String) -> Unit {
  set_data_attr("previewPanel", "pageMode", mode)
}

///|
fn is_page_mode(mode : String) -> Bool {
  current_page_mode() == mode
}

///|
fn close_menu(id : String) -> Unit {
  close_details(id)
}

///|
fn open_menu(id : String) -> Unit {
  open_details(id)
}

///|
fn toggle_menu(id : String) -> Unit {
  if is_details_open(id) {
    close_menu(id)
  } else {
    open_menu(id)
  }
}

///|
fn toggle_mutually_exclusive_menu(
  current_id : String,
  other_id : String,
) -> Unit {
  let should_open = !is_details_open(current_id)
  close_menu(other_id)
  if should_open {
    open_menu(current_id)
  } else {
    close_menu(current_id)
  }
}

///|
fn close_all_floating_menus() -> Unit {
  close_menu("uploadMenu")
  close_menu("briefDrawer")
  close_menu("settingsMenu")
}

///|
fn sync_export_from_preview(preview_id : String, export_id : String) -> Unit {
  let article_html = snapshot_export_article_html(preview_id).trim().to_string()
  if article_html == "" {
    return
  }
  let title = get_data_attr(export_id, "exportTitle")
  let meta_description = get_data_attr(export_id, "exportMeta")
  let slug = get_data_attr(export_id, "exportSlug")
  let lang = get_data_attr(export_id, "exportLang")
  set_cached_export_content(
    export_id,
    @moonseo.render_export_html_document(
      title, meta_description, article_html, slug, lang,
    ),
  )
}

///|
fn handle_upload_menu_toggle() -> Unit {
  toggle_mutually_exclusive_menu("uploadMenu", "briefDrawer")
}

///|
fn handle_brief_menu_toggle() -> Unit {
  toggle_mutually_exclusive_menu("briefDrawer", "uploadMenu")
}

///|
fn handle_settings_menu_toggle() -> Unit {
  toggle_menu("settingsMenu")
}
