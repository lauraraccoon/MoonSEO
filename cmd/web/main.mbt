///|
/// DOM Read Bridges
extern "js" fn get_input_value(id : String) -> String =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   return el && "value" in el ? el.value : "";
  #| }

///|
/// DOM Write Bridges
extern "js" fn set_input_value(id : String, value : String) -> Unit =
  #| function(id, value) {
  #|   const el = document.getElementById(id);
  #|   if (el && "value" in el) {
  #|     el.value = value;
  #|   }
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
/// Preview Interaction Bridges
extern "js" fn bind_evidence_ref_events(
  preview_id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(previewId, cb) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview || preview.dataset.evidenceBound === "true") {
  #|     return;
  #|   }
  #|   preview.dataset.evidenceBound = "true";
  #|   preview.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".evidence-ref") : null;
  #|     if (!(target instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     const title = target.getAttribute("data-evidence-label") || "";
  #|     const body = target.getAttribute("data-evidence-text") || "";
  #|     const source = target.getAttribute("data-evidence-source") || "";
  #|     const sourceId = target.getAttribute("data-source-id") || "";
  #|     const claimBlock = target.closest(".claim-block");
  #|     const claimId = claimBlock instanceof HTMLElement ? claimBlock.dataset.claimId || "" : "";
  #|     cb(`${claimId}\u001F${sourceId}\u001F${title}\u001F${body}\u001F${source}`);
  #|   });
  #| }

///|
extern "js" fn render_evidence_detail_dom(
  preview_id : String,
  detail_id : String,
  card_id : String,
) -> Unit =
  #| function(previewId, detailId, cardId) {
  #|   void previewId;
  #|   void detailId;
  #|   void cardId;
  #| }

///|
extern "js" fn show_evidence_detail_dom(
  preview_id : String,
  card_id : String,
) -> Unit =
  #| function(previewId, cardId) {
  #|   const preview = document.getElementById(previewId);
  #|   const card = document.getElementById(cardId);
  #|   if (!preview || !card) {
  #|     return;
  #|   }
  #|   preview.querySelectorAll(".evidence-ref").forEach((ref) => ref.classList.remove("active"));
  #|   preview.querySelectorAll(".claim-block.is-active").forEach((node) => node.classList.remove("is-active"));
  #|   card.classList.add("expanded");
  #|   card.classList.remove("flash");
  #|   void card.offsetWidth;
  #|   card.classList.add("flash");
  #|   card.scrollIntoView({ behavior: "smooth", block: "center" });
  #| }

///|
extern "js" fn activate_evidence_ref_dom(
  preview_id : String,
  source_id : String,
) -> Unit =
  #| function(previewId, sourceId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview || !sourceId) {
  #|     return;
  #|   }
  #|   const ref = preview.querySelector(`.evidence-ref[data-source-id="${sourceId}"]`);
  #|   if (ref instanceof HTMLElement) {
  #|     ref.classList.add("active");
  #|   }
  #| }

///|
extern "js" fn activate_claim_block_dom(
  preview_id : String,
  claim_id : String,
) -> Unit =
  #| function(previewId, claimId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview || !claimId) {
  #|     return;
  #|   }
  #|   const claimBlock = preview.querySelector(`.claim-block[data-claim-id="${claimId}"]`);
  #|   if (claimBlock instanceof HTMLElement) {
  #|     claimBlock.classList.add("is-active");
  #|   }
  #| }

///|
extern "js" fn snapshot_export_article_html(preview_id : String) -> String =
  #| function(previewId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview) {
  #|     return "";
  #|   }
  #|   const article = preview.querySelector(".article-card");
  #|   if (!article) {
  #|     return "";
  #|   }
  #|   const articleClone = article.cloneNode(true);
  #|   articleClone.querySelectorAll("[contenteditable]").forEach((node) => node.removeAttribute("contenteditable"));
  #|   articleClone.querySelectorAll("[spellcheck]").forEach((node) => node.removeAttribute("spellcheck"));
  #|   articleClone.querySelectorAll(".editable-field").forEach((node) => node.classList.remove("editable-field"));
  #|   articleClone.querySelectorAll(".is-active").forEach((node) => node.classList.remove("is-active"));
  #|   articleClone.querySelectorAll(".evidence-ref.active").forEach((node) => node.classList.remove("active"));
  #|   return articleClone.outerHTML;
  #| }

///|
extern "js" fn snapshot_preview_plain_text(preview_id : String) -> String =
  #| function(previewId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview) {
  #|     return "";
  #|   }
  #|   const article = preview.querySelector(".article-card");
  #|   return article instanceof HTMLElement ? article.innerText || "" : "";
  #| }

///|
extern "js" fn snapshot_claim_payload(preview_id : String) -> String =
  #| function(previewId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview) {
  #|     return "";
  #|   }
  #|   const blocks = Array.from(preview.querySelectorAll(".claim-block[data-claim-id]"));
  #|   return blocks.map((block) => {
  #|     if (!(block instanceof HTMLElement)) {
  #|       return "";
  #|     }
  #|     const claimId = block.dataset.claimId || "";
  #|     const claimCopy = block.querySelector(".claim-copy");
  #|     const text = claimCopy instanceof HTMLElement ? (claimCopy.innerText || "").trim() : "";
  #|     return claimId && text ? `${claimId}\u001F${text}` : "";
  #|   }).filter(Boolean).join("\u001E");
  #| }

///|
extern "js" fn bind_preview_edit_events(
  preview_id : String,
  cb : () -> Unit,
) -> Unit =
  #| function(previewId, cb) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview || preview.dataset.editBound === "true") {
  #|     return;
  #|   }
  #|   preview.dataset.editBound = "true";
  #|   preview.addEventListener("input", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (target instanceof HTMLElement) {
  #|       cb();
  #|     }
  #|   });
  #|   preview.addEventListener("blur", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (target instanceof HTMLElement) {
  #|       cb();
  #|     }
  #|   }, true);
  #| }

///|
/// Audit Interaction Bridges
extern "js" fn bind_summary_button_events(
  scope_id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(scopeId, cb) {
  #|   const scope = document.getElementById(scopeId);
  #|   if (!scope || scope.dataset.summaryBound === "true") {
  #|     return;
  #|   }
  #|   scope.dataset.summaryBound = "true";
  #|   scope.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".audit-summary-button") : null;
  #|     if (target instanceof HTMLElement) {
  #|       cb(target.dataset.auditTarget || "");
  #|     }
  #|   });
  #| }

///|
extern "js" fn bind_claim_review_events(
  audit_id : String,
  on_select : (String) -> Unit,
  on_apply : (String) -> Unit,
) -> Unit =
  #| function(auditId, onSelect, onApply) {
  #|   const audit = document.getElementById(auditId);
  #|   if (!audit || audit.dataset.claimBound === "true") {
  #|     return;
  #|   }
  #|   audit.dataset.claimBound = "true";
  #|   audit.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target : null;
  #|     if (!target) {
  #|       return;
  #|     }
  #|     const applyButton = target.closest(".claim-apply");
  #|     if (applyButton instanceof HTMLElement) {
  #|       const claimId = applyButton.dataset.claimId || "";
  #|       const rewrite = applyButton.dataset.claimRewrite || "";
  #|       onApply(`${claimId}\u001F${rewrite}`);
  #|       return;
  #|     }
  #|     const link = target.closest(".claim-link");
  #|     if (link instanceof HTMLElement) {
  #|       onSelect(link.dataset.claimId || "");
  #|     }
  #|   });
  #| }

///|
extern "js" fn clear_claim_selection(
  preview_id : String,
  audit_id : String,
) -> Unit =
  #| function(previewId, auditId) {
  #|   const preview = document.getElementById(previewId);
  #|   const audit = document.getElementById(auditId);
  #|   if (preview) {
  #|     preview.querySelectorAll(".claim-block.is-active").forEach((node) => node.classList.remove("is-active"));
  #|   }
  #|   if (audit) {
  #|     audit.querySelectorAll(".claim-card.is-active").forEach((node) => node.classList.remove("is-active"));
  #|   }
  #| }

///|
extern "js" fn select_claim_dom(
  preview_id : String,
  audit_id : String,
  claim_id : String,
) -> Unit =
  #| function(previewId, auditId, claimId) {
  #|   const preview = document.getElementById(previewId);
  #|   const audit = document.getElementById(auditId);
  #|   if (!preview || !audit || !claimId) {
  #|     return;
  #|   }
  #|   const claimNode = preview.querySelector(`.claim-block[data-claim-id="${claimId}"]`);
  #|   const card = audit.querySelector(`.claim-card[data-claim-id="${claimId}"]`);
  #|   if (claimNode instanceof HTMLElement) {
  #|     claimNode.classList.add("is-active");
  #|     claimNode.scrollIntoView({ behavior: "smooth", block: "center" });
  #|   }
  #|   if (card instanceof HTMLElement) {
  #|     card.classList.add("is-active");
  #|   }
  #| }

///|
extern "js" fn open_details_and_scroll(id : String) -> Unit =
  #| function(id) {
  #|   const details = document.getElementById(id);
  #|   if (details instanceof HTMLDetailsElement) {
  #|     details.open = true;
  #|     details.scrollIntoView({ behavior: "smooth", block: "start" });
  #|   }
  #| }

///|
extern "js" fn apply_claim_rewrite_dom(
  preview_id : String,
  audit_id : String,
  claim_id : String,
  rewrite : String,
) -> Unit =
  #| function(previewId, auditId, claimId, rewrite) {
  #|   const preview = document.getElementById(previewId);
  #|   const audit = document.getElementById(auditId);
  #|   if (!preview || !audit || !claimId || !rewrite) {
  #|     return;
  #|   }
  #|   const claimNode = preview.querySelector(`.claim-block[data-claim-id="${claimId}"] .claim-copy`);
  #|   if (claimNode instanceof HTMLElement) {
  #|     claimNode.textContent = rewrite;
  #|   }
  #|   const card = audit.querySelector(`.claim-card[data-claim-id="${claimId}"]`);
  #|   const note = card && card.querySelector(".claim-apply-note");
  #|   if (note instanceof HTMLElement) {
  #|     note.hidden = false;
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
extern "js" fn set_disabled(id : String, disabled : Bool) -> Unit =
  #| function(id, disabled) {
  #|   const el = document.getElementById(id);
  #|   if (el && "disabled" in el) {
  #|     el.disabled = disabled;
  #|   }
  #| }

///|
extern "js" fn set_status_banner(
  id : String,
  tone : String,
  message : String,
  hidden : Bool,
) -> Unit =
  #| function(id, tone, message, hidden) {
  #|   const el = document.getElementById(id);
  #|   if (!el) {
  #|     return;
  #|   }
  #|   if (hidden) {
  #|     el.hidden = true;
  #|     el.textContent = "";
  #|     el.removeAttribute("data-tone");
  #|     return;
  #|   }
  #|   el.hidden = false;
  #|   el.textContent = message;
  #|   el.setAttribute("data-tone", tone);
  #| }

///|
/// Browser State Bridges
extern "js" fn get_persistent_value(key : String) -> String =
  #| function(key) {
  #|   const saved = window.localStorage.getItem(key);
  #|   return saved === null ? "" : String(saved);
  #| }

///|
extern "js" fn set_persistent_value(key : String, value : String) -> Unit =
  #| function(key, value) {
  #|   window.localStorage.setItem(key, value);
  #| }

///|
extern "js" fn clear_persistent_value(key : String) -> Unit =
  #| function(key) {
  #|   window.localStorage.removeItem(key);
  #| }

///|
extern "js" fn bind_persistent_input_events(
  id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(id, cb) {
  #|   const el = document.getElementById(id);
  #|   if (!el || !("value" in el) || el.dataset.persistBound === "true") {
  #|     return;
  #|   }
  #|   el.dataset.persistBound = "true";
  #|   const save = () => cb(String(el.value || ""));
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
extern "js" fn expose_generate_handler(cb : () -> Unit) -> Unit =
  #| function(cb) {
  #|   window.__moonseoGenerate = cb;
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
extern "js" fn bind_menu_trigger(trigger_id : String, cb : () -> Unit) -> Unit =
  #| function(triggerId, cb) {
  #|   const trigger = document.getElementById(triggerId);
  #|   if (!trigger || trigger.dataset.menuTriggerBound === "true") {
  #|     return;
  #|   }
  #|   trigger.dataset.menuTriggerBound = "true";
  #|   trigger.addEventListener("click", (event) => {
  #|     event.preventDefault();
  #|     event.stopPropagation();
  #|     cb();
  #|   });
  #| }

///|
extern "js" fn bind_click_stopper(id : String) -> Unit =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   if (!el || el.dataset.clickStopBound === "true") {
  #|     return;
  #|   }
  #|   el.dataset.clickStopBound = "true";
  #|   el.addEventListener("click", (event) => {
  #|     event.stopPropagation();
  #|   });
  #| }

///|
extern "js" fn bind_document_click(cb : () -> Unit) -> Unit =
  #| function(cb) {
  #|   if (document.body.dataset.docClickBound === "true") {
  #|     return;
  #|   }
  #|   document.body.dataset.docClickBound = "true";
  #|   document.addEventListener("click", () => {
  #|     cb();
  #|   });
  #| }

///|
extern "js" fn is_details_open(id : String) -> Bool =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   return !!(el && el.hasAttribute("open"));
  #| }

///|
extern "js" fn open_details(id : String) -> Unit =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.setAttribute("open", "");
  #|   }
  #| }

///|
extern "js" fn close_details(id : String) -> Unit =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.removeAttribute("open");
  #|   }
  #| }

///|
/// Source Input Bridges
extern "js" fn bind_source_upload_input(
  input_id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(inputId, cb) {
  #|   const input = document.getElementById(inputId);
  #|   if (!input || input.dataset.uploadBound === "true") {
  #|     return;
  #|   }
  #|   input.dataset.uploadBound = "true";
  #|   input.addEventListener("change", async () => {
  #|     const files = Array.from(input.files || []);
  #|     if (!files.length) {
  #|       cb("");
  #|       return;
  #|     }
  #|     const records = [];
  #|     const parseTxtLike = async (file) => {
  #|       try {
  #|         const text = await file.text();
  #|         return ["parsed", file.name, String(text || "")].join("\u001F");
  #|       } catch (error) {
  #|         return ["failed", file.name, error instanceof Error ? error.message : "Text parsing failed."].join("\u001F");
  #|       }
  #|     };
  #|     const parseDocx = async (file) => {
  #|       if (!window.mammoth || typeof window.mammoth.extractRawText !== "function") {
  #|         return ["failed", file.name, "DOCX parser is unavailable in this browser."].join("\u001F");
  #|       }
  #|       try {
  #|         const result = await window.mammoth.extractRawText({
  #|           arrayBuffer: await file.arrayBuffer(),
  #|         });
  #|         const text = String((result && result.value) || "").trim();
  #|         if (!text) {
  #|           return ["failed", file.name, "No usable DOCX text could be extracted."].join("\u001F");
  #|         }
  #|         return ["parsed", file.name, text].join("\u001F");
  #|       } catch (error) {
  #|         return ["failed", file.name, error instanceof Error ? error.message : "DOCX parsing failed."].join("\u001F");
  #|       }
  #|     };
  #|     const parsePdf = async (file) => {
  #|       if (!window.pdfjsLib || typeof window.pdfjsLib.getDocument !== "function") {
  #|         return ["failed", file.name, "PDF parser is unavailable in this browser."].join("\u001F");
  #|       }
  #|       try {
  #|         const bytes = new Uint8Array(await file.arrayBuffer());
  #|         const pdf = await window.pdfjsLib.getDocument({ data: bytes }).promise;
  #|         const pages = [];
  #|         for (let pageIndex = 1; pageIndex <= pdf.numPages; pageIndex += 1) {
  #|           const page = await pdf.getPage(pageIndex);
  #|           const content = await page.getTextContent();
  #|           const lines = (content.items || [])
  #|             .map((item) => (item && typeof item.str === "string" ? item.str : ""))
  #|             .filter(Boolean);
  #|           if (lines.length) {
  #|             pages.push(lines.join(" "));
  #|           }
  #|         }
  #|         const text = pages.join("\n").trim();
  #|         if (!text) {
  #|           return ["failed", file.name, "No usable PDF text could be extracted."].join("\u001F");
  #|         }
  #|         return ["parsed", file.name, text].join("\u001F");
  #|       } catch (error) {
  #|         return ["failed", file.name, error instanceof Error ? error.message : "PDF parsing failed."].join("\u001F");
  #|       }
  #|     };
  #|     for (const file of files) {
  #|       const ext = (file.name.split(".").pop() || "").toLowerCase();
  #|       if (ext === "txt" || ext === "md") {
  #|         records.push(await parseTxtLike(file));
  #|       } else if (ext === "docx") {
  #|         records.push(await parseDocx(file));
  #|       } else if (ext === "pdf") {
  #|         records.push(await parsePdf(file));
  #|       } else if (ext === "doc") {
  #|         records.push(["attached", file.name, "Legacy .doc files are uploaded but not parsed in the browser prototype yet."].join("\u001F"));
  #|       } else {
  #|         records.push(["attached", file.name, "This file type is attached but not parsed yet."].join("\u001F"));
  #|       }
  #|     }
  #|     input.value = "";
  #|     cb(records.join("\u001E"));
  #|   });
  #| }

///|
extern "js" fn render_upload_source_chips(
  list_id : String,
  payload : String,
) -> Unit =
  #| function(listId, payload) {
  #|   const list = document.getElementById(listId);
  #|   if (!list) {
  #|     return;
  #|   }
  #|   list.querySelectorAll('[data-source-kind="upload"]').forEach((node) => node.remove());
  #|   if (!payload) {
  #|     return;
  #|   }
  #|   let index = 0;
  #|   for (const record of String(payload).split("\u001E")) {
  #|     if (!record.trim()) continue;
  #|     const recordIndex = String(index++);
  #|     const [kind, label, name, detail] = record.split("\u001F");
  #|     const chip = document.createElement("div");
  #|     chip.className = "source-chip";
  #|     chip.dataset.sourceKind = "upload";
  #|     chip.dataset.uploadState = kind || "attached";
  #|     chip.dataset.recordIndex = recordIndex;
  #|     chip.innerHTML = "<strong></strong><span></span><button type=\"button\" class=\"source-chip-remove\" aria-label=\"Remove source\" title=\"Remove source\">×</button>";
  #|     const strong = chip.querySelector("strong");
  #|     const span = chip.querySelector("span");
  #|     if (strong) strong.textContent = label || "";
  #|     if (span) span.textContent = name || "";
  #|     if (detail) chip.title = detail;
  #|     list.appendChild(chip);
  #|   }
  #| }

///|
extern "js" fn bind_source_chip_remove_events(
  list_id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(listId, cb) {
  #|   const list = document.getElementById(listId);
  #|   if (!list || list.dataset.removeBound === "true") {
  #|     return;
  #|   }
  #|   list.dataset.removeBound = "true";
  #|   list.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".source-chip-remove") : null;
  #|     if (!(target instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     event.preventDefault();
  #|     event.stopPropagation();
  #|     const chip = target.closest(".source-chip[data-source-kind=\"upload\"]");
  #|     if (!(chip instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     cb(chip.dataset.recordIndex || "");
  #|   });
  #| }

///|
extern "js" fn bind_debounced_input_value(
  id : String,
  delay_ms : Int,
  cb : (String) -> Unit,
) -> Unit =
  #| function(id, delayMs, cb) {
  #|   const el = document.getElementById(id);
  #|   if (!el || !("value" in el) || el.dataset.debounceBound === "true") {
  #|     return;
  #|   }
  #|   el.dataset.debounceBound = "true";
  #|   let timer = 0;
  #|   const schedule = () => {
  #|     clearTimeout(timer);
  #|     timer = window.setTimeout(() => {
  #|       cb(String(el.value || "").trim());
  #|     }, Number(delayMs) || 0);
  #|   };
  #|   el.addEventListener("input", schedule);
  #|   el.addEventListener("change", schedule);
  #|   if (String(el.value || "").trim() !== "") {
  #|     schedule();
  #|   }
  #| }

///|
/// Network Bridges
extern "js" fn request_website_text(
  url : String,
  on_success : (String) -> Unit,
  on_error : (String) -> Unit,
) -> Unit =
  #| async function(url, onSuccess, onError) {
  #|   try {
  #|     const response = await fetch("/api/fetch-website", {
  #|       method: "POST",
  #|       headers: {
  #|         "Content-Type": "application/json",
  #|       },
  #|       body: JSON.stringify({ url }),
  #|     });
  #|     const data = await response.json();
  #|     if (!response.ok) {
  #|       const message =
  #|         data && typeof data.error === "string"
  #|           ? data.error
  #|           : `Request failed with status ${response.status}`;
  #|       onError(message);
  #|       return;
  #|     }
  #|     onSuccess(String((data && data.text) || "").trim());
  #|   } catch (error) {
  #|     onError(error instanceof Error ? error.message : "Unknown website fetch error");
  #|   }
  #| }

///|
extern "js" fn render_website_source_chip(
  list_id : String,
  label : String,
  text : String,
) -> Unit =
  #| function(listId, label, text) {
  #|   const list = document.getElementById(listId);
  #|   if (!list) {
  #|     return;
  #|   }
  #|   let chip = document.getElementById("website-source-chip");
  #|   if (!chip) {
  #|     chip = document.createElement("div");
  #|     chip.id = "website-source-chip";
  #|     chip.className = "source-chip";
  #|     chip.dataset.sourceKind = "website";
  #|     chip.innerHTML = "<strong></strong><span></span>";
  #|     list.appendChild(chip);
  #|   }
  #|   const strong = chip.querySelector("strong");
  #|   const span = chip.querySelector("span");
  #|   if (strong) strong.textContent = label;
  #|   if (span) span.textContent = text;
  #| }

///|
extern "js" fn clear_website_source_chip(list_id : String) -> Unit =
  #| function(_listId) {
  #|   const chip = document.getElementById("website-source-chip");
  #|   if (chip) {
  #|     chip.remove();
  #|   }
  #| }

///|
/// Element Dataset Bridges
extern "js" fn get_data_attr(id : String, name : String) -> String =
  #| function(id, name) {
  #|   const el = document.getElementById(id);
  #|   return el && el.dataset ? String(el.dataset[name] || "") : "";
  #| }

///|
extern "js" fn set_data_attr(
  id : String,
  name : String,
  value : String,
) -> Unit =
  #| function(id, name, value) {
  #|   const el = document.getElementById(id);
  #|   if (el && el.dataset) {
  #|     el.dataset[name] = value;
  #|   }
  #| }

///|
extern "js" fn request_ai_payload(
  endpoint : String,
  prompt : String,
  on_success : (String) -> Unit,
  on_error : (String) -> Unit,
) -> Unit =
  #| async function(endpoint, prompt, onSuccess, onError) {
  #|   try {
  #|     const response = await fetch(endpoint, {
  #|       method: "POST",
  #|       headers: {
  #|         "Content-Type": "application/json",
  #|       },
  #|       body: JSON.stringify({ prompt }),
  #|     });
  #|     const data = await response.json();
  #|     if (!response.ok) {
  #|       const message =
  #|         data && typeof data.error === "string"
  #|           ? data.error
  #|           : data && data.error && data.error.message
  #|             ? data.error.message
  #|             : `Request failed with status ${response.status}`;
  #|       onError(message);
  #|       return;
  #|     }
  #|     const payload = String((data && data.payload) || "").trim();
  #|     if (!payload) {
  #|       onError("The local draft service returned an empty payload.");
  #|       return;
  #|     }
  #|     onSuccess(payload);
  #|   } catch (error) {
  #|     onError(error instanceof Error ? error.message : "Unknown request error");
  #|   }
  #| }

///|
/// Export Bridges
extern "js" fn cache_export_file(
  id : String,
  filename : String,
  content : String,
  title : String,
  meta_description : String,
  slug : String,
  lang : String,
) -> Unit =
  #| function(id, filename, content, title, metaDescription, slug, lang) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.__moonseoExportFilename = filename;
  #|     el.__moonseoExportContent = content;
  #|     el.dataset.exportTitle = title;
  #|     el.dataset.exportMeta = metaDescription;
  #|     el.dataset.exportSlug = slug;
  #|     el.dataset.exportLang = lang;
  #|   }
  #| }

///|
extern "js" fn set_cached_export_content(id : String, content : String) -> Unit =
  #| function(id, content) {
  #|   const el = document.getElementById(id);
  #|   if (el) {
  #|     el.__moonseoExportContent = content;
  #|   }
  #| }

///|
extern "js" fn download_cached_file(id : String) -> Unit =
  #| function(id) {
  #|   const el = document.getElementById(id);
  #|   const filename =
  #|     el && typeof el.__moonseoExportFilename === "string"
  #|       ? el.__moonseoExportFilename
  #|       : "moonseo-draft.html";
  #|   const content =
  #|     el && typeof el.__moonseoExportContent === "string"
  #|       ? el.__moonseoExportContent
  #|       : "";
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
/// UI Language Bridges
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
  #|   return document.body.dataset.lang || "en";
  #| }

///|
fn content_lang() -> String {
  "en"
}

///|
fn set_status_loading(message : String) -> Unit {
  set_status_banner("statusBanner", "loading", message, false)
}

///|
fn set_status_success(message : String) -> Unit {
  set_status_banner("statusBanner", "success", message, false)
}

///|
fn set_status_error(message : String) -> Unit {
  set_status_banner("statusBanner", "error", message, false)
}

///|
fn website_chip_label(state : String, lang : String) -> String {
  let chinese = lang == "zh"
  if state == "loading" {
    if chinese {
      "抓取中"
    } else {
      "Fetching"
    }
  } else if state == "ready" {
    if chinese {
      "官网正文"
    } else {
      "Website copy"
    }
  } else if state == "empty" {
    if chinese {
      "官网来源"
    } else {
      "Website source"
    }
  } else if chinese {
    "抓取失败"
  } else {
    "Fetch failed"
  }
}

///|
fn upload_chip_label(kind : String, lang : String) -> String {
  let chinese = lang == "zh"
  if kind == "parsed" {
    if chinese {
      "已解析"
    } else {
      "Parsed"
    }
  } else if kind == "failed" {
    if chinese {
      "解析失败"
    } else {
      "Parse failed"
    }
  } else if chinese {
    "来源附件"
  } else {
    "Source attached"
  }
}

///|
fn set_website_source_state(
  state : String,
  source_url : String,
  text : String,
  chip_text : String,
) -> Unit {
  set_input_value("websiteFacts", text)
  set_data_attr("websiteFacts", "sourceState", state)
  set_data_attr("websiteFacts", "sourceUrl", source_url)
  if source_url == "" && state == "empty" {
    clear_website_source_chip("sourceList")
  } else {
    render_website_source_chip(
      "sourceList",
      website_chip_label(state, get_lang_state()),
      chip_text,
    )
  }
}

///|
fn handle_source_upload_payload(payload : String) -> Unit {
  let appended = payload.trim().to_string()
  if appended == "" {
    return
  }
  let existing = get_input_value("uploadSourceCache").trim().to_string()
  let next_payload = if existing == "" {
    appended
  } else {
    "\{existing}\u001E\{appended}"
  }
  set_input_value("uploadSourceCache", next_payload)
  apply_upload_source_payload(next_payload)
}

///|
fn apply_upload_source_payload(payload : String) -> Unit {
  let lang = get_lang_state()
  let source_parts = []
  let chip_parts = []
  for record in payload.split("\u001E") {
    let current = record.trim().to_string()
    if current == "" {
      continue
    }
    let fields = []
    for field in current.split("\u001F") {
      fields.push(field.to_string())
    }
    if fields.length() < 3 {
      continue
    }
    let kind = fields[0].trim().to_string()
    let name = fields[1].trim().to_string()
    let content = fields[2].trim().to_string()
    chip_parts.push(
      "\{kind}\u001F\{upload_chip_label(kind, lang)}\u001F\{name}\u001F\{content}",
    )
    if kind == "parsed" {
      source_parts.push(content)
    }
  }
  set_input_value("sourceFacts", source_parts.join("\n"))
  render_upload_source_chips("sourceList", chip_parts.join("\u001E"))
}

///|
fn handle_upload_source_remove(index_text : String) -> Unit {
  let target_index = index_text.trim().to_string()
  if target_index == "" {
    return
  }
  let records = []
  for record in get_input_value("uploadSourceCache").split("\u001E") {
    let current = record.trim().to_string()
    if current != "" {
      records.push(current)
    }
  }
  let kept = []
  for current_index = 0
      current_index < records.length()
      current_index = current_index + 1 {
    if "\{current_index}" != target_index {
      kept.push(records[current_index])
    }
  }
  let payload = kept.join("\u001E")
  set_input_value("uploadSourceCache", payload)
  apply_upload_source_payload(payload)
}

///|
fn handle_website_source_input(raw_url : String) -> Unit {
  let url = raw_url.trim().to_string()
  let current_url = get_data_attr("websiteFacts", "sourceUrl")
  let current_state = get_data_attr("websiteFacts", "sourceState")
  if url == "" {
    set_website_source_state("empty", "", "", "")
    return
  }
  if current_url == url && current_state == "ready" {
    return
  }
  set_website_source_state("loading", url, "", url)
  request_website_text(
    url,
    text => {
      if get_input_value("websiteUrl").trim().to_string() != url {
        return
      }
      if text.trim().to_string() == "" {
        set_website_source_state("empty", url, "", url)
      } else {
        set_website_source_state("ready", url, text, url)
      }
    },
    message => {
      if get_input_value("websiteUrl").trim().to_string() != url {
        return
      }
      set_website_source_state("error", url, "", message)
    },
  )
}

///|
fn combine_source_materials(
  uploaded_facts : String,
  website_facts : String,
) -> String {
  let parts = []
  let uploaded = uploaded_facts.trim().to_string()
  let website = website_facts.trim().to_string()
  if uploaded != "" {
    parts.push(uploaded)
  }
  if website != "" {
    parts.push(website)
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
fn read_inputs() -> (String, String, String, String, String, String) {
  let brand_name = get_input_value("brandName")
  let website_url = get_input_value("websiteUrl")
  let source_materials = combine_source_materials(
    get_input_value("sourceFacts"),
    get_input_value("websiteFacts"),
  )
  (
    get_input_value("articleTitle"),
    infer_brand_name(brand_name, website_url),
    get_input_value("primaryKeyword"),
    get_input_value("audience"),
    source_materials,
    get_input_value("notesInput"),
  )
}

///|
fn idle_preview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>你好，今天想写些什么？</h2><p>输入官网、上传资料，补一句写作要求，然后点击右下角生成草稿。</p></div>"
  } else {
    "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>Hello, what would you like to write today?</h2><p>Add a website, upload source material, leave a short writing note, then click generate when you are ready.</p></div>"
  }
}

///|
fn idle_audit_overview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 claim 审计结果</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 MoonBit 确定性检查</span></button></div>"
  } else {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to review claim support</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to inspect MoonBit checks</span></button></div>"
  }
}

///|
fn idle_audit_panel_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO 审计面板</p><h3>生成后，这里会出现事实支撑与 SEO 检查。</h3><p>先输入官网、上传 fact sheet，或补一句写作要求；生成后可以在右侧查看 claim 审计、证据摘录和一键改写建议，再导出 HTML。</p></div>"
  } else {
    "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO audit rail</p><h3>Fact grounding and SEO checks will appear here after generation.</h3><p>Add a website, upload a fact sheet, or leave a short writing note first. Once the draft is generated, this rail will show claim review, source excerpts, rewrite suggestions, and HTML export.</p></div>"
  }
}

///|
fn generating_audit_overview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 claim 审计结果</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 MoonBit 确定性检查</span></button></div>"
  } else {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to review claim support</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to inspect MoonBit checks</span></button></div>"
  }
}

///|
fn generating_audit_panel_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-list\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>事实支撑</strong><span>待生成</span></div><p>生成草稿后，会逐条核对 claim 是否被来源材料支撑。</p></article><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>SEO 规则检查</strong><span>待生成</span></div><p>生成后可查看 MoonBit 的确定性规则检查。</p></article></div>"
  } else {
    "<div class=\"audit-list\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Fact grounding</strong><span>Pending</span></div><p>Each claim will be reviewed against the uploaded source materials after generation.</p></article><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>SEO rule checks</strong><span>Pending</span></div><p>MoonBit deterministic checks will appear after the draft is generated.</p></article></div>"
  }
}

///|
fn set_export_enabled(enabled : Bool) -> Unit {
  set_disabled("exportButton", !enabled)
}

///|
fn render_idle_state() -> Unit {
  set_page_mode("idle")
  cache_rerun_audit_state("")
  set_html("previewPanel", idle_preview_html(get_lang_state()))
  set_html("scorePanel", idle_audit_overview_html(get_lang_state()))
  set_html("auditPanel", idle_audit_panel_html(get_lang_state()))
  set_export_enabled(false)
}

///|
fn rerender_source_chips_for_current_language() -> Unit {
  apply_upload_source_payload(get_input_value("uploadSourceCache"))
  let website_state = get_data_attr("websiteFacts", "sourceState")
  let website_url = get_data_attr("websiteFacts", "sourceUrl")
  let website_text = get_input_value("websiteFacts")
  if website_url == "" && website_state == "empty" {
    clear_website_source_chip("sourceList")
  } else {
    let chip_text = if website_state == "error" || website_state == "loading" {
      website_url
    } else if website_url != "" {
      website_url
    } else {
      website_text
    }
    render_website_source_chip(
      "sourceList",
      website_chip_label(website_state, get_lang_state()),
      chip_text,
    )
  }
}

///|
fn cache_render_mode(mode : String) -> Unit {
  set_input_value("renderModeCache", mode)
}

///|
fn cache_generation_base_mode(mode : String) -> Unit {
  set_input_value("generationBaseModeCache", mode)
}

///|
fn cache_draft_payload(payload : String) -> Unit {
  set_input_value("draftPayloadCache", payload)
}

///|
fn cache_claim_review_state(state : String, payload : String) -> Unit {
  set_input_value("claimReviewStateCache", state)
  set_input_value("claimReviewPayloadCache", payload)
}

///|
fn cache_claim_review_html(html : String) -> Unit {
  set_input_value("claimReviewHtmlCache", html)
}

///|
fn cache_claim_review_counts(
  supported : Int,
  needs_review : Int,
  unsupported : Int,
  total : Int,
) -> Unit {
  set_input_value("claimSupportedCountCache", "\{supported}")
  set_input_value("claimNeedsReviewCountCache", "\{needs_review}")
  set_input_value("claimUnsupportedCountCache", "\{unsupported}")
  set_input_value("claimTotalCountCache", "\{total}")
}

///|
fn cache_draft_audit_inputs(keyword : String, evidence_count : Int) -> Unit {
  set_input_value("draftKeywordCache", keyword)
  set_input_value("draftEvidenceCountCache", "\{evidence_count}")
}

///|
fn cache_claim_snapshot_from_preview() -> Unit {
  set_input_value("claimSnapshotCache", snapshot_claim_payload("previewPanel"))
}

///|
fn parse_cached_int(id : String) -> Int {
  let mut value = 0
  for scalar in get_input_value(id).trim().iter() {
    let code = scalar.to_int()
    if code >= 48 && code <= 57 {
      value = value * 10 + (code - 48)
    }
  }
  value
}

///|
fn cache_draft_edit_state(state : String) -> Unit {
  set_input_value("draftEditedStateCache", state)
}

///|
fn cache_rerun_audit_state(state : String) -> Unit {
  set_input_value("rerunAuditStateCache", state)
}

///|
fn sync_audit_stale_banner() -> Unit {
  let lang = get_lang_state()
  let stale = get_input_value("draftEditedStateCache").trim().to_string() ==
    "dirty"
  set_status_banner(
    "auditStaleBanner",
    "loading",
    if lang == "zh" {
      "你修改过正文，当前审计结果可能已过期。"
    } else {
      "You edited the draft, so the current audit results may be outdated."
    },
    !stale,
  )
}

///|
fn sync_rerun_audit_button() -> Unit {
  let lang = get_lang_state()
  let stale = get_input_value("draftEditedStateCache").trim().to_string() ==
    "dirty"
  let loading = get_input_value("rerunAuditStateCache").trim().to_string() ==
    "loading"
  let label = if loading && lang == "zh" {
    "重新审计中..."
  } else if loading {
    "Re-running..."
  } else if lang == "zh" {
    "重新审计"
  } else {
    "Re-run audit"
  }
  set_text(
    "rerunAuditButton",
    label,
  )
  set_attr("rerunAuditButton", "aria-label", label)
  set_attr("rerunAuditButton", "title", label)
  set_disabled("rerunAuditButton", loading)
  set_attr(
    "rerunAuditButton",
    "style",
    if stale || loading {
      ""
    } else {
      "display:none"
    },
  )
}

///|
fn cached_claim_review_report() -> @moonseo.ClaimReviewReport {
  let state = get_input_value("claimReviewStateCache").trim().to_string()
  @moonseo.claim_review_report_snapshot(
    parse_cached_int("claimSupportedCountCache"),
    parse_cached_int("claimNeedsReviewCountCache"),
    parse_cached_int("claimUnsupportedCountCache"),
    parse_cached_int("claimTotalCountCache"),
    state != "insufficient",
    get_input_value("claimReviewHtmlCache"),
  )
}

///|
fn rerun_seo_audit_from_preview() -> Unit {
  if !is_page_mode("ready") {
    return
  }
  let article_html = snapshot_export_article_html("previewPanel")
    .trim()
    .to_string()
  let plain_text = snapshot_preview_plain_text("previewPanel")
    .trim()
    .to_string()
  if article_html == "" || plain_text == "" {
    return
  }
  let ui_lang = get_lang_state()
  let claim_report = cached_claim_review_report()
  let seo_report = @moonseo.audit_report_for_rendered(
    get_data_attr("exportButton", "exportTitle"),
    get_data_attr("exportButton", "exportMeta"),
    get_data_attr("exportButton", "exportSlug"),
    article_html,
    plain_text,
    get_input_value("draftKeywordCache"),
    parse_cached_int("draftEvidenceCountCache"),
    ui_lang,
  )
  set_html(
    "scorePanel",
    @moonseo.render_audit_overview(claim_report, seo_report, ui_lang),
  )
  set_html(
    "auditPanel",
    "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(seo_report, ui_lang)}",
  )
  set_status_success(
    if ui_lang == "zh" {
      "SEO 审计已按当前正文重新计算。"
    } else {
      "SEO audit refreshed from the current draft."
    },
  )
}

///|
fn rerun_claim_review_from_preview() -> Bool {
  if !is_page_mode("ready") {
    return false
  }
  let (
    _article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
  ) = read_inputs()
  if !@moonseo.has_real_sources(source_materials_raw) {
    return false
  }
  let article_html = snapshot_export_article_html("previewPanel")
    .trim()
    .to_string()
  let plain_text = snapshot_preview_plain_text("previewPanel")
    .trim()
    .to_string()
  let claims = @moonseo.claim_anchors_from_snapshot(
    get_input_value("claimSnapshotCache"),
  )
  if article_html == "" || plain_text == "" || claims.length() == 0 {
    return false
  }
  let ui_lang = get_lang_state()
  let seo_report = @moonseo.audit_report_for_rendered(
    get_data_attr("exportButton", "exportTitle"),
    get_data_attr("exportButton", "exportMeta"),
    get_data_attr("exportButton", "exportSlug"),
    article_html,
    plain_text,
    get_input_value("draftKeywordCache"),
    parse_cached_int("draftEvidenceCountCache"),
    ui_lang,
  )
  let loading_claim_report = @moonseo.loading_claim_review_report(
    claims.length(),
    ui_lang,
  )
  cache_claim_review_state("loading", "")
  cache_claim_review_html(loading_claim_report.findings_html)
  cache_claim_review_counts(0, 0, 0, claims.length())
  set_html(
    "scorePanel",
    @moonseo.render_audit_overview(loading_claim_report, seo_report, ui_lang),
  )
  set_html(
    "auditPanel",
    "\{loading_claim_report.findings_html}\{@moonseo.render_seo_rule_section(seo_report, ui_lang)}",
  )
  set_status_loading(
    if ui_lang == "zh" {
      "正在按当前正文重新审阅关键 claims。"
    } else {
      "Reviewing key claims against the current draft."
    },
  )
  let prompt = @moonseo.build_claim_review_prompt(
    get_data_attr("exportButton", "exportTitle"),
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
    claims,
    ui_lang,
  )
  request_ai_payload(
    "/api/claim-review",
    prompt,
    payload => {
      let claim_report = @moonseo.claim_review_report_from_payload(
        payload, claims, source_materials_raw, ui_lang,
      )
      cache_claim_review_state("success", payload)
      cache_claim_review_html(claim_report.findings_html)
      cache_claim_review_counts(
        claim_report.supported_count,
        claim_report.needs_review_count,
        claim_report.unsupported_count,
        claim_report.total_count,
      )
      cache_rerun_audit_state("")
      set_html(
        "scorePanel",
        @moonseo.render_audit_overview(claim_report, seo_report, ui_lang),
      )
      set_html(
        "auditPanel",
        "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(seo_report, ui_lang)}",
      )
      cache_draft_edit_state("clean")
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_success(
        if ui_lang == "zh" {
          "审计已按当前正文重新计算。"
        } else {
          "Audit refreshed from the current draft."
        },
      )
    },
    message => {
      cache_claim_review_state("failed", message)
      cache_rerun_audit_state("")
      cache_draft_edit_state("dirty")
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_error(
        if ui_lang == "zh" {
          "SEO 审计已刷新，但 claim review 重跑失败：\{message}"
        } else {
          "SEO audit refreshed, but claim review rerun failed: \{message}"
        },
      )
    },
  )
  true
}

///|
fn rerender_audit_for_current_language() -> Unit {
  if is_page_mode("idle") {
    return
  }
  let ui_lang = get_lang_state()
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
  ) = read_inputs()
  let render_mode = get_input_value("renderModeCache").trim().to_string()
  let draft_payload = get_input_value("draftPayloadCache")
  let claim_state = get_input_value("claimReviewStateCache").trim().to_string()
  let claim_payload = get_input_value("claimReviewPayloadCache")
  let (draft, _) = if render_mode == "ai" &&
    draft_payload.trim().to_string() != "" {
    @moonseo.generate_ai_demo_localized(
      article_title,
      brand_name,
      primary_keyword,
      audience,
      source_materials_raw,
      notes_raw,
      draft_payload,
      content_lang(),
    )
  } else {
    @moonseo.generate_demo_localized(
      article_title,
      brand_name,
      primary_keyword,
      audience,
      source_materials_raw,
      content_lang(),
    )
  }
  let seo_report = @moonseo.audit_report_for_ui(draft, ui_lang)
  let claim_report = if claim_state == "success" {
    @moonseo.claim_review_report_from_payload(
      claim_payload,
      draft.claims,
      source_materials_raw,
      ui_lang,
    )
  } else if claim_state == "failed" {
    @moonseo.failed_claim_review_report(
      claim_payload,
      draft.claims.length(),
      ui_lang,
    )
  } else if claim_state == "loading" {
    @moonseo.loading_claim_review_report(draft.claims.length(), ui_lang)
  } else if claim_state == "insufficient" {
    @moonseo.insufficient_claim_review_report(ui_lang)
  } else {
    @moonseo.empty_claim_review_report(draft.claims.length(), ui_lang)
  }
  set_export_enabled(true)
  set_html(
    "scorePanel",
    @moonseo.render_audit_overview(claim_report, seo_report, ui_lang),
  )
  set_html(
    "auditPanel",
    "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(seo_report, ui_lang)}",
  )
}

///|
fn rerender_generating_state_for_current_language() -> Unit {
  let ui_lang = get_lang_state()
  let base_mode = get_input_value("generationBaseModeCache").trim().to_string()
  cache_rerun_audit_state("")
  cache_draft_edit_state("clean")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  if base_mode == "idle" || base_mode == "" {
    set_html("previewPanel", idle_preview_html(ui_lang))
  }
  set_html("scorePanel", generating_audit_overview_html(ui_lang))
  set_html("auditPanel", generating_audit_panel_html(ui_lang))
  set_export_enabled(false)
  set_status_loading(
    if ui_lang == "zh" {
      "正在生成英文长文草稿。答辩时请优先使用稳定 Wi-Fi，网络会比热点更稳。"
    } else {
      "Generating a long-form English draft. For demos, stable Wi-Fi is more reliable than a mobile hotspot."
    },
  )
}

///|
fn sync_generate_button_copy() -> Unit {
  let lang = get_lang_state()
  let generating = is_page_mode("generating")
  set_text("generateButton", if generating { "…" } else { "↑" })
  set_attr(
    "generateButton",
    "aria-label",
    if generating {
      if lang == "zh" {
        "正在生成草稿"
      } else {
        "Generating Draft"
      }
    } else if lang == "zh" {
      "生成草稿"
    } else {
      "Generate Draft"
    },
  )
  set_attr(
    "generateButton",
    "title",
    if generating {
      if lang == "zh" {
        "正在生成草稿"
      } else {
        "Generating Draft"
      }
    } else if lang == "zh" {
      "生成草稿"
    } else {
      "Generate Draft"
    },
  )
  set_disabled("generateButton", generating)
}

///|
fn render_ai_content(payload : String) -> Unit {
  let ui_lang = get_lang_state()
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
  ) = read_inputs()
  let (draft, _) = @moonseo.generate_ai_demo_localized(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
    payload,
    content_lang(),
  )
  cache_render_mode("ai")
  cache_draft_payload(payload)
  let seo_report = @moonseo.audit_report_for_ui(draft, ui_lang)
  apply_rendered(
    draft,
    seo_report,
    if @moonseo.has_real_sources(source_materials_raw) {
      @moonseo.loading_claim_review_report(draft.claims.length(), ui_lang)
    } else {
      @moonseo.insufficient_claim_review_report(ui_lang)
    },
    ui_lang,
  )
  if @moonseo.has_real_sources(source_materials_raw) {
    cache_claim_review_state("loading", "")
    trigger_claim_review(
      draft, seo_report, brand_name, primary_keyword, audience, source_materials_raw,
      notes_raw, ui_lang,
    )
  } else {
    cache_claim_review_state("insufficient", "")
    set_status_success(
      if ui_lang == "zh" {
        "正文已生成，但当前没有真实来源材料，暂不进行事实支撑审计。"
      } else {
        "The draft is ready, but fact-grounding review is skipped until real source material is added."
      },
    )
  }
}

