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
fn read_inputs() -> (String, String, String, String) {
  (
    get_input_value("brandName"),
    get_input_value("primaryKeyword"),
    get_input_value("audience"),
    get_input_value("factsInput"),
  )
}

///|
fn refresh_preview() -> Unit {
  let (brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, report) = @moonseo.generate_demo(
    brand_name, primary_keyword, audience, facts_raw,
  )
  set_html("scorePanel", report.summary_html)
  set_html("auditPanel", report.findings_html)
  set_html("previewPanel", draft.preview_html)
  set_text("exportHint", "Export file: \{@moonseo.export_filename(draft)}")
}

///|
fn export_current() -> Unit {
  let (brand_name, primary_keyword, audience, facts_raw) = read_inputs()
  let (draft, _) = @moonseo.generate_demo(
    brand_name, primary_keyword, audience, facts_raw,
  )
  download_file(@moonseo.export_filename(draft), draft.export_html)
}

///|
fn main {
  refresh_preview()
  add_click_listener("generateButton", () => refresh_preview())
  add_click_listener("exportButton", () => export_current())
  add_input_listener("brandName", () => refresh_preview())
  add_input_listener("primaryKeyword", () => refresh_preview())
  add_input_listener("audience", () => refresh_preview())
  add_input_listener("factsInput", () => refresh_preview())
}
