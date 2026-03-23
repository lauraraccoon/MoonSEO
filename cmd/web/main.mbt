///|
extern "js" fn get_input_value(id : String) -> String =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   return el && "value" in el ? el.value : "";
  #| }

///|
extern "js" fn set_html(id : String, html : String) -> Unit =
  #| function(id, html) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.innerHTML = html;
  #|   }
  #| }

///|
extern "js" fn set_text(id : String, text : String) -> Unit =
  #| function(id, text) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.textContent = text;
  #|   }
  #| }

///|
extern "js" fn bind_evidence_refs(preview_id : String, detail_id : String, card_id : String) -> Unit =
  #| function(previewId, detailId, cardId) {
  #|   const preview = document.getElementById(previewId);
  #|   const detail = document.getElementById(detailId);
  #|   const card = document.getElementById(cardId);
  #|   if (!preview || !detail || !card || preview.dataset.evidenceBound === "true") {
  #|     return;
  #|   }
  #|   preview.dataset.evidenceBound = "true";
  #|   preview.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".evidence-ref") : null;
  #|     if (!target || !detail) {
  #|       return;
  #|     }
  #|     const refs = preview.querySelectorAll(".evidence-ref");
  #|     refs.forEach((ref) => ref.classList.remove("active"));
  #|     target.classList.add("active");
  #|     const title = target.getAttribute("data-evidence-label") || "";
  #|     const body = target.getAttribute("data-evidence-text") || "";
  #|     const source = target.getAttribute("data-evidence-source") || "";
  #|     detail.innerHTML = `<p class="detail-kicker">${source}</p><h4>${title}</h4><p>${body}</p>`;
  #|     card.classList.add("expanded");
  #|     card.classList.remove("flash");
  #|     void card.offsetWidth;
  #|     card.classList.add("flash");
  #|   });
  #| }

///|
extern "js" fn set_attr(id : String, name : String, value : String) -> Unit =
  #| function(id, name, value) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.setAttribute(name, value);
  #|   }
  #| }

///|
extern "js" fn add_click_listener(id : String, cb : () -> Unit) -> Unit =
  #| function(id, cb) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.addEventListener("click", cb);
  #|   }
  #| }

///|
extern "js" fn add_input_listener(id : String, cb : () -> Unit) -> Unit =
  #| function(id, cb) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.addEventListener("input", cb);
  #|   }
  #| }

///|
extern "js" fn trigger_click(id : String) -> Unit =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.click();
  #|   }
  #| }

///|
extern "js" fn bind_details_group(first_id : String, second_id : String) -> Unit =
  #| function(firstId, secondId) {
  #|   const first = document.getElementById(firstId);
  #|   const second = document.getElementById(secondId);
  #|   if (!first || !second || first.dataset.groupBound === "true") {
  #|     return;
  #|   }
  #|   first.dataset.groupBound = "true";
  #|   second.dataset.groupBound = "true";
  #|   const closeOther = (current, other) => {
  #|     current.addEventListener("toggle", () => {
  #|       if (current.open) {
  #|         other.removeAttribute("open");
  #|       }
  #|     });
  #|   };
  #|   closeOther(first, second);
  #|   closeOther(second, first);
  #|   document.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Node ? event.target : null;
  #|     if (!target) return;
  #|     if (!first.contains(target)) {
  #|       first.removeAttribute("open");
  #|     }
  #|     if (!second.contains(target)) {
  #|       second.removeAttribute("open");
  #|     }
  #|   });
  #| }