///|
fn apply_rendered(
  draft : @moonseo.Draft,
  report : @moonseo.AuditReport,
  claim_report : @moonseo.ClaimReviewReport,
  ui_lang : String,
) -> Unit {
  set_page_mode("ready")
  cache_rerun_audit_state("")
  set_export_enabled(true)
  cache_export_file(
    "exportButton",
    @moonseo.export_filename(draft),
    draft.export_html,
    draft.title,
    draft.meta_description,
    draft.slug,
    content_lang(),
  )
  set_html(
    "scorePanel",
    @moonseo.render_audit_overview(claim_report, report, ui_lang),
  )
  cache_claim_review_html(claim_report.findings_html)
  cache_claim_review_counts(
    claim_report.supported_count,
    claim_report.needs_review_count,
    claim_report.unsupported_count,
    claim_report.total_count,
  )
  cache_draft_audit_inputs(draft.keyword, draft.evidence_count)
  set_html(
    "auditPanel",
    "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(report, ui_lang)}",
  )
  set_html("previewPanel", draft.preview_html)
  cache_claim_snapshot_from_preview()
  cache_draft_edit_state("clean")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  set_data_attr("previewPanel", "selectedClaim", "")
  sync_export_from_preview("previewPanel", "exportButton")
  render_evidence_detail_dom(
    "previewPanel", "evidenceCoverageDetail", "evidenceCoverageCard",
  )
}

