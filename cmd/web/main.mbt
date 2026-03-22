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
fn read_inputs() -> (String, String, String, String) {
  (
    get_input_value("brandName"),
    get_input_value("primaryKeyword"),
    get_input_value("audience"),
    get_input_value("factsInput"),
  )
}

///|
fn render_content() -> Unit {
  let lang = get_lang_state()
  let (brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, report) = @moonseo.generate_demo_localized(
    brand_name, primary_keyword, audience, facts_raw, lang,
  )
  set_html("scorePanel", report.summary_html)
  set_html("auditPanel", report.findings_html)
  set_html("previewPanel", draft.preview_html)
  set_text(
    "exportHint",
    if lang == "zh" {
      "导出文件：\{@moonseo.export_filename(draft)}"
    } else {
      "Export file: \{@moonseo.export_filename(draft)}"
    },
  )
}

///|
fn export_current() -> Unit {
  let lang = get_lang_state()
  let (brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, _) = @moonseo.generate_demo_localized(
    brand_name, primary_keyword, audience, facts_raw, lang,
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
      "Brief 与约束设置"
    } else {
      "Brief And Constraints"
    },
  )
  set_text(
    "briefSummaryNote",
    if lang == "zh" {
      "展开 / 收起"
    } else {
      "Expand / Collapse"
    },
  )
  set_text(
    "briefIntro",
    if lang == "zh" {
      "填写品牌名、关键词、受众和已批准事实，页面会实时更新。"
    } else {
      "Fill in the brand, keyword, audience, and approved facts to update the page in real time."
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
    "audienceLabel",
    if lang == "zh" {
      "目标受众"
    } else {
      "Audience"
    },
  )
  set_text(
    "factsLabel",
    if lang == "zh" {
      "已批准事实"
    } else {
      "Approved Facts"
    },
  )
  set_text(
    "factsHint",
    if lang == "zh" {
      "建议一行一条，便于生成证据锚点。"
    } else {
      "Tip: one fact per line works best for the evidence anchors."
    },
  )
  set_text("generateButton", if lang == "zh" { "↑" } else { "↑" })
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
  add_click_listener("langZhButton", () => apply_language("zh"))
  add_click_listener("langEnButton", () => apply_language("en"))
  add_click_listener("generateButton", () => render_content())
  add_click_listener("exportButton", () => export_current())
  add_input_listener("brandName", () => render_content())
  add_input_listener("primaryKeyword", () => render_content())
  add_input_listener("audience", () => render_content())
  add_input_listener("factsInput", () => render_content())
}