///|
extern "js" fn bind_source_upload(
  input_id : String,
  target_id : String,
  list_id : String,
  cb : () -> Unit,
) -> Unit =
  #| function(inputId, targetId, listId, cb) {
  #|   const input = document.getElementById(inputId);
  #|   const target = document.getElementById(targetId);
  #|   const list = document.getElementById(listId);
  #|   if (!input || !target || !list) {
  #|     return;
  #|   }
  #|   const copy = {
  #|     zh: {
  #|       parsed: "已提取文本",
  #|       attached: "来源附件",
  #|       unsupported: "当前原型未直接解析此格式，答辩版可接入真实解析。",
  #|     },
  #|     en: {
  #|       parsed: "Text parsed",
  #|       attached: "Source attached",
  #|       unsupported: "This prototype does not parse this format yet.",
  #|     },
  #|   };
  #|   const currentLang = () => (document.body.dataset.lang === "en" ? "en" : "zh");
  #|   const renderFiles = async (files) => {
  #|     const lang = currentLang();
  #|     const ui = copy[lang];
  #|     if (!files.length) {
  #|       target.value = [
  #|         "Runs in the browser for faster review",
  #|         "Shows evidence anchors beside key claims",
  #|         "Exports static HTML for lightweight publishing",
  #|       ].join("\n");
  #|       list.innerHTML = "";
  #|       cb();
  #|       return;
  #|     }
  #|     const extracted = [];
  #|     list.innerHTML = "";
  #|     for (const file of files) {
  #|       const ext = (file.name.split(".").pop() || "").toLowerCase();
  #|       const chip = document.createElement("div");
  #|       chip.className = "source-chip";
  #|       const tag = document.createElement("strong");
  #|       const name = document.createElement("span");
  #|       name.textContent = file.name;
  #|       if (ext === "txt" || ext === "md") {
  #|         tag.textContent = ui.parsed;
  #|         try {
  #|           const text = await file.text();
  #|           extracted.push(text);
  #|         } catch (_error) {
  #|           extracted.push(file.name);
  #|         }
  #|       } else {
  #|         tag.textContent = ui.attached;
  #|         extracted.push(`${file.name} - ${ui.unsupported}`);
  #|       }
  #|       chip.appendChild(tag);
  #|       chip.appendChild(name);
  #|       list.appendChild(chip);
  #|     }
  #|     target.value = extracted.join("\n");
  #|     cb();
  #|   };
  #|   input.addEventListener("change", async () => {
  #|     await renderFiles(Array.from(input.files || []));
  #|   });
  #| }

///|
extern "js" fn download_file(filename : String, content : String) -> Unit =
  #| function(filename, content) {
  #|   const blob = new Blob([content], { type: "text/html;charset=utf-8" });
  #|   const url = URL.createObjectURL(blob);
  #|   const a = document.createElement("a");
  #|   a.href = url;
  #|   a.download = filename;
  #|   document.body.appendChild(a);
  #|   a.click();
  #|   a.remove();
  #|   URL.revokeObjectURL(url);
  #| }

///|
extern "js" fn set_lang_state(lang : String) -> Unit =
  #| function(lang) {
  #|   document.body.dataset.lang = lang;
  #|   const buttons = document.querySelectorAll("[data-lang-switch]");
  #|   buttons.forEach((button) => {
  #|     const active = button.getAttribute("data-lang-switch") === lang;
  #|     button.classList.toggle("active", active);
  #|   });
  #| }

///|
extern "js" fn get_lang_state() -> String =
  #| function() {
  #|   return document.body.dataset.lang || "zh";
  #| }

///|
fn combine_sources(uploaded_facts : String, notes : String, website_url : String) -> String {
  let parts = []
  let uploaded = uploaded_facts.trim().to_string()
  let note = notes.trim().to_string()
  let website = website_url.trim().to_string()
  if uploaded != "" {
    parts.push(uploaded)
  }
  if note != "" {
    parts.push(note)
  }
  if website != "" {
    parts.push("Primary website source: \{website}")
  }
  let builder = StringBuilder::new()
  for index = 0; index < parts.length(); index = index + 1 {
    if index > 0 {
      builder.write_string("\n")
    }
    builder.write_string(parts[index])
  }
  builder.to_string()
}

///|
fn read_inputs() -> (String, String, String, String, String) {
  let facts = combine_sources(
    get_input_value("sourceFacts"),
    get_input_value("notesInput"),
    get_input_value("websiteUrl"),
  )
  (
    get_input_value("articleTitle"),
    get_input_value("brandName"),
    get_input_value("primaryKeyword"),
    get_input_value("audience"),
    facts,
  )
}