///|
fn trigger_claim_review(
  draft : @moonseo.Draft,
  seo_report : @moonseo.AuditReport,
  brand_name : String,
  primary_keyword : String,
  audience : String,
  facts_raw : String,
  notes_raw : String,
  ui_lang : String,
) -> Unit {
  let prompt = @moonseo.build_claim_review_prompt(
    draft.title,
    brand_name,
    primary_keyword,
    audience,
    facts_raw,
    notes_raw,
    draft.claims,
    ui_lang,
  )
  set_status_loading(
    if ui_lang == "zh" {
      "正文已生成，AI 正在逐条审阅关键 claims 是否被来源材料支撑。"
    } else {
      "The draft is ready. AI is now reviewing key claims against the uploaded source materials."
    },
  )
  request_ai_payload(
    "/api/claim-review",
    prompt,
    payload => {
      cache_claim_review_state("success", payload)
      apply_rendered(
        draft,
        seo_report,
        @moonseo.claim_review_report_from_payload(
          payload,
          draft.claims,
          facts_raw,
          ui_lang,
        ),
        ui_lang,
      )
      set_status_success(
        if ui_lang == "zh" {
          "Fact grounding audit 已更新。你现在可以逐条查看 claim 的支撑情况。"
        } else {
          "The fact-grounding audit is ready. You can now inspect each reviewed claim."
        },
      )
    },
    message => {
      cache_claim_review_state("failed", message)
      apply_rendered(
        draft,
        seo_report,
        @moonseo.failed_claim_review_report(
          message,
          draft.claims.length(),
          ui_lang,
        ),
        ui_lang,
      )
      set_status_error(
        if ui_lang == "zh" {
          "草稿已生成，但逐条 claim 审阅暂时失败：\{message}"
        } else {
          "The draft was generated, but the claim-by-claim review failed: \{message}"
        },
      )
    },
  )
}

