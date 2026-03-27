///|
extern "js" fn get_effective_brand_name(
  brand_id : String,
  website_id : String,
) -> String =
  #| function(brandId, websiteId) {
  #|   const brandEl = document.getElementById(brandId);
  #|   const websiteEl = document.getElementById(websiteId);
  #|   const direct = brandEl && "value" in brandEl ? String(brandEl.value || "").trim() : "";
  #|   if (direct) {
  #|     return direct;
  #|   }
  #|   const website = websiteEl && "value" in websiteEl ? String(websiteEl.value || "").trim() : "";
  #|   if (!website) {
  #|     return "";
  #|   }
  #|   try {
  #|     const hostname = new URL(website).hostname.replace(/^www\./, "");
  #|     const firstLabel = hostname.split(".")[0] || "";
  #|     if (!firstLabel) {
  #|       return "";
  #|     }
  #|     return firstLabel
  #|       .split(/[-_]/g)
  #|       .filter(Boolean)
  #|       .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
  #|       .join(" ");
  #|   } catch (_error) {
  #|     return "";
  #|   }
  #| }

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
extern "js" fn bind_evidence_refs(
  preview_id : String,
  detail_id : String,
  card_id : String,
) -> Unit =
  #| function(previewId, detailId, cardId) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview || preview.dataset.evidenceBound === "true") {
  #|     return;
  #|   }
  #|   preview.dataset.evidenceBound = "true";
  #|   preview.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".evidence-ref") : null;
  #|     const detail = document.getElementById(detailId);
  #|     const card = document.getElementById(cardId);
  #|     if (!target || !detail || !card) {
  #|       return;
  #|     }
  #|     preview.querySelectorAll(".evidence-ref").forEach((ref) => ref.classList.remove("active"));
  #|     target.classList.add("active");
  #|     preview.querySelectorAll(".claim-block.is-active").forEach((node) => node.classList.remove("is-active"));
  #|     const title = target.getAttribute("data-evidence-label") || "";
  #|     const body = target.getAttribute("data-evidence-text") || "";
  #|     const source = target.getAttribute("data-evidence-source") || "";
  #|     const claimBlock = target.closest(".claim-block");
  #|     if (claimBlock instanceof HTMLElement) {
  #|       claimBlock.classList.add("is-active");
  #|     }
  #|     detail.innerHTML = `<p class="detail-kicker">${source}</p><h4>${title}</h4><p>${body}</p>`;
  #|     card.classList.add("expanded");
  #|     card.classList.remove("flash");
  #|     void card.offsetWidth;
  #|     card.classList.add("flash");
  #|     const seoSection = document.getElementById("seoRuleSection");
  #|     if (seoSection instanceof HTMLDetailsElement) {
  #|       seoSection.open = true;
  #|     }
  #|     card.scrollIntoView({ behavior: "smooth", block: "center" });
  #|   });
  #| }

