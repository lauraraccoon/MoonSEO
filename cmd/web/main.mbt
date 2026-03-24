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
extern "js" fn set_disabled(id : String, disabled : Bool) -> Unit =
  #| function(id, disabled) {
  #|   const el = document.getElementById(id);
  #|   if (el && "disabled" in el) {
  #|     el.disabled = disabled;
  #|   }
  #| }

///|
extern "js" fn alert_message(message : String) -> Unit =
  #| function(message) {
  #|   window.alert(message);
  #| }

///|
extern "js" fn bind_persistent_input(id : String, key : String) -> Unit =
  #| function(id, key) {
  #|   const el = document.getElementById(id);
  #|   if (!el || !("value" in el)) {
  #|     return;
  #|   }
  #|   const saved = window.localStorage.getItem(key);
  #|   if (saved !== null) {
  #|     el.value = saved;
  #|   }
  #|   const save = () => window.localStorage.setItem(key, el.value);
  #|   el.addEventListener("input", save);
  #|   el.addEventListener("change", save);
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
extern "js" fn bind_composer_menus(
  first_id : String,
  first_trigger_id : String,
  second_id : String,
  second_trigger_id : String,
) -> Unit =
  #| function(firstId, firstTriggerId, secondId, secondTriggerId) {
  #|   const first = document.getElementById(firstId);
  #|   const firstTrigger = document.getElementById(firstTriggerId);
  #|   const second = document.getElementById(secondId);
  #|   const secondTrigger = document.getElementById(secondTriggerId);
  #|   if (!first || !firstTrigger || !second || !secondTrigger || first.dataset.groupBound === "true") {
  #|     return;
  #|   }
  #|   first.dataset.groupBound = "true";
  #|   second.dataset.groupBound = "true";
  #|   const close = (el) => el.removeAttribute("open");
  #|   const toggle = (current, other) => {
  #|     const open = current.hasAttribute("open");
  #|     close(other);
  #|     if (open) {
  #|       close(current);
  #|     } else {
  #|       current.setAttribute("open", "");
  #|     }
  #|   };
  #|   firstTrigger.addEventListener("click", (event) => {
  #|     event.preventDefault();
  #|     event.stopPropagation();
  #|     toggle(first, second);
  #|   });
  #|   secondTrigger.addEventListener("click", (event) => {
  #|     event.preventDefault();
  #|     event.stopPropagation();
  #|     toggle(second, first);
  #|   });
  #|   first.addEventListener("click", (event) => event.stopPropagation());
  #|   second.addEventListener("click", (event) => event.stopPropagation());
  #|   document.addEventListener("click", () => {
  #|     close(first);
  #|     close(second);
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
extern "js" fn request_ai_draft(
  prompt : String,
  on_success : (String) -> Unit,
  on_error : (String) -> Unit,
) -> Unit =
  #| async function(prompt, onSuccess, onError) {
  #|   try {
  #|     const response = await fetch("/api/draft", {
  #|       method: "POST",
  #|       headers: {
  #|         "Content-Type": "application/json",
  #|       },
  #|       body: JSON.stringify({ prompt }),
  #|     });
  #|     const data = await response.json();
  #|     if (!response.ok) {
  #|       const message = data && data.error && data.error.message ? data.error.message : `Request failed with status ${response.status}`;
  #|       onError(message);
  #|       return;
  #|     }
  #|     const choice = data && data.choices && data.choices[0];
  #|     const message = choice && choice.message ? choice.message.content : "";
  #|     const text = Array.isArray(message)
  #|       ? message.map((part) => part && part.text ? part.text : "").join("")
  #|       : String(message || "");
  #|     const cleaned = text
  #|       .trim()
  #|       .replace(/^```json\s*/i, "")
  #|       .replace(/^```\s*/i, "")
  #|       .replace(/\s*```$/, "")
  #|       .trim();
  #|     const parsed = JSON.parse(cleaned);
  #|     const payload = [
  #|       parsed.title || "",
  #|       parsed.meta_description || "",
  #|       parsed.intro || "",
  #|       parsed.section_one_heading || "",
  #|       parsed.section_one_body || "",
  #|       parsed.section_two_heading || "",
  #|       parsed.section_two_body || "",
  #|       parsed.section_three_heading || "",
  #|       parsed.section_three_body || "",
  #|     ].join("\u001F");
  #|     onSuccess(payload);
  #|   } catch (error) {
  #|     onError(error instanceof Error ? error.message : "Unknown request error");
  #|   }
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
fn render_template_content() -> Unit {
  let lang = get_lang_state()
  let (article_title, brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, report) = @moonseo.generate_demo_localized(
    article_title, brand_name, primary_keyword, audience, facts_raw, lang,
  )
  apply_rendered(draft, report)
}

///|
fn render_ai_content(payload : String) -> Unit {
  let lang = get_lang_state()
  let (article_title, brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, report) = @moonseo.generate_ai_demo_localized(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    facts_raw,
    payload,
    lang,
  )
  apply_rendered(draft, report)
}

///|
fn apply_rendered(draft : @moonseo.Draft, report : @moonseo.AuditReport) -> Unit {
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
fn trigger_generation() -> Unit {
  let lang = get_lang_state()
  let (article_title, brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let prompt = @moonseo.build_ai_prompt(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    facts_raw,
    lang,
  )
  set_disabled("generateButton", true)
  set_text("generateButton", "…")
  request_ai_draft(
    prompt,
    (payload) => {
      render_ai_content(payload)
      restore_generate_button()
    },
    (message) => {
      alert_message(
        if lang == "zh" {
          "AI 生成失败：\{message}"
        } else {
          "AI generation failed: \{message}"
        },
      )
      render_template_content()
      restore_generate_button()
    },
  )
}

///|
fn restore_generate_button() -> Unit {
  let lang = get_lang_state()
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
  set_disabled("generateButton", false)
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
  set_text(
    "settingsLanguageLabel",
    if lang == "zh" {
      "语言"
    } else {
      "Language"
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
  restore_generate_button()
  render_template_content()
}

///|
fn main {
  apply_language("zh")
  bind_composer_menus("uploadMenu", "uploadButton", "briefDrawer", "briefSummaryTitle")
  bind_source_upload(
    "sourceUpload",
    "sourceFacts",
    "sourceList",
    () => render_template_content(),
  )
  add_click_listener("langZhButton", () => apply_language("zh"))
  add_click_listener("langEnButton", () => apply_language("en"))
  add_click_listener("uploadPickerButton", () => trigger_click("sourceUpload"))
  add_click_listener("generateButton", () => trigger_generation())
  add_click_listener("exportButton", () => export_current())
  add_input_listener("articleTitle", () => render_template_content())
  add_input_listener("brandName", () => render_template_content())
  add_input_listener("primaryKeyword", () => render_template_content())
  add_input_listener("audience", () => render_template_content())
  add_input_listener("websiteUrl", () => render_template_content())
  add_input_listener("notesInput", () => render_template_content())
}