///|
fn refresh_claim_review_for_current_language() -> Unit {
  if is_page_mode("idle") || is_page_mode("generating") {
    return
  }
  let claim_state = get_input_value("claimReviewStateCache").trim().to_string()
  if claim_state != "success" {
    return
  }
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
  ) = read_inputs()
  if !@moonseo.has_real_sources(source_materials_raw) {
    return
  }
  let render_mode = get_input_value("renderModeCache").trim().to_string()
  let draft_payload = get_input_value("draftPayloadCache")
  let ui_lang = get_lang_state()
  let (draft, _) = if render_mode == "ai" &&
    draft_payload.trim().to_string() != "" {
    @moonseo.generate_ai_demo_localized(
      article_title,
      brand_name,
      primary_keyword,
      audience,
      source_materials_raw,
      notes_raw,
      draft_payload,
      content_lang(),
    )
  } else {
    @moonseo.generate_demo_localized(
      article_title,
      brand_name,
      primary_keyword,
      audience,
      source_materials_raw,
      content_lang(),
    )
  }
  let seo_report = @moonseo.audit_report_for_ui(draft, ui_lang)
  cache_claim_review_state("loading", "")
  apply_rendered(
    draft,
    seo_report,
    @moonseo.loading_claim_review_report(draft.claims.length(), ui_lang),
    ui_lang,
  )
  trigger_claim_review(
    draft, seo_report, brand_name, primary_keyword, audience, source_materials_raw,
    notes_raw, ui_lang,
  )
}