///|
fn render_content() -> Unit {
  let lang = get_lang_state()
  let (article_title, brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, report) = @moonseo.generate_demo_localized(
    article_title, brand_name, primary_keyword, audience, facts_raw, lang,
  )
  set_html("scorePanel", report.summary_html)
  set_html("auditPanel", report.findings_html)
  set_html("previewPanel", draft.preview_html)
  bind_evidence_refs("previewPanel", "evidenceCoverageDetail", "evidenceCoverageCard")
}

///|
fn export_current() -> Unit {
  let lang = get_lang_state()
  let (article_title, brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, _) = @moonseo.generate_demo_localized(
    article_title, brand_name, primary_keyword, audience, facts_raw, lang,
  )
  download_file(@moonseo.export_filename(draft), draft.export_html)
}

///|
fn apply_language(lang : String) -> Unit {
  set_lang_state(lang)
  set_text(
    "exportButton",
    if lang == "zh" {
      "导出 HTML"
    } else {
      "Export HTML"
    },
  )
  set_text(
    "briefSummaryTitle",
    if lang == "zh" {
      "自定义"
    } else {
      "Custom"
    },
  )
  set_text(
    "articleTitleLabel",
    if lang == "zh" {
      "文章标题"
    } else {
      "Article Title"
    },
  )
  set_text(
    "brandLabel",
    if lang == "zh" {
      "品牌名称"
    } else {
      "Brand Name"
    },
  )
  set_text(
    "keywordLabel",
    if lang == "zh" {
      "主关键词"
    } else {
      "Primary Keyword"
    },
  )
  set_text(
    "websiteLabel",
    if lang == "zh" {
      "品牌官网"
    } else {
      "Brand Website"
    },
  )
  set_attr(
    "notesInput",
    "placeholder",
    if lang == "zh" {
      "补充你的要求，或说明这篇文章想强调什么"
    } else {
      "Add a note about what this draft should emphasize"
    },
  )
  set_text("uploadButton", "+")
  set_attr(
    "uploadButton",
    "aria-label",
    if lang == "zh" {
      "上传资料"
    } else {
      "Upload Sources"
    },
  )
  set_attr(
    "uploadButton",
    "title",
    if lang == "zh" {
      "上传资料"
    } else {
      "Upload Sources"
    },
  )
  set_text(
    "uploadPickerButton",
    if lang == "zh" {
      "选择文件"
    } else {
      "Choose Files"
    },
  )
  set_text(
    "uploadFormatsNote",
    if lang == "zh" {
      "支持 fact sheet、PDF、DOC、DOCX、TXT、MD"
    } else {
      "Supports fact sheets, PDF, DOC, DOCX, TXT, and MD"
    },
  )
  set_text("generateButton", "↑")
  set_attr(
    "generateButton",
    "aria-label",
    if lang == "zh" {
      "生成草稿"
    } else {
      "Generate Draft"
    },
  )
  set_attr(
    "generateButton",
    "title",
    if lang == "zh" {
      "生成草稿"
    } else {
      "Generate Draft"
    },
  )
  set_text(
    "auditScoreLabel",
    if lang == "zh" {
      "审计分"
    } else {
      "Audit Score"
    },
  )
  render_content()
}

///|
fn main {
  apply_language("zh")
  bind_details_group("uploadMenu", "briefDrawer")
  bind_source_upload("sourceUpload", "sourceFacts", "sourceList", () => render_content())
  add_click_listener("langZhButton", () => apply_language("zh"))
  add_click_listener("langEnButton", () => apply_language("en"))
  add_click_listener("uploadPickerButton", () => trigger_click("sourceUpload"))
  add_click_listener("generateButton", () => render_content())
  add_click_listener("exportButton", () => export_current())
  add_input_listener("articleTitle", () => render_content())
  add_input_listener("brandName", () => render_content())
  add_input_listener("primaryKeyword", () => render_content())
  add_input_listener("audience", () => render_content())
  add_input_listener("websiteUrl", () => render_content())
  add_input_listener("notesInput", () => render_content())
}