///|
extern "js" fn sync_export_from_preview(
  preview_id : String,
  export_id : String,
) -> Unit =
  #| function(previewId, exportId) {
  #|   const preview = document.getElementById(previewId);
  #|   const exportButton = document.getElementById(exportId);
  #|   if (!preview || !exportButton) {
  #|     return;
  #|   }
  #|   const escapeHtml = (value) =>
  #|     String(value || "")
  #|       .replaceAll("&", "&amp;")
  #|       .replaceAll("<", "&lt;")
  #|       .replaceAll(">", "&gt;")
  #|       .replaceAll('"', "&quot;");
  #|   const syncExport = () => {
  #|     const article = preview.querySelector(".article-card");
  #|     if (!article) {
  #|       return;
  #|     }
  #|     const lang = exportButton.dataset.exportLang === "zh" ? "zh" : "en";
  #|     const title = exportButton.dataset.exportTitle || "MoonSEO Draft";
  #|     const description = exportButton.dataset.exportMeta || "";
  #|     const slug = exportButton.dataset.exportSlug || "";
  #|     const style =
  #|       "body{margin:0;font-family:Georgia,'Times New Roman',serif;background:#f6f0e8;color:#1e1d1a;}main{max-width:1120px;margin:0 auto;padding:48px 24px 72px;}h1,h2,h3{font-family:'Avenir Next','Helvetica Neue',sans-serif;} .layout{display:grid;grid-template-columns:1fr;gap:24px;align-items:start;} .article-card{padding:0;background:transparent;border:0;border-radius:0;} .article-card h1{margin:0 0 12px;} .article-card p{margin:0;line-height:1.62;} section+section{margin-top:20px;} .evidence-ref{display:inline-flex;align-items:center;justify-content:center;min-width:24px;height:24px;margin-left:4px;border:0;border-radius:999px;background:rgba(155,92,29,.12);color:#9b5c1d;font-size:12px;font-weight:700;vertical-align:middle;} @media (max-width:900px){.layout{grid-template-columns:1fr;}}";
  #|     const articleClone = article.cloneNode(true);
  #|     articleClone.querySelectorAll("[contenteditable]").forEach((node) => node.removeAttribute("contenteditable"));
  #|     articleClone.querySelectorAll("[spellcheck]").forEach((node) => node.removeAttribute("spellcheck"));
  #|     articleClone.querySelectorAll(".editable-field").forEach((node) => node.classList.remove("editable-field"));
  #|     articleClone.querySelectorAll(".is-active").forEach((node) => node.classList.remove("is-active"));
  #|     articleClone.querySelectorAll(".evidence-ref.active").forEach((node) => node.classList.remove("active"));
  #|     exportButton.__moonseoExportContent = `<!DOCTYPE html><html lang="${lang}"><head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><title>${escapeHtml(title)}</title><meta name="description" content="${escapeHtml(description)}" /><meta name="slug" content="${escapeHtml(slug)}" /><style>${style}</style></head><body><main><div class="layout">${articleClone.outerHTML}</div></main></body></html>`;
  #|   };
  #|   syncExport();
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
extern "js" fn bind_persistent_input(id : String, key : String) -> Unit =
  #| function(id, key) {
  #|   const el = document.getElementById(id);
  #|   if (!el || !("value" in el)) {
  #|     return;
  #|   }
  #|   const saved = window.localStorage.getItem(key);
  #|   if (saved !== null) {
  #|     if (key === "moonseo.primary_keyword" && saved.trim() === "seo content audit") {
  #|       window.localStorage.removeItem(key);
  #|       el.value = "";
  #|     } else {
  #|       el.value = saved;
  #|     }
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
extern "js" fn expose_generate_handler(cb : () -> Unit) -> Unit =
  #| function(cb) {
  #|   window.__moonseoGenerate = cb;
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
extern "js" fn bind_details_menu(menu_id : String, trigger_id : String) -> Unit =
  #| function(menuId, triggerId) {
  #|   const menu = document.getElementById(menuId);
  #|   const trigger = document.getElementById(triggerId);
  #|   if (!menu || !trigger || menu.dataset.bound === "true") {
  #|     return;
  #|   }
  #|   menu.dataset.bound = "true";
  #|   const close = () => menu.removeAttribute("open");
  #|   trigger.addEventListener("click", (event) => {
  #|     event.preventDefault();
  #|     event.stopPropagation();
  #|     if (menu.hasAttribute("open")) {
  #|       close();
  #|     } else {
  #|       menu.setAttribute("open", "");
  #|     }
  #|   });
  #|   menu.addEventListener("click", (event) => event.stopPropagation());
  #|   document.addEventListener("click", close);
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
  #|   const clearUploadChips = () => {
  #|     list.querySelectorAll('[data-source-kind="upload"]').forEach((node) => node.remove());
  #|   };
  #|   const renderFiles = async (files) => {
  #|     const lang = currentLang();
  #|     const ui = copy[lang];
  #|     clearUploadChips();
  #|     if (!files.length) {
  #|       target.value = "";
  #|       cb();
  #|       return;
  #|     }
  #|     const extracted = [];
  #|     for (const file of files) {
  #|       const ext = (file.name.split(".").pop() || "").toLowerCase();
  #|       const chip = document.createElement("div");
  #|       chip.className = "source-chip";
  #|       chip.dataset.sourceKind = "upload";
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
extern "js" fn bind_website_source(
  url_id : String,
  target_id : String,
  list_id : String,
  cb : () -> Unit,
) -> Unit =
  #| function(urlId, targetId, listId, cb) {
  #|   const urlInput = document.getElementById(urlId);
  #|   const target = document.getElementById(targetId);
  #|   const list = document.getElementById(listId);
  #|   if (!urlInput || !target || !list || target.dataset.bound === "true") {
  #|     return;
  #|   }
  #|   target.dataset.bound = "true";
  #|   const copy = {
  #|     zh: {
  #|       loading: "抓取中",
  #|       ready: "官网正文",
  #|       failed: "抓取失败",
  #|       empty: "官网来源",
  #|       invalid: "请输入有效的官网 URL",
  #|     },
  #|     en: {
  #|       loading: "Fetching",
  #|       ready: "Website copy",
  #|       failed: "Fetch failed",
  #|       empty: "Website source",
  #|       invalid: "Enter a valid website URL",
  #|     },
  #|   };
  #|   const currentLang = () => (document.body.dataset.lang === "en" ? "en" : "zh");
  #|   const chipId = "website-source-chip";
  #|   const upsertChip = (label, text) => {
  #|     let chip = document.getElementById(chipId);
  #|     if (!chip) {
  #|       chip = document.createElement("div");
  #|       chip.id = chipId;
  #|       chip.className = "source-chip";
  #|       chip.dataset.sourceKind = "website";
  #|       chip.innerHTML = "<strong></strong><span></span>";
  #|       list.appendChild(chip);
  #|     }
  #|     const strong = chip.querySelector("strong");
  #|     const span = chip.querySelector("span");
  #|     if (strong) strong.textContent = label;
  #|     if (span) span.textContent = text;
  #|   };
  #|   const clearChip = () => {
  #|     const chip = document.getElementById(chipId);
  #|     if (chip) {
  #|       chip.remove();
  #|     }
  #|   };
  #|   let timer = 0;
  #|   let requestId = 0;
  #|   const fetchWebsite = async () => {
  #|     const url = String(urlInput.value || "").trim();
  #|     const lang = currentLang();
  #|     const ui = copy[lang];
  #|     if (!url) {
  #|       target.value = "";
  #|       target.dataset.sourceState = "empty";
  #|       target.dataset.sourceUrl = "";
  #|       clearChip();
  #|       cb();
  #|       return;
  #|     }
  #|     try {
  #|       new URL(url);
  #|     } catch (_error) {
  #|       target.value = "";
  #|       target.dataset.sourceState = "error";
  #|       target.dataset.sourceUrl = url;
  #|       upsertChip(ui.failed, ui.invalid);
  #|       cb();
  #|       return;
  #|     }
  #|     if (target.dataset.sourceUrl === url && target.dataset.sourceState === "ready") {
  #|       cb();
  #|       return;
  #|     }
  #|     requestId += 1;
  #|     const currentRequest = requestId;
  #|     target.dataset.sourceState = "loading";
  #|     upsertChip(ui.loading, url);
  #|     try {
  #|       const response = await fetch("/api/fetch-website", {
  #|         method: "POST",
  #|         headers: {
  #|           "Content-Type": "application/json",
  #|         },
  #|         body: JSON.stringify({ url }),
  #|       });
  #|       const data = await response.json();
  #|       if (currentRequest !== requestId) {
  #|         return;
  #|       }
  #|       if (!response.ok) {
  #|         const message =
  #|           data && typeof data.error === "string"
  #|             ? data.error
  #|             : `Request failed with status ${response.status}`;
  #|         target.value = "";
  #|         target.dataset.sourceState = "error";
  #|         target.dataset.sourceUrl = url;
  #|         upsertChip(ui.failed, message);
  #|         cb();
  #|         return;
  #|       }
  #|       const text = String((data && data.text) || "").trim();
  #|       target.value = text;
  #|       target.dataset.sourceState = text ? "ready" : "empty";
  #|       target.dataset.sourceUrl = url;
  #|       if (text) {
  #|         upsertChip(ui.ready, url);
  #|       } else {
  #|         upsertChip(ui.empty, url);
  #|       }
  #|       cb();
  #|     } catch (error) {
  #|       if (currentRequest !== requestId) {
  #|         return;
  #|       }
  #|       target.value = "";
  #|       target.dataset.sourceState = "error";
  #|       target.dataset.sourceUrl = url;
  #|       upsertChip(
  #|         ui.failed,
  #|         error instanceof Error ? error.message : "Unknown website fetch error",
  #|       );
  #|       cb();
  #|     }
  #|   };
  #|   const schedule = () => {
  #|     clearTimeout(timer);
  #|     timer = window.setTimeout(() => {
  #|       void fetchWebsite();
  #|     }, 350);
  #|   };
  #|   urlInput.addEventListener("input", schedule);
  #|   urlInput.addEventListener("change", schedule);
  #|   if (String(urlInput.value || "").trim() !== "") {
  #|     schedule();
  #|   }
  #| }