///|
fn export_current() -> Unit {
  download_cached_file("exportButton")
}

///|
fn trigger_generation() -> Unit {
  let ui_lang = get_lang_state()
  let previous_mode = current_page_mode()
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
  ) = read_inputs()
  let website_state = get_data_attr("websiteFacts", "sourceState")
  if get_input_value("websiteUrl").trim().to_string() != "" &&
    website_state == "loading" {
    set_status_loading(
      if ui_lang == "zh" {
        "官网正文仍在抓取中，请稍候再生成。"
      } else {
        "Website content is still loading. Please generate again in a moment."
      },
    )
    return
  }
  let prompt = @moonseo.build_ai_prompt(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
    content_lang(),
  )
  cache_generation_base_mode(previous_mode)
  set_page_mode("generating")
  cache_rerun_audit_state("")
  cache_draft_edit_state("clean")
  sync_generate_button_copy()
  rerender_generating_state_for_current_language()
  request_ai_payload(
    "/api/draft",
    prompt,
    payload => {
      render_ai_content(payload)
      restore_generate_button()
    },
    message => {
      set_page_mode(previous_mode)
      sync_generate_button_copy()
      set_status_error(
        if ui_lang == "zh" {
          "AI 生成失败，当前保留你刚才的页面状态：\{message}"
        } else {
          "AI generation failed, so the current page state was preserved: \{message}"
        },
      )
    },
  )
}

///|
fn restore_generate_button() -> Unit {
  cache_generation_base_mode("ready")
  set_page_mode("ready")
  sync_generate_button_copy()
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
  set_text("settingsSummary", if lang == "zh" { "设置" } else { "Settings" })
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
  rerender_source_chips_for_current_language()
  sync_generate_button_copy()
  if is_page_mode("idle") {
    render_idle_state()
  } else if is_page_mode("generating") {
    rerender_generating_state_for_current_language()
  } else {
    rerender_audit_for_current_language()
    refresh_claim_review_for_current_language()
  }
  if !is_page_mode("generating") {
    set_status_success(
      if lang == "zh" {
        "界面语言已更新。文章默认仍会按英文生成，除非你在输入里明确要求其他语言。"
      } else {
        "UI language updated. Drafts still default to English unless your input explicitly asks for another language."
      },
    )
  }
  sync_audit_stale_banner()
  sync_rerun_audit_button()
}

///|
fn app_shell_html() -> String {
  let builder = StringBuilder::new()
  builder.write_string("<section class=\"app-layout\">")
  builder.write_string("<section class=\"left-rail\">")
  builder.write_string(
    "<div id=\"statusBanner\" class=\"status-banner\" hidden></div>",
  )
  builder.write_string("<section class=\"panel draft-panel\">")
  builder.write_string("<div id=\"previewPanel\" class=\"draft-scroll\"></div>")
  builder.write_string("</section>")
  builder.write_string("<section class=\"composer-bar\">")
  builder.write_string("<div id=\"sourceList\" class=\"source-list\"></div>")
  builder.write_string("<div class=\"composer-shell\">")
  builder.write_string(
    "<input id=\"sourceUpload\" type=\"file\" accept=\".txt,.md,.pdf,.doc,.docx\" multiple hidden />",
  )
  builder.write_string("<textarea id=\"sourceFacts\" hidden></textarea>")
  builder.write_string("<textarea id=\"uploadSourceCache\" hidden></textarea>")
  builder.write_string("<textarea id=\"websiteFacts\" hidden></textarea>")
  builder.write_string("<textarea id=\"renderModeCache\" hidden></textarea>")
  builder.write_string(
    "<textarea id=\"generationBaseModeCache\" hidden></textarea>",
  )
  builder.write_string("<textarea id=\"draftPayloadCache\" hidden></textarea>")
  builder.write_string(
    "<textarea id=\"claimReviewStateCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimReviewPayloadCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimReviewHtmlCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimSupportedCountCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimNeedsReviewCountCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimUnsupportedCountCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"claimTotalCountCache\" hidden></textarea>",
  )
  builder.write_string("<textarea id=\"claimSnapshotCache\" hidden></textarea>")
  builder.write_string("<textarea id=\"draftKeywordCache\" hidden></textarea>")
  builder.write_string(
    "<textarea id=\"draftEvidenceCountCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"draftEditedStateCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"rerunAuditStateCache\" hidden></textarea>",
  )
  builder.write_string(
    "<textarea id=\"notesInput\" class=\"composer-input\" rows=\"3\"></textarea>",
  )
  builder.write_string("<div class=\"composer-toolbar\">")
  builder.write_string("<details id=\"uploadMenu\" class=\"composer-menu\">")
  builder.write_string(
    "<summary id=\"uploadButton\" class=\"toolbar-button icon-button secondary\" aria-label=\"Upload Sources\" title=\"Upload Sources\">+</summary>",
  )
  builder.write_string("<div class=\"composer-menu-panel upload-menu-panel\">")
  builder.write_string(
    "<button id=\"uploadPickerButton\" type=\"button\" class=\"menu-action\">Choose Files</button>",
  )
  builder.write_string(
    "<p id=\"uploadFormatsNote\" class=\"menu-note\">Supports fact sheets, PDF, DOC, DOCX, TXT, and MD</p>",
  )
  builder.write_string("</div></details>")
  builder.write_string(
    "<details id=\"briefDrawer\" class=\"composer-menu brief-drawer\">",
  )
  builder.write_string(
    "<summary id=\"briefSummaryTitle\" class=\"toolbar-button\">Custom</summary>",
  )
  builder.write_string("<div class=\"composer-menu-panel brief-body\">")
  builder.write_string("<div class=\"brief-grid\">")
  builder.write_string("<label class=\"field\">")
  builder.write_string("<span id=\"brandLabel\">Brand Name</span>")
  builder.write_string("<input id=\"brandName\" type=\"text\" value=\"\" />")
  builder.write_string("</label>")
  builder.write_string("<label class=\"field\">")
  builder.write_string("<span id=\"websiteLabel\">Brand Website</span>")
  builder.write_string("<input id=\"websiteUrl\" type=\"url\" value=\"\" />")
  builder.write_string("</label>")
  builder.write_string("<label class=\"field\">")
  builder.write_string("<span id=\"articleTitleLabel\">Article Title</span>")
  builder.write_string("<input id=\"articleTitle\" type=\"text\" value=\"\" />")
  builder.write_string("</label>")
  builder.write_string("<label class=\"field\">")
  builder.write_string("<span id=\"keywordLabel\">Primary Keyword</span>")
  builder.write_string(
    "<input id=\"primaryKeyword\" type=\"text\" value=\"\" />",
  )
  builder.write_string("</label>")
  builder.write_string("</div>")
  builder.write_string("<input id=\"audience\" type=\"hidden\" value=\"\" />")
  builder.write_string("</div></details>")
  builder.write_string(
    "<button id=\"generateButton\" type=\"button\" class=\"send-button secondary\" aria-label=\"Generate Draft\" title=\"Generate Draft\">↑</button>",
  )
  builder.write_string("</div></div></section></section>")
  builder.write_string("<aside class=\"panel audit-panel\">")
  builder.write_string(
    "<div class=\"audit-actions\"><div class=\"audit-toolbar\">",
  )
  builder.write_string(
    "<button id=\"exportButton\" type=\"button\">Export HTML</button>",
  )
  builder.write_string(
    "<button id=\"rerunAuditButton\" type=\"button\" class=\"secondary\" style=\"display:none\">Re-run audit</button>",
  )
  builder.write_string("<details id=\"settingsMenu\" class=\"settings-menu\">")
  builder.write_string("<summary id=\"settingsSummary\">Settings</summary>")
  builder.write_string(
    "<div class=\"settings-panel\"><div class=\"settings-section\">",
  )
  builder.write_string(
    "<p id=\"settingsLanguageLabel\" class=\"settings-label\">Language</p>",
  )
  builder.write_string(
    "<div class=\"lang-switch\" aria-label=\"language switch\">",
  )
  builder.write_string(
    "<button id=\"langZhButton\" type=\"button\" data-lang-switch=\"zh\" class=\"lang-pill\">中文</button>",
  )
  builder.write_string(
    "<button id=\"langEnButton\" type=\"button\" data-lang-switch=\"en\" class=\"lang-pill active\">EN</button>",
  )
  builder.write_string("</div></div></div></details></div></div>")
  builder.write_string("<div class=\"audit-scroll\">")
  builder.write_string(
    "<div id=\"auditStaleBanner\" class=\"status-banner audit-stale-banner\" hidden></div>",
  )
  builder.write_string("<div id=\"scorePanel\"></div>")
  builder.write_string("<div id=\"auditPanel\"></div>")
  builder.write_string("</div></aside></section>")
  builder.to_string()
}