///|
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
  let source_materials = combine_source_materials(
    get_input_value("sourceFacts"),
    get_input_value("websiteFacts"),
  )
  (
    get_input_value("articleTitle"),
    get_effective_brand_name("brandName", "websiteUrl"),
    get_input_value("primaryKeyword"),
    get_input_value("audience"),
    source_materials,
    get_input_value("notesInput"),
  )
}

///|
fn render_template_content() -> Unit {
  let ui_lang = get_lang_state()
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    _,
  ) = read_inputs()
  let (draft, _) = @moonseo.generate_demo_localized(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    content_lang(),
  )
  apply_rendered(
    draft,
    @moonseo.audit_report_for_ui(draft, ui_lang),
    if @moonseo.has_real_sources(source_materials_raw) {
      @moonseo.empty_claim_review_report(draft.claims.length(), ui_lang)
    } else {
      @moonseo.insufficient_claim_review_report(ui_lang)
    },
    ui_lang,
  )
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
    payload,
    content_lang(),
  )
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
    trigger_claim_review(
      draft, seo_report, brand_name, primary_keyword, audience, source_materials_raw,
      notes_raw, ui_lang,
    )
  } else {
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
  set_html(
    "auditPanel",
    "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(report, ui_lang)}",
  )
  set_html("previewPanel", draft.preview_html)
  set_data_attr("previewPanel", "selectedClaim", "")
  sync_export_from_preview("previewPanel", "exportButton")
  bind_evidence_refs(
    "previewPanel", "evidenceCoverageDetail", "evidenceCoverageCard",
  )
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
  let parts = []
  for part in payload.split("\u001F") {
    parts.push(part.to_string())
  }
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
fn export_current() -> Unit {
  download_cached_file("exportButton")
}

///|
fn trigger_generation() -> Unit {
  let ui_lang = get_lang_state()
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
  set_disabled("generateButton", true)
  set_text("generateButton", "…")
  set_status_loading(
    if ui_lang == "zh" {
      "正在生成英文长文草稿。答辩时请优先使用稳定 Wi-Fi，网络会比热点更稳。"
    } else {
      "Generating a long-form English draft. For demos, stable Wi-Fi is more reliable than a mobile hotspot."
    },
  )
  request_ai_payload(
    "/api/draft",
    prompt,
    payload => {
      render_ai_content(payload)
      restore_generate_button()
    },
    message => {
      set_status_error(
        if ui_lang == "zh" {
          "AI 生成失败，已回退到本地模板：\{message}"
        } else {
          "AI generation failed, so the page fell back to the local template: \{message}"
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
  set_status_success(
    if lang == "zh" {
      "界面语言已更新。文章默认仍会按英文生成，除非你在输入里明确要求其他语言。"
    } else {
      "UI language updated. Drafts still default to English unless your input explicitly asks for another language."
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
  builder.write_string("<textarea id=\"websiteFacts\" hidden></textarea>")
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
  builder.write_string("<div id=\"scorePanel\"></div>")
  builder.write_string("<div id=\"auditPanel\"></div>")
  builder.write_string("</div></aside></section>")
  builder.to_string()
}

///|
fn main {
  set_html("app", app_shell_html())
  bind_persistent_input("brandName", "moonseo.brand_name")
  bind_persistent_input("websiteUrl", "moonseo.website_url")
  bind_persistent_input("articleTitle", "moonseo.article_title")
  bind_persistent_input("primaryKeyword", "moonseo.primary_keyword")
  bind_persistent_input("notesInput", "moonseo.notes_input")
  bind_composer_menus(
    "uploadMenu", "uploadButton", "briefDrawer", "briefSummaryTitle",
  )
  bind_details_menu("settingsMenu", "settingsSummary")
  bind_preview_edit_events("previewPanel", () => {
    sync_export_from_preview("previewPanel", "exportButton")
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
  bind_source_upload("sourceUpload", "sourceFacts", "sourceList", () => {
    render_template_content()
  })
  bind_website_source("websiteUrl", "websiteFacts", "sourceList", () => {
    render_template_content()
  })
  apply_language("en")
  expose_generate_handler(() => trigger_generation())
  add_click_listener("langZhButton", () => apply_language("zh"))
  add_click_listener("langEnButton", () => apply_language("en"))
  add_click_listener("uploadPickerButton", () => trigger_click("sourceUpload"))
  add_click_listener("generateButton", () => trigger_generation())
  add_click_listener("exportButton", () => export_current())
  add_input_listener("articleTitle", () => render_template_content())
  add_input_listener("brandName", () => render_template_content())
  add_input_listener("primaryKeyword", () => render_template_content())
  add_input_listener("audience", () => render_template_content())
  add_input_listener("notesInput", () => render_template_content())
}