///|
fn main {
  set_html("app", app_shell_html())
  cache_render_mode("idle")
  cache_draft_payload("")
  cache_claim_review_state("", "")
  cache_claim_review_html("")
  cache_claim_review_counts(0, 0, 0, 0)
  set_input_value("claimSnapshotCache", "")
  cache_draft_audit_inputs("", 0)
  cache_draft_edit_state("clean")
  cache_rerun_audit_state("")
  hydrate_persistent_input("brandName", "moonseo.brand_name")
  hydrate_persistent_input("websiteUrl", "moonseo.website_url")
  hydrate_persistent_input("articleTitle", "moonseo.article_title")
  hydrate_persistent_input("primaryKeyword", "moonseo.primary_keyword")
  hydrate_persistent_input("notesInput", "moonseo.notes_input")
  bind_persistent_input_events("brandName", value => {
    persist_input_value("moonseo.brand_name", value)
  })
  bind_persistent_input_events("websiteUrl", value => {
    persist_input_value("moonseo.website_url", value)
  })
  bind_persistent_input_events("articleTitle", value => {
    persist_input_value("moonseo.article_title", value)
  })
  bind_persistent_input_events("primaryKeyword", value => {
    persist_input_value("moonseo.primary_keyword", value)
  })
  bind_persistent_input_events("notesInput", value => {
    persist_input_value("moonseo.notes_input", value)
  })
  bind_click_stopper("uploadMenu")
  bind_click_stopper("briefDrawer")
  bind_click_stopper("settingsMenu")
  bind_document_click(() => close_all_floating_menus())
  bind_menu_trigger("uploadButton", () => handle_upload_menu_toggle())
  bind_menu_trigger("briefSummaryTitle", () => handle_brief_menu_toggle())
  bind_menu_trigger("settingsSummary", () => handle_settings_menu_toggle())
  bind_preview_edit_events("previewPanel", () => {
    sync_export_from_preview("previewPanel", "exportButton")
    cache_claim_snapshot_from_preview()
    if is_page_mode("ready") {
      cache_draft_edit_state("dirty")
      sync_audit_stale_banner()
      sync_rerun_audit_button()
    }
  })
  bind_evidence_ref_events("previewPanel", payload => {
    handle_evidence_selection(payload)
  })
  bind_claim_review_events(
    "auditPanel",
    claim_id => handle_claim_selection(claim_id),
    payload => handle_claim_apply(payload),
  )
  bind_summary_button_events("auditPanel", target_id => {
    handle_summary_button(target_id)
  })
  bind_summary_button_events("scorePanel", target_id => {
    handle_summary_button(target_id)
  })
  bind_source_upload_input("sourceUpload", payload => {
    handle_source_upload_payload(payload)
  })
  bind_source_chip_remove_events("sourceList", index_text => {
    handle_upload_source_remove(index_text)
  })
  bind_debounced_input_value("websiteUrl", 350, url => {
    handle_website_source_input(url)
  })
  apply_language("en")
  expose_generate_handler(() => trigger_generation())
  add_click_listener("langZhButton", () => apply_language("zh"))
  add_click_listener("langEnButton", () => apply_language("en"))
  add_click_listener("uploadPickerButton", () => trigger_click("sourceUpload"))
  add_click_listener("generateButton", () => trigger_generation())
  add_click_listener("exportButton", () => export_current())
  add_click_listener("rerunAuditButton", () => {
    cache_rerun_audit_state("loading")
    sync_rerun_audit_button()
    rerun_seo_audit_from_preview()
    if !rerun_claim_review_from_preview() {
      cache_rerun_audit_state("")
      sync_rerun_audit_button()
    }
  })
}
