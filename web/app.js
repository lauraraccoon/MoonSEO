class $PanicError extends Error {}
function $panic() {
  throw new $PanicError();
}
function _M0TPB13StringBuilder(param0) {
  this.val = param0;
}
function $bound_check(arr, index) {
  if (index < 0 || index >= arr.length) throw new Error("Index out of bounds");
}
function _M0TPC16string10StringView(param0, param1, param2) {
  this.str = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TPB13SourceLocRepr(param0, param1, param2, param3, param4, param5) {
  this.pkg = param0;
  this.filename = param1;
  this.start_line = param2;
  this.start_column = param3;
  this.end_line = param4;
  this.end_column = param5;
}
function $compare_int(a, b) {
  return (a >= b) - (a <= b);
}
const _M0FPB19int__to__string__js = (x, radix) => {
  return x.toString(radix);
};
function _M0TPC13ref3RefGiE(param0) {
  this.val = param0;
}
function $make_array_len_and_init(a, b) {
  const arr = new Array(a);
  arr.fill(b);
  return arr;
}
const _M0MPB7JSArray4push = (arr, val) => { arr.push(val); };
function _M0TPC13ref3RefGORPC16string10StringViewE(param0) {
  this.val = param0;
}
function _M0TPB9ArrayViewGsE(param0, param1, param2) {
  this.buf = param0;
  this.start = param1;
  this.end = param2;
}
function _M0TP25apple7moonseo12AuditFinding(param0, param1, param2) {
  this.title = param0;
  this.passed = param1;
  this.detail = param2;
}
function _M0TP25apple7moonseo11AuditReport(param0, param1, param2, param3, param4, param5) {
  this.score = param0;
  this.pass_count = param1;
  this.total_count = param2;
  this.summary_text = param3;
  this.summary_html = param4;
  this.findings_html = param5;
}
function _M0TPC13ref3RefGbE(param0) {
  this.val = param0;
}
function _M0TP25apple7moonseo11ClaimAnchor(param0, param1) {
  this.id = param0;
  this.text = param1;
}
function _M0TPC13ref3RefGsE(param0) {
  this.val = param0;
}
function _M0TP25apple7moonseo5Draft(param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10) {
  this.title = param0;
  this.slug = param1;
  this.meta_description = param2;
  this.article_html = param3;
  this.evidence_html = param4;
  this.preview_html = param5;
  this.export_html = param6;
  this.plain_text = param7;
  this.keyword = param8;
  this.evidence_count = param9;
  this.claims = param10;
}
function _M0TP25apple7moonseo17ClaimReviewReport(param0, param1, param2, param3, param4, param5, param6) {
  this.supported_count = param0;
  this.needs_review_count = param1;
  this.unsupported_count = param2;
  this.total_count = param3;
  this.audit_available = param4;
  this.summary_html = param5;
  this.findings_html = param6;
}
const _M0FP45apple7moonseo3cmd3web22set__persistent__value = function(key, value) {
   window.localStorage.setItem(key, value);
 };
const _M0FP45apple7moonseo3cmd3web24clear__persistent__value = function(key) {
   window.localStorage.removeItem(key);
 };
const _M0FP45apple7moonseo3cmd3web15get__data__attr = function(id, name) {
   const el = document.getElementById(id);
   return el && el.dataset ? String(el.dataset[name] || "") : "";
 };
const _M0FP45apple7moonseo3cmd3web15set__data__attr = function(id, name, value) {
   const el = document.getElementById(id);
   if (el && el.dataset) {
     el.dataset[name] = value;
   }
 };
const _M0FP45apple7moonseo3cmd3web14close__details = function(id) {
   const el = document.getElementById(id);
   if (el) {
     el.removeAttribute("open");
   }
 };
const _M0FP45apple7moonseo3cmd3web13open__details = function(id) {
   const el = document.getElementById(id);
   if (el) {
     el.setAttribute("open", "");
   }
 };
const _M0FP45apple7moonseo3cmd3web17is__details__open = function(id) {
   const el = document.getElementById(id);
   return !!(el && el.hasAttribute("open"));
 };
const _M0FP45apple7moonseo3cmd3web28set__cached__export__content = function(id, content) {
   const el = document.getElementById(id);
   if (el) {
     el.__moonseoExportContent = content;
   }
 };
const _M0FP45apple7moonseo3cmd3web31snapshot__export__article__html = function(previewId) {
   const preview = document.getElementById(previewId);
   if (!preview) {
     return "";
   }
   const article = preview.querySelector(".article-card");
   if (!article) {
     return "";
   }
   const articleClone = article.cloneNode(true);
   articleClone.querySelectorAll("[contenteditable]").forEach((node) => node.removeAttribute("contenteditable"));
   articleClone.querySelectorAll("[spellcheck]").forEach((node) => node.removeAttribute("spellcheck"));
   articleClone.querySelectorAll(".editable-field").forEach((node) => node.classList.remove("editable-field"));
   articleClone.querySelectorAll(".is-active").forEach((node) => node.classList.remove("is-active"));
   articleClone.querySelectorAll(".evidence-ref.active").forEach((node) => node.classList.remove("active"));
   return articleClone.outerHTML;
 };
const _M0FP45apple7moonseo3cmd3web17get__input__value = function(id) {
   const el = document.getElementById(id);
   return el && "value" in el ? el.value : "";
 };
const _M0FP45apple7moonseo3cmd3web17set__input__value = function(id, value) {
   const el = document.getElementById(id);
   if (el && "value" in el) {
     el.value = value;
   }
 };
const _M0FP45apple7moonseo3cmd3web9set__html = function(id, html) {
   const el = document.getElementById(id);
   if (el) {
     el.innerHTML = html;
   }
 };
const _M0FP45apple7moonseo3cmd3web9set__text = function(id, text) {
   const el = document.getElementById(id);
   if (el) {
     el.textContent = text;
   }
 };
const _M0FP45apple7moonseo3cmd3web27bind__evidence__ref__events = function(previewId, cb) {
   const preview = document.getElementById(previewId);
   if (!preview || preview.dataset.evidenceBound === "true") {
     return;
   }
   preview.dataset.evidenceBound = "true";
   preview.addEventListener("click", (event) => {
     const target = event.target instanceof Element ? event.target.closest(".evidence-ref") : null;
     if (!(target instanceof HTMLElement)) {
       return;
     }
     const title = target.getAttribute("data-evidence-label") || "";
     const body = target.getAttribute("data-evidence-text") || "";
     const source = target.getAttribute("data-evidence-source") || "";
     const sourceId = target.getAttribute("data-source-id") || "";
     const claimBlock = target.closest(".claim-block");
     const claimId = claimBlock instanceof HTMLElement ? claimBlock.dataset.claimId || "" : "";
     cb(`${claimId}\u001F${sourceId}\u001F${title}\u001F${body}\u001F${source}`);
   });
 };
const _M0FP45apple7moonseo3cmd3web29render__evidence__detail__dom = function(previewId, detailId, cardId) {
   void previewId;
   void detailId;
   void cardId;
 };
const _M0FP45apple7moonseo3cmd3web27show__evidence__detail__dom = function(previewId, cardId) {
   const preview = document.getElementById(previewId);
   const card = document.getElementById(cardId);
   if (!preview || !card) {
     return;
   }
   preview.querySelectorAll(".evidence-ref").forEach((ref) => ref.classList.remove("active"));
   preview.querySelectorAll(".claim-block.is-active").forEach((node) => node.classList.remove("is-active"));
   card.classList.add("expanded");
   card.classList.remove("flash");
   void card.offsetWidth;
   card.classList.add("flash");
   card.scrollIntoView({ behavior: "smooth", block: "center" });
 };
const _M0FP45apple7moonseo3cmd3web27hide__evidence__detail__dom = function(cardId) {
   const card = document.getElementById(cardId);
   if (!(card instanceof HTMLElement)) {
     return;
   }
   card.classList.remove("expanded");
 };
const _M0FP45apple7moonseo3cmd3web28activate__evidence__ref__dom = function(previewId, sourceId) {
   const preview = document.getElementById(previewId);
   if (!preview || !sourceId) {
     return;
   }
   const ref = preview.querySelector(`.evidence-ref[data-source-id="${sourceId}"]`);
   if (ref instanceof HTMLElement) {
     ref.classList.add("active");
     const claimBlock = ref.closest(".claim-block");
     if (claimBlock instanceof HTMLElement) {
       claimBlock.classList.add("is-active");
       claimBlock.scrollIntoView({ behavior: "smooth", block: "center" });
     } else {
       ref.scrollIntoView({ behavior: "smooth", block: "center" });
     }
   }
 };
const _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom = function(previewId, payload, lang) {
   const preview = document.getElementById(previewId);
   if (!preview) {
     return;
   }
   preview.querySelectorAll(".claim-inline-evidence").forEach((node) => node.remove());
   if (typeof payload !== "string" || payload.trim() === "") {
     return;
   }
   const lastBlocks = new Map();
   preview.querySelectorAll(".claim-block[data-claim-id]").forEach((node) => {
     if (node instanceof HTMLElement) {
       lastBlocks.set(node.dataset.claimId || "", node);
     }
   });
   const labelPrefix = lang === "zh" ? "正文证据标记" : "Body evidence marker";
   const sourceHint =
     lang === "zh"
       ? "用于标记正文对应的来源摘录"
       : "Marks the source excerpt used beside the body";
   payload.split("\u001E").forEach((record) => {
     const current = String(record || "").trim();
     if (!current) {
       return;
     }
     const fields = current.split("\u001F").map((field) => String(field || "").trim());
     const claimId = fields[0] || "";
     const sourceIds =
       (fields[3] || "")
         .split(",")
         .map((part) => String(part || "").trim())
         .filter(Boolean);
     if (!claimId || sourceIds.length === 0) {
       return;
     }
     const block = lastBlocks.get(claimId);
     if (!(block instanceof HTMLElement)) {
       return;
     }
     const shell = document.createElement("span");
     shell.className = "claim-inline-evidence";
     sourceIds.forEach((sourceId, index) => {
       if (index > 0) {
         shell.appendChild(document.createTextNode(" "));
       }
       const button = document.createElement("button");
       button.type = "button";
       button.className = "evidence-ref";
       button.dataset.evidenceLabel = `${labelPrefix} [S${sourceId}]`;
       button.dataset.evidenceText = "";
       button.dataset.sourceId = sourceId;
       button.dataset.evidenceSource = sourceHint;
       button.textContent = `[S${sourceId}]`;
       shell.appendChild(button);
     });
     block.appendChild(document.createTextNode(" "));
     block.appendChild(shell);
   });
 };
const _M0FP45apple7moonseo3cmd3web30snapshot__preview__plain__text = function(previewId) {
   const preview = document.getElementById(previewId);
   if (!preview) {
     return "";
   }
   const article = preview.querySelector(".article-card");
   return article instanceof HTMLElement ? article.innerText || "" : "";
 };
const _M0FP45apple7moonseo3cmd3web24snapshot__claim__payload = function(previewId) {
   const preview = document.getElementById(previewId);
   if (!preview) {
     return "";
   }
   const blocks = Array.from(preview.querySelectorAll(".claim-block[data-claim-id]"));
   const order = [];
   const grouped = new Map();
   blocks.forEach((block) => {
     if (!(block instanceof HTMLElement)) {
       return;
     }
     const claimId = block.dataset.claimId || "";
     const claimCopy = block.querySelector(".claim-copy");
     const text = claimCopy instanceof HTMLElement ? (claimCopy.innerText || "").trim() : "";
     if (!claimId || !text) {
       return;
     }
     if (!grouped.has(claimId)) {
       order.push(claimId);
       grouped.set(claimId, []);
     }
     grouped.get(claimId).push(text);
   });
   return order.map((claimId) => {
     const parts = grouped.get(claimId) || [];
     const claimText = parts.join("\n\n").trim();
     return claimText ? `${claimId}\u001F${claimText}` : "";
   }).filter(Boolean).join("\u001E");
 };
const _M0FP45apple7moonseo3cmd3web27bind__preview__edit__events = function(previewId, cb) {
   const preview = document.getElementById(previewId);
   if (!preview || preview.dataset.editBound === "true") {
     return;
   }
   preview.dataset.editBound = "true";
   preview.addEventListener("input", (event) => {
     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
     if (target instanceof HTMLElement) {
       cb();
     }
   });
   preview.addEventListener("blur", (event) => {
     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
     if (target instanceof HTMLElement) {
       cb();
     }
   }, true);
 };
const _M0FP45apple7moonseo3cmd3web29bind__summary__button__events = function(scopeId, cb) {
   const scope = document.getElementById(scopeId);
   if (!scope || scope.dataset.summaryBound === "true") {
     return;
   }
   scope.dataset.summaryBound = "true";
   scope.addEventListener("click", (event) => {
     const target = event.target instanceof Element ? event.target.closest(".audit-summary-button") : null;
     if (target instanceof HTMLElement) {
       cb(target.dataset.auditTarget || "");
     }
   });
 };
const _M0FP45apple7moonseo3cmd3web27bind__claim__review__events = function(auditId, onSelect, onApply, onRetry) {
   const audit = document.getElementById(auditId);
   if (!audit || audit.dataset.claimBound === "true") {
     return;
   }
   audit.dataset.claimBound = "true";
   audit.addEventListener("click", (event) => {
     const target = event.target instanceof Element ? event.target : null;
     if (!target) {
       return;
     }
     const retryButton = target.closest(".claim-review-retry");
     if (retryButton instanceof HTMLElement) {
       onRetry();
       return;
     }
     const applyButton = target.closest(".claim-apply");
     if (applyButton instanceof HTMLElement) {
       const claimId = applyButton.dataset.claimId || "";
       const rewrite = applyButton.dataset.claimRewrite || "";
       onApply(`${claimId}\u001F${rewrite}`);
       return;
     }
     const link = target.closest(".claim-link");
     if (link instanceof HTMLElement) {
       onSelect(link.dataset.claimId || "");
     }
   });
 };
const _M0FP45apple7moonseo3cmd3web23clear__claim__selection = function(previewId, auditId) {
   const preview = document.getElementById(previewId);
   const audit = document.getElementById(auditId);
   if (preview) {
     preview.querySelectorAll(".claim-block.is-active").forEach((node) => node.classList.remove("is-active"));
   }
   if (audit) {
     audit.querySelectorAll(".claim-card.is-active").forEach((node) => node.classList.remove("is-active"));
   }
 };
const _M0FP45apple7moonseo3cmd3web18select__claim__dom = function(previewId, auditId, claimId) {
   const preview = document.getElementById(previewId);
   const audit = document.getElementById(auditId);
   if (!preview || !audit || !claimId) {
     return;
   }
   const claimNode = preview.querySelector(`.claim-block[data-claim-id="${claimId}"]`);
   const card = audit.querySelector(`.claim-card[data-claim-id="${claimId}"]`);
   if (claimNode instanceof HTMLElement) {
     claimNode.classList.add("is-active");
     claimNode.scrollIntoView({ behavior: "smooth", block: "center" });
   }
   if (card instanceof HTMLElement) {
     card.classList.add("is-active");
   }
 };
const _M0FP45apple7moonseo3cmd3web27toggle__audit__section__dom = function(targetId) {
   if (!targetId) {
     return;
   }
   const target = document.getElementById(targetId);
   if (!(target instanceof HTMLElement)) {
     return;
   }
   const willExpand = !target.classList.contains("is-expanded");
   document.querySelectorAll(".audit-section-shell").forEach((section) => {
     if (section instanceof HTMLElement) {
       section.classList.remove("is-expanded");
     }
   });
   document.querySelectorAll(".audit-summary-button[data-audit-target]").forEach((button) => {
     if (button instanceof HTMLElement) {
       const active = button.getAttribute("data-audit-target") === targetId && willExpand;
       button.classList.toggle("is-active", active);
       button.setAttribute("aria-pressed", active ? "true" : "false");
     }
   });
   if (willExpand) {
     target.classList.add("is-expanded");
     target.scrollIntoView({ behavior: "smooth", block: "start" });
   }
 };
const _M0FP45apple7moonseo3cmd3web25show__audit__section__dom = function(targetId) {
   if (!targetId) {
     return;
   }
   const target = document.getElementById(targetId);
   if (!(target instanceof HTMLElement)) {
     return;
   }
   document.querySelectorAll(".audit-section-shell").forEach((section) => {
     if (section instanceof HTMLElement) {
       section.classList.toggle("is-expanded", section === target);
     }
   });
   document.querySelectorAll(".audit-summary-button[data-audit-target]").forEach((button) => {
     if (button instanceof HTMLElement) {
       const active = button.getAttribute("data-audit-target") === targetId;
       button.classList.toggle("is-active", active);
       button.setAttribute("aria-pressed", active ? "true" : "false");
     }
   });
   target.scrollIntoView({ behavior: "smooth", block: "start" });
 };
const _M0FP45apple7moonseo3cmd3web26apply__claim__rewrite__dom = function(previewId, auditId, claimId, rewrite) {
   const preview = document.getElementById(previewId);
   const audit = document.getElementById(auditId);
   if (!preview || !audit || !claimId || !rewrite) {
     return;
   }
   const claimNode = preview.querySelector(`.claim-block[data-claim-id="${claimId}"] .claim-copy`);
   if (claimNode instanceof HTMLElement) {
     claimNode.textContent = rewrite;
   }
   const card = audit.querySelector(`.claim-card[data-claim-id="${claimId}"]`);
   const note = card && card.querySelector(".claim-apply-note");
   if (note instanceof HTMLElement) {
     note.hidden = false;
   }
   if (card instanceof HTMLElement) {
     card.classList.remove("warn");
     card.classList.add("stale");
     const status = card.querySelector(".claim-status");
     if (status instanceof HTMLElement) {
       status.textContent = card.dataset.staleStatus || "Re-review needed";
     }
   }
 };
const _M0FP45apple7moonseo3cmd3web9set__attr = function(id, name, value) {
   const el = document.getElementById(id);
   if (el) {
     el.setAttribute(name, value);
   }
 };
const _M0FP45apple7moonseo3cmd3web13set__disabled = function(id, disabled) {
   const el = document.getElementById(id);
   if (el && "disabled" in el) {
     el.disabled = disabled;
   }
 };
const _M0FP45apple7moonseo3cmd3web19set__status__banner = function(id, tone, message, hidden) {
   const el = document.getElementById(id);
   if (!el) {
     return;
   }
   if (hidden) {
     el.hidden = true;
     el.textContent = "";
     el.removeAttribute("data-tone");
     return;
   }
   el.hidden = false;
   el.textContent = message;
   el.setAttribute("data-tone", tone);
 };
const _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events = function(id, cb) {
   const el = document.getElementById(id);
   if (!el || !("value" in el) || el.dataset.persistBound === "true") {
     return;
   }
   el.dataset.persistBound = "true";
   const save = () => cb(String(el.value || ""));
   el.addEventListener("input", save);
   el.addEventListener("change", save);
 };
const _M0FP45apple7moonseo3cmd3web20add__click__listener = function(id, cb) {
   const el = document.getElementById(id);
   if (el) {
     el.addEventListener("click", cb);
   }
 };
const _M0FP45apple7moonseo3cmd3web25expose__generate__handler = function(cb) {
   window.__moonseoGenerate = cb;
 };
const _M0FP45apple7moonseo3cmd3web14trigger__click = function(id) {
   const el = document.getElementById(id);
   if (el) {
     el.click();
   }
 };
const _M0FP45apple7moonseo3cmd3web19bind__menu__trigger = function(triggerId, cb) {
   const trigger = document.getElementById(triggerId);
   if (!trigger || trigger.dataset.menuTriggerBound === "true") {
     return;
   }
   trigger.dataset.menuTriggerBound = "true";
   trigger.addEventListener("click", (event) => {
     event.preventDefault();
     event.stopPropagation();
     cb();
   });
 };
const _M0FP45apple7moonseo3cmd3web20bind__click__stopper = function(id) {
   const el = document.getElementById(id);
   if (!el || el.dataset.clickStopBound === "true") {
     return;
   }
   el.dataset.clickStopBound = "true";
   el.addEventListener("click", (event) => {
     event.stopPropagation();
   });
 };
const _M0FP45apple7moonseo3cmd3web21bind__document__click = function(cb) {
   if (document.body.dataset.docClickBound === "true") {
     return;
   }
   document.body.dataset.docClickBound = "true";
   document.addEventListener("click", () => {
     cb();
   });
 };
const _M0FP45apple7moonseo3cmd3web27bind__source__upload__input = function(inputId, cb) {
   const input = document.getElementById(inputId);
   if (!input || input.dataset.uploadBound === "true") {
     return;
   }
   input.dataset.uploadBound = "true";
   input.addEventListener("change", async () => {
     const files = Array.from(input.files || []);
     if (!files.length) {
       cb("");
       return;
     }
     const records = [];
     const parseTxtLike = async (file) => {
       try {
         const text = await file.text();
         return ["parsed", file.name, String(text || "")].join("\u001F");
       } catch (error) {
         return ["failed", file.name, error instanceof Error ? error.message : "Text parsing failed."].join("\u001F");
       }
     };
     const parseDocx = async (file) => {
       if (!window.mammoth || typeof window.mammoth.extractRawText !== "function") {
         return ["failed", file.name, "DOCX parser is unavailable in this browser."].join("\u001F");
       }
       try {
         const result = await window.mammoth.extractRawText({
           arrayBuffer: await file.arrayBuffer(),
         });
         const text = String((result && result.value) || "").trim();
         if (!text) {
           return ["failed", file.name, "No usable DOCX text could be extracted."].join("\u001F");
         }
         return ["parsed", file.name, text].join("\u001F");
       } catch (error) {
         return ["failed", file.name, error instanceof Error ? error.message : "DOCX parsing failed."].join("\u001F");
       }
     };
     const parsePdf = async (file) => {
       if (!window.pdfjsLib || typeof window.pdfjsLib.getDocument !== "function") {
         return ["failed", file.name, "PDF parser is unavailable in this browser."].join("\u001F");
       }
       try {
         const bytes = new Uint8Array(await file.arrayBuffer());
         const pdf = await window.pdfjsLib.getDocument({ data: bytes }).promise;
         const pages = [];
         for (let pageIndex = 1; pageIndex <= pdf.numPages; pageIndex += 1) {
           const page = await pdf.getPage(pageIndex);
           const content = await page.getTextContent();
           const lines = (content.items || [])
             .map((item) => (item && typeof item.str === "string" ? item.str : ""))
             .filter(Boolean);
           if (lines.length) {
             pages.push(lines.join(" "));
           }
         }
         const text = pages.join("\n").trim();
         if (!text) {
           return ["failed", file.name, "No usable PDF text could be extracted."].join("\u001F");
         }
         return ["parsed", file.name, text].join("\u001F");
       } catch (error) {
         return ["failed", file.name, error instanceof Error ? error.message : "PDF parsing failed."].join("\u001F");
       }
     };
     for (const file of files) {
       const ext = (file.name.split(".").pop() || "").toLowerCase();
       if (ext === "txt" || ext === "md") {
         records.push(await parseTxtLike(file));
       } else if (ext === "docx") {
         records.push(await parseDocx(file));
       } else if (ext === "pdf") {
         records.push(await parsePdf(file));
       } else if (ext === "doc") {
         records.push(["attached", file.name, "Legacy .doc files are uploaded but not parsed in the browser prototype yet."].join("\u001F"));
       } else {
         records.push(["attached", file.name, "This file type is attached but not parsed yet."].join("\u001F"));
       }
     }
     input.value = "";
     cb(records.join("\u001E"));
   });
 };
const _M0FP45apple7moonseo3cmd3web29render__upload__source__chips = function(listId, payload) {
   const list = document.getElementById(listId);
   if (!list) {
     return;
   }
   list.querySelectorAll('[data-source-kind="upload"]').forEach((node) => node.remove());
   if (!payload) {
     return;
   }
   let index = 0;
   for (const record of String(payload).split("\u001E")) {
     if (!record.trim()) continue;
     const recordIndex = String(index++);
     const [kind, label, name, detail] = record.split("\u001F");
     const chip = document.createElement("div");
     chip.className = "source-chip";
     chip.dataset.sourceKind = "upload";
     chip.dataset.uploadState = kind || "attached";
     chip.dataset.recordIndex = recordIndex;
     chip.innerHTML = "<strong></strong><span></span><button type=\"button\" class=\"source-chip-remove\" aria-label=\"Remove source\" title=\"Remove source\">×</button>";
     const strong = chip.querySelector("strong");
     const span = chip.querySelector("span");
     if (strong) strong.textContent = label || "";
     if (span) span.textContent = name || "";
     if (detail) chip.title = detail;
     list.appendChild(chip);
   }
 };
const _M0FP45apple7moonseo3cmd3web34bind__source__chip__remove__events = function(listId, cb) {
   const list = document.getElementById(listId);
   if (!list || list.dataset.removeBound === "true") {
     return;
   }
   list.dataset.removeBound = "true";
   list.addEventListener("click", (event) => {
     const target = event.target instanceof Element ? event.target.closest(".source-chip-remove") : null;
     if (!(target instanceof HTMLElement)) {
       return;
     }
     event.preventDefault();
     event.stopPropagation();
     const chip = target.closest(".source-chip[data-source-kind=\"upload\"]");
     if (!(chip instanceof HTMLElement)) {
       return;
     }
     cb(chip.dataset.recordIndex || "");
   });
 };
const _M0FP45apple7moonseo3cmd3web29bind__debounced__input__value = function(id, delayMs, cb) {
   const el = document.getElementById(id);
   if (!el || !("value" in el) || el.dataset.debounceBound === "true") {
     return;
   }
   el.dataset.debounceBound = "true";
   let timer = 0;
   const schedule = () => {
     clearTimeout(timer);
     timer = window.setTimeout(() => {
       cb(String(el.value || "").trim());
     }, Number(delayMs) || 0);
   };
   el.addEventListener("input", schedule);
   el.addEventListener("change", schedule);
   if (String(el.value || "").trim() !== "") {
     schedule();
   }
 };
const _M0FP45apple7moonseo3cmd3web22request__website__text = async function(url, onSuccess, onError) {
   try {
     const response = await fetch("/api/fetch-website", {
       method: "POST",
       headers: {
         "Content-Type": "application/json",
       },
       body: JSON.stringify({ url }),
     });
     const data = await response.json();
     if (!response.ok) {
       const message =
         data && typeof data.error === "string"
           ? data.error
           : `Request failed with status ${response.status}`;
       onError(message);
       return;
     }
     onSuccess(String((data && data.text) || "").trim());
   } catch (error) {
     onError(error instanceof Error ? error.message : "Unknown website fetch error");
   }
 };
const _M0FP45apple7moonseo3cmd3web29render__website__source__chip = function(listId, label, text) {
   const list = document.getElementById(listId);
   if (!list) {
     return;
   }
   let chip = document.getElementById("website-source-chip");
   if (!chip) {
     chip = document.createElement("div");
     chip.id = "website-source-chip";
     chip.className = "source-chip";
     chip.dataset.sourceKind = "website";
     chip.innerHTML = "<strong></strong><span></span>";
     list.appendChild(chip);
   }
   const strong = chip.querySelector("strong");
   const span = chip.querySelector("span");
   if (strong) strong.textContent = label;
   if (span) span.textContent = text;
 };
const _M0FP45apple7moonseo3cmd3web28clear__website__source__chip = function(_listId) {
   const chip = document.getElementById("website-source-chip");
   if (chip) {
     chip.remove();
   }
 };
const _M0FP45apple7moonseo3cmd3web20request__ai__payload = async function(endpoint, prompt, onSuccess, onError) {
   try {
     const response = await fetch(endpoint, {
       method: "POST",
       headers: {
         "Content-Type": "application/json",
       },
       body: JSON.stringify({ prompt }),
     });
     const data = await response.json();
     if (!response.ok) {
       const message =
         data && typeof data.error === "string"
           ? data.error
           : data && data.error && data.error.message
             ? data.error.message
             : `Request failed with status ${response.status}`;
       onError(message);
       return;
     }
     const payload = String((data && data.payload) || "").trim();
     if (!payload) {
       onError("The local draft service returned an empty payload.");
       return;
     }
     onSuccess(payload);
   } catch (error) {
     onError(error instanceof Error ? error.message : "Unknown request error");
   }
 };
const _M0FP45apple7moonseo3cmd3web29request__ai__payload__batches = async function(endpoint, promptsPayload, onSuccess, onError) {
   const prompts = String(promptsPayload || "")
     .split("\u001D")
     .map((part) => String(part || "").trim())
     .filter(Boolean);
   if (prompts.length === 0) {
     onError("No claim-review batches were prepared.");
     return;
   }
   const payloads = [];
   for (const prompt of prompts) {
     try {
       const response = await fetch(endpoint, {
         method: "POST",
         headers: {
           "Content-Type": "application/json",
         },
         body: JSON.stringify({ prompt }),
       });
       const data = await response.json();
       if (!response.ok) {
         const message =
           data && typeof data.error === "string"
             ? data.error
             : data && data.error && data.error.message
               ? data.error.message
               : `Request failed with status ${response.status}`;
         onError(message);
         return;
       }
       const payload = String((data && data.payload) || "").trim();
       if (!payload) {
         onError("The local draft service returned an empty payload.");
         return;
       }
       payloads.push(payload);
     } catch (error) {
       onError(error instanceof Error ? error.message : "Unknown request error");
       return;
     }
   }
   onSuccess(payloads.join("\u001E"));
 };
const _M0FP45apple7moonseo3cmd3web19cache__export__file = function(id, filename, content, title, metaDescription, slug, lang) {
   const el = document.getElementById(id);
   if (el) {
     el.__moonseoExportFilename = filename;
     el.__moonseoExportContent = content;
     el.dataset.exportTitle = title;
     el.dataset.exportMeta = metaDescription;
     el.dataset.exportSlug = slug;
     el.dataset.exportLang = lang;
   }
 };
const _M0FP45apple7moonseo3cmd3web22download__cached__file = function(id) {
   const el = document.getElementById(id);
   const filename =
     el && typeof el.__moonseoExportFilename === "string"
       ? el.__moonseoExportFilename
       : "moonseo-draft.html";
   const content =
     el && typeof el.__moonseoExportContent === "string"
       ? el.__moonseoExportContent
       : "";
   const blob = new Blob([content], { type: "text/html;charset=utf-8" });
   const url = URL.createObjectURL(blob);
   const a = document.createElement("a");
   a.href = url;
   a.download = filename;
   document.body.appendChild(a);
   a.click();
   a.remove();
   URL.revokeObjectURL(url);
 };
const _M0FP45apple7moonseo3cmd3web16set__lang__state = function(lang) {
   document.body.dataset.lang = lang;
   const buttons = document.querySelectorAll("[data-lang-switch]");
   buttons.forEach((button) => {
     const active = button.getAttribute("data-lang-switch") === lang;
     button.classList.toggle("active", active);
   });
 };
const _M0FP45apple7moonseo3cmd3web16get__lang__state = function() {
   return document.body.dataset.lang || "en";
 };
const _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger = { method_0: _M0IPB13StringBuilderPB6Logger13write__string, method_1: _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE, method_2: _M0IPB13StringBuilderPB6Logger11write__view, method_3: _M0IPB13StringBuilderPB6Logger11write__char };
const _M0MPC16string10StringView4trimN7_2abindS5731 = "\t\n\r ";
const _M0MPC16string6String4trimN7_2abindS5737 = "\t\n\r ";
const _M0FPB33brute__force__find_2econstr_2f239 = 0;
const _M0FPB43boyer__moore__horspool__find_2econstr_2f225 = 0;
function _M0FPC15abort5abortGRPC16string10StringViewE(msg) {
  return $panic();
}
function _M0FPC15abort5abortGuE(msg) {
  $panic();
}
function _M0FPC15abort5abortGOiE(msg) {
  return $panic();
}
function _M0FPB5abortGRPC16string10StringViewE(string, loc) {
  return _M0FPC15abort5abortGRPC16string10StringViewE(`${_M0IPC16string6StringPB4Show10to__string(string)}\n  at ${_M0IP016_24default__implPB4Show10to__stringGRPB9SourceLocE(loc)}\n`);
}
function _M0FPB5abortGuE(string, loc) {
  _M0FPC15abort5abortGuE(`${_M0IPC16string6StringPB4Show10to__string(string)}\n  at ${_M0IP016_24default__implPB4Show10to__stringGRPB9SourceLocE(loc)}\n`);
}
function _M0FPB5abortGOiE(string, loc) {
  return _M0FPC15abort5abortGOiE(`${_M0IPC16string6StringPB4Show10to__string(string)}\n  at ${_M0IP016_24default__implPB4Show10to__stringGRPB9SourceLocE(loc)}\n`);
}
function _M0MPB13StringBuilder11new_2einner(size_hint) {
  return new _M0TPB13StringBuilder("");
}
function _M0MPB13StringBuilder10to__string(self) {
  return self.val;
}
function _M0IPB13StringBuilderPB6Logger11write__char(self, ch) {
  self.val = `${self.val}${String.fromCodePoint(ch)}`;
}
function _M0MPC16uint166UInt1622is__leading__surrogate(self) {
  return _M0IP016_24default__implPB7Compare6op__geGkE(self, 55296) && _M0IP016_24default__implPB7Compare6op__leGkE(self, 56319);
}
function _M0MPC16uint166UInt1623is__trailing__surrogate(self) {
  return _M0IP016_24default__implPB7Compare6op__geGkE(self, 56320) && _M0IP016_24default__implPB7Compare6op__leGkE(self, 57343);
}
function _M0FPB32code__point__of__surrogate__pair(leading, trailing) {
  return (((Math.imul(leading - 55296 | 0, 1024) | 0) + trailing | 0) - 56320 | 0) + 65536 | 0;
}
function _M0MPC16uint166UInt1616unsafe__to__char(self) {
  return self;
}
function _M0MPC16string6String16unsafe__char__at(self, index) {
  const c1 = self.charCodeAt(index);
  if (_M0MPC16uint166UInt1622is__leading__surrogate(c1)) {
    const c2 = self.charCodeAt(index + 1 | 0);
    return _M0FPB32code__point__of__surrogate__pair(c1, c2);
  } else {
    return _M0MPC16uint166UInt1616unsafe__to__char(c1);
  }
}
function _M0MPC15array5Array2atGsE(self, index) {
  const len = self.length;
  if (index >= 0 && index < len) {
    $bound_check(self, index);
    return self[index];
  } else {
    return $panic();
  }
}
function _M0MPB13SourceLocRepr5parse(repr) {
  const _bind = new _M0TPC16string10StringView(repr, 0, repr.length);
  const _data = _M0MPC16string10StringView4data(_bind);
  const _start = _M0MPC16string10StringView13start__offset(_bind);
  const _end = _start + _M0MPC16string10StringView6length(_bind) | 0;
  let _cursor = _start;
  let accept_state = -1;
  let match_end = -1;
  let match_tag_saver_0 = -1;
  let match_tag_saver_1 = -1;
  let match_tag_saver_2 = -1;
  let match_tag_saver_3 = -1;
  let match_tag_saver_4 = -1;
  let tag_0 = -1;
  let tag_1 = -1;
  let tag_1_1 = -1;
  let tag_1_2 = -1;
  let tag_3 = -1;
  let tag_2 = -1;
  let tag_2_1 = -1;
  let tag_4 = -1;
  _L: {
    if (_cursor < _end) {
      if (_M0MPC16string6String20unsafe__charcode__at(_data, _cursor) === 64) {
        _cursor = _cursor + 1 | 0;
        _L$2: while (true) {
          tag_0 = _cursor;
          if (_cursor < _end) {
            const next_char = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
            _cursor = _cursor + 1 | 0;
            if (next_char === 58) {
              if (_cursor < _end) {
                _cursor = _cursor + 1 | 0;
                let _tmp = 0;
                _L$3: while (true) {
                  const dispatch_15 = _tmp;
                  _L$4: {
                    _L$5: {
                      switch (dispatch_15) {
                        case 3: {
                          tag_1_2 = tag_1_1;
                          tag_1_1 = tag_1;
                          tag_1 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 58) {
                                if (next_char$2 < 48) {
                                  break _L$6;
                                } else {
                                  tag_1 = _cursor;
                                  tag_2_1 = tag_2;
                                  tag_2 = _cursor;
                                  tag_3 = _cursor;
                                  if (_cursor < _end) {
                                    _L$7: {
                                      const next_char$3 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                                      _cursor = _cursor + 1 | 0;
                                      if (next_char$3 < 48) {
                                        if (next_char$3 === 45) {
                                          break _L$4;
                                        } else {
                                          break _L$7;
                                        }
                                      } else {
                                        if (next_char$3 > 57) {
                                          if (next_char$3 < 59) {
                                            _tmp = 3;
                                            continue _L$3;
                                          } else {
                                            break _L$7;
                                          }
                                        } else {
                                          _tmp = 6;
                                          continue _L$3;
                                        }
                                      }
                                    }
                                    _tmp = 0;
                                    continue _L$3;
                                  } else {
                                    break _L;
                                  }
                                }
                              } else {
                                if (next_char$2 > 58) {
                                  break _L$6;
                                } else {
                                  _tmp = 1;
                                  continue _L$3;
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L;
                          }
                        }
                        case 2: {
                          tag_1 = _cursor;
                          tag_2 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 58) {
                                if (next_char$2 < 48) {
                                  break _L$6;
                                } else {
                                  _tmp = 2;
                                  continue _L$3;
                                }
                              } else {
                                if (next_char$2 > 58) {
                                  break _L$6;
                                } else {
                                  _tmp = 3;
                                  continue _L$3;
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L;
                          }
                        }
                        case 0: {
                          tag_1 = _cursor;
                          if (_cursor < _end) {
                            const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                            _cursor = _cursor + 1 | 0;
                            if (next_char$2 === 58) {
                              _tmp = 1;
                              continue _L$3;
                            } else {
                              _tmp = 0;
                              continue _L$3;
                            }
                          } else {
                            break _L;
                          }
                        }
                        case 4: {
                          tag_1 = _cursor;
                          tag_4 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 58) {
                                if (next_char$2 < 48) {
                                  break _L$6;
                                } else {
                                  _tmp = 4;
                                  continue _L$3;
                                }
                              } else {
                                if (next_char$2 > 58) {
                                  break _L$6;
                                } else {
                                  tag_1_2 = tag_1_1;
                                  tag_1_1 = tag_1;
                                  tag_1 = _cursor;
                                  if (_cursor < _end) {
                                    _L$7: {
                                      const next_char$3 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                                      _cursor = _cursor + 1 | 0;
                                      if (next_char$3 < 58) {
                                        if (next_char$3 < 48) {
                                          break _L$7;
                                        } else {
                                          tag_1 = _cursor;
                                          tag_2_1 = tag_2;
                                          tag_2 = _cursor;
                                          if (_cursor < _end) {
                                            _L$8: {
                                              const next_char$4 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                                              _cursor = _cursor + 1 | 0;
                                              if (next_char$4 < 58) {
                                                if (next_char$4 < 48) {
                                                  break _L$8;
                                                } else {
                                                  _tmp = 5;
                                                  continue _L$3;
                                                }
                                              } else {
                                                if (next_char$4 > 58) {
                                                  break _L$8;
                                                } else {
                                                  _tmp = 3;
                                                  continue _L$3;
                                                }
                                              }
                                            }
                                            _tmp = 0;
                                            continue _L$3;
                                          } else {
                                            break _L$5;
                                          }
                                        }
                                      } else {
                                        if (next_char$3 > 58) {
                                          break _L$7;
                                        } else {
                                          _tmp = 1;
                                          continue _L$3;
                                        }
                                      }
                                    }
                                    _tmp = 0;
                                    continue _L$3;
                                  } else {
                                    break _L;
                                  }
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L;
                          }
                        }
                        case 5: {
                          tag_1 = _cursor;
                          tag_2 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 58) {
                                if (next_char$2 < 48) {
                                  break _L$6;
                                } else {
                                  _tmp = 5;
                                  continue _L$3;
                                }
                              } else {
                                if (next_char$2 > 58) {
                                  break _L$6;
                                } else {
                                  _tmp = 3;
                                  continue _L$3;
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L$5;
                          }
                        }
                        case 6: {
                          tag_1 = _cursor;
                          tag_2 = _cursor;
                          tag_3 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 48) {
                                if (next_char$2 === 45) {
                                  break _L$4;
                                } else {
                                  break _L$6;
                                }
                              } else {
                                if (next_char$2 > 57) {
                                  if (next_char$2 < 59) {
                                    _tmp = 3;
                                    continue _L$3;
                                  } else {
                                    break _L$6;
                                  }
                                } else {
                                  _tmp = 6;
                                  continue _L$3;
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L;
                          }
                        }
                        case 1: {
                          tag_1_1 = tag_1;
                          tag_1 = _cursor;
                          if (_cursor < _end) {
                            _L$6: {
                              const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                              _cursor = _cursor + 1 | 0;
                              if (next_char$2 < 58) {
                                if (next_char$2 < 48) {
                                  break _L$6;
                                } else {
                                  _tmp = 2;
                                  continue _L$3;
                                }
                              } else {
                                if (next_char$2 > 58) {
                                  break _L$6;
                                } else {
                                  _tmp = 1;
                                  continue _L$3;
                                }
                              }
                            }
                            _tmp = 0;
                            continue _L$3;
                          } else {
                            break _L;
                          }
                        }
                        default: {
                          break _L;
                        }
                      }
                    }
                    tag_1 = tag_1_2;
                    tag_2 = tag_2_1;
                    match_tag_saver_0 = tag_0;
                    match_tag_saver_1 = tag_1;
                    match_tag_saver_2 = tag_2;
                    match_tag_saver_3 = tag_3;
                    match_tag_saver_4 = tag_4;
                    accept_state = 0;
                    match_end = _cursor;
                    break _L;
                  }
                  tag_1_1 = tag_1_2;
                  tag_1 = _cursor;
                  tag_2 = tag_2_1;
                  if (_cursor < _end) {
                    _L$5: {
                      const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                      _cursor = _cursor + 1 | 0;
                      if (next_char$2 < 58) {
                        if (next_char$2 < 48) {
                          break _L$5;
                        } else {
                          _tmp = 4;
                          continue;
                        }
                      } else {
                        if (next_char$2 > 58) {
                          break _L$5;
                        } else {
                          _tmp = 1;
                          continue;
                        }
                      }
                    }
                    _tmp = 0;
                    continue;
                  } else {
                    break _L;
                  }
                }
              } else {
                break _L;
              }
            } else {
              continue;
            }
          } else {
            break _L;
          }
        }
      } else {
        break _L;
      }
    } else {
      break _L;
    }
  }
  if (accept_state === 0) {
    const start_line = _M0MPC16string6String4view(_data, match_tag_saver_1 + 1 | 0, match_tag_saver_2);
    const start_column = _M0MPC16string6String4view(_data, match_tag_saver_2 + 1 | 0, match_tag_saver_3);
    const pkg = _M0MPC16string6String4view(_data, _start + 1 | 0, match_tag_saver_0);
    const filename = _M0MPC16string6String4view(_data, match_tag_saver_0 + 1 | 0, match_tag_saver_1);
    const end_line = _M0MPC16string6String4view(_data, match_tag_saver_3 + 1 | 0, match_tag_saver_4);
    const end_column = _M0MPC16string6String4view(_data, match_tag_saver_4 + 1 | 0, match_end);
    return new _M0TPB13SourceLocRepr(pkg, filename, start_line, start_column, end_line, end_column);
  } else {
    return $panic();
  }
}
function _M0IPB13StringBuilderPB6Logger13write__string(self, str) {
  self.val = `${self.val}${str}`;
}
function _M0IPC16uint166UInt16PB2Eq10not__equal(self, that) {
  return self !== that;
}
function _M0IPC16uint166UInt16PB7Compare7compare(self, that) {
  return $compare_int(self, that);
}
function _M0IP016_24default__implPB2Eq10not__equalGsE(x, y) {
  return !(x === y);
}
function _M0IP016_24default__implPB7Compare6op__leGkE(x, y) {
  return _M0IPC16uint166UInt16PB7Compare7compare(x, y) <= 0;
}
function _M0IP016_24default__implPB7Compare6op__geGkE(x, y) {
  return _M0IPC16uint166UInt16PB7Compare7compare(x, y) >= 0;
}
function _M0MPC16string6String11sub_2einner(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end < 0 ? len + _end | 0 : _end;
  }
  const start$2 = start < 0 ? len + start | 0 : start;
  if (start$2 >= 0 && (start$2 <= end$2 && end$2 <= len)) {
    if (start$2 < len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.charCodeAt(start$2))) {
      } else {
        $panic();
      }
    }
    if (end$2 < len) {
      if (!_M0MPC16uint166UInt1623is__trailing__surrogate(self.charCodeAt(end$2))) {
      } else {
        $panic();
      }
    }
    return new _M0TPC16string10StringView(self, start$2, end$2);
  } else {
    return $panic();
  }
}
function _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(self, value, start, len) {
  _M0IPB13StringBuilderPB6Logger11write__view(self, _M0MPC16string6String11sub_2einner(value, start, start + len | 0));
}
function _M0MPC16string10StringView4data(self) {
  return self.str;
}
function _M0MPC16string10StringView6length(self) {
  return self.end - self.start | 0;
}
function _M0MPC16string10StringView13start__offset(self) {
  return self.start;
}
function _M0IP016_24default__implPB4Show10to__stringGiE(self) {
  const logger = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPC13int3IntPB4Show6output(self, { self: logger, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
  return _M0MPB13StringBuilder10to__string(logger);
}
function _M0IP016_24default__implPB4Show10to__stringGRPB9SourceLocE(self) {
  const logger = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB9SourceLocPB4Show6output(self, { self: logger, method_table: _M0FP092moonbitlang_2fcore_2fbuiltin_2fStringBuilder_24as_24_40moonbitlang_2fcore_2fbuiltin_2eLogger });
  return _M0MPB13StringBuilder10to__string(logger);
}
function _M0MPB4Iter4nextGRPC16string10StringViewE(self) {
  const _func = self;
  return _func();
}
function _M0MPB4Iter4nextGcE(self) {
  const _func = self;
  return _func();
}
function _M0MPC13int3Int18to__string_2einner(self, radix) {
  return _M0FPB19int__to__string__js(self, radix);
}
function _M0MPC16string10StringView11unsafe__get(self, index) {
  return self.str.charCodeAt(self.start + index | 0);
}
function _M0MPB4Iter3newGRPC16string10StringViewE(f) {
  return f;
}
function _M0MPB4Iter3newGcE(f) {
  return f;
}
function _M0MPC16string10StringView12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = _M0MPC16string10StringView6length(self);
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= _M0MPC16string10StringView6length(self)) ? new _M0TPC16string10StringView(self.str, self.start + start_offset | 0, self.start + end_offset$2 | 0) : _M0FPB5abortGRPC16string10StringViewE("Invalid index for View", "@moonbitlang/core/builtin:stringview.mbt:113:5-113:36");
}
function _M0IPC16string10StringViewPB4Show10to__string(self) {
  return self.str.substring(self.start, self.end);
}
function _M0MPC16string10StringView4iter(self) {
  const start = self.start;
  const end = self.end;
  const index = new _M0TPC13ref3RefGiE(start);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val < end) {
      const c1 = self.str.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index.val + 1 | 0) < self.end) {
        const c2 = self.str.charCodeAt(index.val + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          index.val = index.val + 2 | 0;
          return _M0FPB32code__point__of__surrogate__pair(c1, c2);
        }
      }
      index.val = index.val + 1 | 0;
      return _M0MPC16uint166UInt1616unsafe__to__char(c1);
    } else {
      return -1;
    }
  });
}
function _M0MPB5Iter23newGicE(f) {
  return _M0MPB4Iter3newGRPC16string10StringViewE(f);
}
function _M0MPC16string10StringView5iter2(self) {
  const start = self.start;
  const end = self.end;
  const index = new _M0TPC13ref3RefGiE(start);
  const char_index = new _M0TPC13ref3RefGiE(0);
  return _M0MPB5Iter23newGicE(() => {
    if (index.val < end) {
      const c1 = self.str.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index.val + 1 | 0) < self.end) {
        const c2 = self.str.charCodeAt(index.val + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          const result = { _0: char_index.val, _1: _M0FPB32code__point__of__surrogate__pair(c1, c2) };
          index.val = index.val + 2 | 0;
          char_index.val = char_index.val + 1 | 0;
          return result;
        }
      }
      const result = { _0: char_index.val, _1: _M0MPC16uint166UInt1616unsafe__to__char(c1) };
      index.val = index.val + 1 | 0;
      char_index.val = char_index.val + 1 | 0;
      return result;
    } else {
      return undefined;
    }
  });
}
function _M0MPC16string6String12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= self.length) ? new _M0TPC16string10StringView(self, start_offset, end_offset$2) : _M0FPB5abortGRPC16string10StringViewE("Invalid index for View", "@moonbitlang/core/builtin:stringview.mbt:399:5-399:36");
}
function _M0MPC16string6String4view(self, start_offset$46$opt, end_offset) {
  let start_offset;
  if (start_offset$46$opt === undefined) {
    start_offset = 0;
  } else {
    const _Some = start_offset$46$opt;
    start_offset = _Some;
  }
  return _M0MPC16string6String12view_2einner(self, start_offset, end_offset);
}
function _M0MPC16string6String24char__length__eq_2einner(self, len, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  let _tmp = start_offset;
  let _tmp$2 = 0;
  while (true) {
    const index = _tmp;
    const count = _tmp$2;
    if (index < end_offset$2 && count < len) {
      const c1 = self.charCodeAt(index);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index + 1 | 0) < end_offset$2) {
        const c2 = self.charCodeAt(index + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          _tmp = index + 2 | 0;
          _tmp$2 = count + 1 | 0;
          continue;
        } else {
          _M0FPB5abortGuE("invalid surrogate pair", "@moonbitlang/core/builtin:string.mbt:426:9-426:40");
        }
      }
      _tmp = index + 1 | 0;
      _tmp$2 = count + 1 | 0;
      continue;
    } else {
      return count === len && index === end_offset$2;
    }
  }
}
function _M0MPC16string6String31offset__of__nth__char__backward(self, n, start_offset, end_offset) {
  let char_count = 0;
  let utf16_offset = end_offset;
  while (true) {
    if ((utf16_offset - 1 | 0) >= start_offset && char_count < n) {
      const c = self.charCodeAt(utf16_offset - 1 | 0);
      if (_M0MPC16uint166UInt1623is__trailing__surrogate(c)) {
        utf16_offset = utf16_offset - 2 | 0;
      } else {
        utf16_offset = utf16_offset - 1 | 0;
      }
      char_count = char_count + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return char_count < n || utf16_offset < start_offset ? undefined : utf16_offset;
}
function _M0MPC16string6String30offset__of__nth__char__forward(self, n, start_offset, end_offset) {
  if (start_offset >= 0 && start_offset <= end_offset) {
    let utf16_offset = start_offset;
    let char_count = 0;
    while (true) {
      if (utf16_offset < end_offset && char_count < n) {
        const c = self.charCodeAt(utf16_offset);
        if (_M0MPC16uint166UInt1622is__leading__surrogate(c)) {
          utf16_offset = utf16_offset + 2 | 0;
        } else {
          utf16_offset = utf16_offset + 1 | 0;
        }
        char_count = char_count + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return char_count < n || utf16_offset >= end_offset ? undefined : utf16_offset;
  } else {
    return _M0FPB5abortGOiE("Invalid start index", "@moonbitlang/core/builtin:string.mbt:329:5-329:33");
  }
}
function _M0MPC16string6String29offset__of__nth__char_2einner(self, i, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return i >= 0 ? _M0MPC16string6String30offset__of__nth__char__forward(self, i, start_offset, end_offset$2) : _M0MPC16string6String31offset__of__nth__char__backward(self, -i | 0, start_offset, end_offset$2);
}
function _M0IPB13StringBuilderPB6Logger11write__view(self, str) {
  self.val = `${self.val}${_M0IPC16string10StringViewPB4Show10to__string(str)}`;
}
function _M0FPB28boyer__moore__horspool__find(haystack, needle) {
  const haystack_len = _M0MPC16string10StringView6length(haystack);
  const needle_len = _M0MPC16string10StringView6length(needle);
  if (needle_len > 0) {
    if (haystack_len >= needle_len) {
      const skip_table = $make_array_len_and_init(256, needle_len);
      const _bind = needle_len - 1 | 0;
      let _tmp = 0;
      while (true) {
        const i = _tmp;
        if (i < _bind) {
          const _tmp$2 = _M0MPC16string10StringView11unsafe__get(needle, i) & 255;
          $bound_check(skip_table, _tmp$2);
          skip_table[_tmp$2] = (needle_len - 1 | 0) - i | 0;
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      let _tmp$2 = 0;
      while (true) {
        const i = _tmp$2;
        if (i <= (haystack_len - needle_len | 0)) {
          const _bind$2 = needle_len - 1 | 0;
          let _tmp$3 = 0;
          while (true) {
            const j = _tmp$3;
            if (j <= _bind$2) {
              if (_M0IPC16uint166UInt16PB2Eq10not__equal(_M0MPC16string10StringView11unsafe__get(haystack, i + j | 0), _M0MPC16string10StringView11unsafe__get(needle, j))) {
                break;
              }
              _tmp$3 = j + 1 | 0;
              continue;
            } else {
              return i;
            }
          }
          const _tmp$4 = _M0MPC16string10StringView11unsafe__get(haystack, (i + needle_len | 0) - 1 | 0) & 255;
          $bound_check(skip_table, _tmp$4);
          _tmp$2 = i + skip_table[_tmp$4] | 0;
          continue;
        } else {
          break;
        }
      }
      return undefined;
    } else {
      return undefined;
    }
  } else {
    return _M0FPB43boyer__moore__horspool__find_2econstr_2f225;
  }
}
function _M0FPB18brute__force__find(haystack, needle) {
  const haystack_len = _M0MPC16string10StringView6length(haystack);
  const needle_len = _M0MPC16string10StringView6length(needle);
  if (needle_len > 0) {
    if (haystack_len >= needle_len) {
      const needle_first = _M0MPC16string10StringView11unsafe__get(needle, 0);
      const forward_len = haystack_len - needle_len | 0;
      let i = 0;
      while (true) {
        if (i <= forward_len) {
          while (true) {
            if (i <= forward_len && _M0IPC16uint166UInt16PB2Eq10not__equal(_M0MPC16string10StringView11unsafe__get(haystack, i), needle_first)) {
              i = i + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          if (i <= forward_len) {
            let _tmp = 1;
            while (true) {
              const j = _tmp;
              if (j < needle_len) {
                if (_M0IPC16uint166UInt16PB2Eq10not__equal(_M0MPC16string10StringView11unsafe__get(haystack, i + j | 0), _M0MPC16string10StringView11unsafe__get(needle, j))) {
                  break;
                }
                _tmp = j + 1 | 0;
                continue;
              } else {
                return i;
              }
            }
            i = i + 1 | 0;
          }
          continue;
        } else {
          break;
        }
      }
      return undefined;
    } else {
      return undefined;
    }
  } else {
    return _M0FPB33brute__force__find_2econstr_2f239;
  }
}
function _M0MPC16string10StringView4find(self, str) {
  return _M0MPC16string10StringView6length(str) <= 4 ? _M0FPB18brute__force__find(self, str) : _M0FPB28boyer__moore__horspool__find(self, str);
}
function _M0MPC16string6String4find(self, str) {
  return _M0MPC16string10StringView4find(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC16string10StringView8find__by(self, pred) {
  const _it = _M0MPC16string10StringView5iter2(self);
  while (true) {
    const _bind = _M0MPB5Iter24nextGicE(_it);
    if (_bind === undefined) {
      break;
    } else {
      const _Some = _bind;
      const _x = _Some;
      const _i = _x._0;
      const _c = _x._1;
      if (pred(_c)) {
        return _i;
      }
      continue;
    }
  }
  return undefined;
}
function _M0MPC16string6String8find__by(self, pred) {
  return _M0MPC16string10StringView8find__by(new _M0TPC16string10StringView(self, 0, self.length), pred);
}
function _M0MPC16string10StringView11has__prefix(self, str) {
  const _bind = _M0MPC16string10StringView4find(self, str);
  if (_bind === undefined) {
    return false;
  } else {
    const _Some = _bind;
    const _i = _Some;
    return _i === 0;
  }
}
function _M0MPC16string6String11has__prefix(self, str) {
  return _M0MPC16string10StringView11has__prefix(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC15array5Array4pushGsE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPC15array5Array4pushGRPB5ArrayGsEE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPC16string10StringView8contains(self, str) {
  const _bind = _M0MPC16string10StringView4find(self, str);
  return !(_bind === undefined);
}
function _M0MPC16string6String8contains(self, str) {
  return _M0MPC16string10StringView8contains(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC16string10StringView14contains__char(self, c) {
  const len = _M0MPC16string10StringView6length(self);
  if (len > 0) {
    const c$2 = c;
    if (c$2 <= 65535) {
      let _tmp = 0;
      while (true) {
        const i = _tmp;
        if (i < len) {
          if (_M0MPC16string10StringView11unsafe__get(self, i) === c$2) {
            return true;
          }
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    } else {
      if (len >= 2) {
        const adj = c$2 - 65536 | 0;
        const high = 55296 + (adj >> 10) | 0;
        const low = 56320 + (adj & 1023) | 0;
        let i = 0;
        while (true) {
          if (i < (len - 1 | 0)) {
            if (_M0MPC16string10StringView11unsafe__get(self, i) === high) {
              i = i + 1 | 0;
              if (_M0MPC16string10StringView11unsafe__get(self, i) === low) {
                return true;
              }
            }
            i = i + 1 | 0;
            continue;
          } else {
            break;
          }
        }
      } else {
        return false;
      }
    }
    return false;
  } else {
    return false;
  }
}
function _M0MPC16string10StringView19trim__start_2einner(self, chars) {
  let _tmp = self;
  while (true) {
    const _param = _tmp;
    if (_M0MPC16string6String24char__length__eq_2einner(_param.str, 0, _param.start, _param.end)) {
      return _param;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(_param.str, _M0MPC16string6String29offset__of__nth__char_2einner(_param.str, 0, _param.start, _param.end));
      const _tmp$2 = _param.str;
      const _bind = _M0MPC16string6String29offset__of__nth__char_2einner(_param.str, 1, _param.start, _param.end);
      let _tmp$3;
      if (_bind === undefined) {
        _tmp$3 = _param.end;
      } else {
        const _Some = _bind;
        _tmp$3 = _Some;
      }
      const _x = new _M0TPC16string10StringView(_tmp$2, _tmp$3, _param.end);
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return _param;
      }
    }
  }
}
function _M0MPC16string10StringView17trim__end_2einner(self, chars) {
  let _tmp = self;
  while (true) {
    const _param = _tmp;
    if (_M0MPC16string6String24char__length__eq_2einner(_param.str, 0, _param.start, _param.end)) {
      return _param;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(_param.str, _M0MPC16string6String29offset__of__nth__char_2einner(_param.str, -1, _param.start, _param.end));
      const _x = new _M0TPC16string10StringView(_param.str, _param.start, _M0MPC16string6String29offset__of__nth__char_2einner(_param.str, -1, _param.start, _param.end));
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return _param;
      }
    }
  }
}
function _M0MPC16string10StringView12trim_2einner(self, chars) {
  return _M0MPC16string10StringView17trim__end_2einner(_M0MPC16string10StringView19trim__start_2einner(self, chars), chars);
}
function _M0MPC16string10StringView4trim(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = new _M0TPC16string10StringView(_M0MPC16string10StringView4trimN7_2abindS5731, 0, _M0MPC16string10StringView4trimN7_2abindS5731.length);
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string10StringView12trim_2einner(self, chars);
}
function _M0MPC16string6String12trim_2einner(self, chars) {
  return _M0MPC16string10StringView12trim_2einner(new _M0TPC16string10StringView(self, 0, self.length), chars);
}
function _M0MPC16string6String4trim(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = new _M0TPC16string10StringView(_M0MPC16string6String4trimN7_2abindS5737, 0, _M0MPC16string6String4trimN7_2abindS5737.length);
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string6String12trim_2einner(self, chars);
}
function _M0MPC16string6String4iter(self) {
  const len = self.length;
  const index = new _M0TPC13ref3RefGiE(0);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val < len) {
      const c1 = self.charCodeAt(index.val);
      if (_M0MPC16uint166UInt1622is__leading__surrogate(c1) && (index.val + 1 | 0) < len) {
        const c2 = self.charCodeAt(index.val + 1 | 0);
        if (_M0MPC16uint166UInt1623is__trailing__surrogate(c2)) {
          const c = _M0FPB32code__point__of__surrogate__pair(c1, c2);
          index.val = index.val + 2 | 0;
          return c;
        }
      }
      index.val = index.val + 1 | 0;
      return _M0MPC16uint166UInt1616unsafe__to__char(c1);
    } else {
      return -1;
    }
  });
}
function _M0MPB4Iter3mapGcRPC16string10StringViewE(self, f) {
  return () => {
    const _bind = _M0MPB4Iter4nextGcE(self);
    if (_bind === -1) {
      return undefined;
    } else {
      const _Some = _bind;
      const _x = _Some;
      return f(_x);
    }
  };
}
function _M0IPC14char4CharPB4Show10to__string(self) {
  return String.fromCodePoint(self);
}
function _M0MPC16string10StringView5split(self, sep) {
  const sep_len = _M0MPC16string10StringView6length(sep);
  if (sep_len === 0) {
    return _M0MPB4Iter3mapGcRPC16string10StringViewE(_M0MPC16string10StringView4iter(self), (c) => _M0MPC16string6String12view_2einner(_M0IPC14char4CharPB4Show10to__string(c), 0, undefined));
  }
  const remaining = new _M0TPC13ref3RefGORPC16string10StringViewE(self);
  return _M0MPB4Iter3newGRPC16string10StringViewE(() => {
    const _bind = remaining.val;
    if (_bind === undefined) {
      return undefined;
    } else {
      const _Some = _bind;
      const _view = _Some;
      const _bind$2 = _M0MPC16string10StringView4find(_view, sep);
      if (_bind$2 === undefined) {
        remaining.val = undefined;
        return _view;
      } else {
        const _Some$2 = _bind$2;
        const _end = _Some$2;
        remaining.val = _M0MPC16string10StringView12view_2einner(_view, _end + sep_len | 0, undefined);
        return _M0MPC16string10StringView12view_2einner(_view, 0, _end);
      }
    }
  });
}
function _M0MPC16string6String5split(self, sep) {
  return _M0MPC16string10StringView5split(new _M0TPC16string10StringView(self, 0, self.length), sep);
}
function _M0MPC16string6String12replace__all(self, old, new_) {
  const len = self.length;
  const buf = _M0MPB13StringBuilder11new_2einner(len);
  const old_len = _M0MPC16string10StringView6length(old);
  const new$2 = _M0IPC16string10StringViewPB4Show10to__string(new_);
  if (old_len === 0) {
    _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
    const _it = _M0MPC16string6String4iter(self);
    while (true) {
      const _bind = _M0MPB4Iter4nextGcE(_it);
      if (_bind === -1) {
        break;
      } else {
        const _Some = _bind;
        const _c = _Some;
        _M0IPB13StringBuilderPB6Logger11write__char(buf, _c);
        _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
        continue;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  } else {
    const first_end = _M0MPC16string6String4find(self, old);
    if (first_end === undefined) {
      return self;
    } else {
      const _Some = first_end;
      const _end = _Some;
      let _tmp = new _M0TPC16string10StringView(self, 0, self.length);
      let _tmp$2 = _end;
      while (true) {
        const view = _tmp;
        const end = _tmp$2;
        const seg = _M0MPC16string10StringView12view_2einner(view, 0, end);
        _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(seg), _M0MPC16string10StringView13start__offset(seg), _M0MPC16string10StringView6length(seg));
        _M0IPB13StringBuilderPB6Logger13write__string(buf, new$2);
        if ((end + old_len | 0) <= len) {
          const next_view = _M0MPC16string10StringView12view_2einner(view, end + old_len | 0, undefined);
          const _bind = _M0MPC16string10StringView4find(next_view, old);
          if (_bind === undefined) {
            _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(next_view), _M0MPC16string10StringView13start__offset(next_view), _M0MPC16string10StringView6length(next_view));
            break;
          } else {
            const _Some$2 = _bind;
            const _next_end = _Some$2;
            _tmp = next_view;
            _tmp$2 = _next_end;
            continue;
          }
        } else {
          break;
        }
      }
      return _M0MPB13StringBuilder10to__string(buf);
    }
  }
}
function _M0MPC14char4Char20is__ascii__uppercase(self) {
  return self >= 65 && self <= 90;
}
function _M0MPC16string6String9to__lower(self) {
  const _bind = _M0MPC16string6String8find__by(self, (x) => _M0MPC14char4Char20is__ascii__uppercase(x));
  if (_bind === undefined) {
    return self;
  } else {
    const _Some = _bind;
    const _idx = _Some;
    const buf = _M0MPB13StringBuilder11new_2einner(self.length);
    const head = _M0MPC16string6String12view_2einner(self, 0, _idx);
    _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(head), _M0MPC16string10StringView13start__offset(head), _M0MPC16string10StringView6length(head));
    const _it = _M0MPC16string10StringView4iter(_M0MPC16string6String12view_2einner(self, _idx, undefined));
    while (true) {
      const _bind$2 = _M0MPB4Iter4nextGcE(_it);
      if (_bind$2 === -1) {
        break;
      } else {
        const _Some$2 = _bind$2;
        const _c = _Some$2;
        if (_M0MPC14char4Char20is__ascii__uppercase(_c)) {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _c + 32 | 0);
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _c);
        }
        continue;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0MPC14char4Char20is__ascii__lowercase(self) {
  return self >= 97 && self <= 122;
}
function _M0MPC16string6String9to__upper(self) {
  const _bind = _M0MPC16string6String8find__by(self, _M0MPC14char4Char20is__ascii__lowercase);
  if (_bind === undefined) {
    return self;
  } else {
    const _Some = _bind;
    const _idx = _Some;
    const buf = _M0MPB13StringBuilder11new_2einner(self.length);
    const head = _M0MPC16string6String12view_2einner(self, 0, _idx);
    _M0IP016_24default__implPB6Logger16write__substringGRPB13StringBuilderE(buf, _M0MPC16string10StringView4data(head), _M0MPC16string10StringView13start__offset(head), _M0MPC16string10StringView6length(head));
    const _it = _M0MPC16string10StringView4iter(_M0MPC16string6String12view_2einner(self, _idx, undefined));
    while (true) {
      const _bind$2 = _M0MPB4Iter4nextGcE(_it);
      if (_bind$2 === -1) {
        break;
      } else {
        const _Some$2 = _bind$2;
        const _c = _Some$2;
        if (_M0MPC14char4Char20is__ascii__lowercase(_c)) {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _c - 32 | 0);
        } else {
          _M0IPB13StringBuilderPB6Logger11write__char(buf, _c);
        }
        continue;
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0IPC16string6StringPB12ToStringView16to__string__view(self) {
  return new _M0TPC16string10StringView(self, 0, self.length);
}
function _M0IPC13int3IntPB4Show6output(self, logger) {
  logger.method_table.method_0(logger.self, _M0MPC13int3Int18to__string_2einner(self, 10));
}
function _M0IPC16string6StringPB4Show10to__string(self) {
  return self;
}
function _M0MPB4Iter11filter__mapGRPC16string10StringViewsE(self, f) {
  return () => {
    while (true) {
      const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(self);
      if (_bind === undefined) {
        return undefined;
      } else {
        const _Some = _bind;
        const _x = _Some;
        const _bind$2 = f(_x);
        if (_bind$2 === undefined) {
        } else {
          const _Some$2 = _bind$2;
          return _Some$2;
        }
        continue;
      }
    }
  };
}
function _M0MPB4Iter4join(self, sep) {
  const result = _M0MPB13StringBuilder11new_2einner(0);
  const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(self);
  if (_bind === undefined) {
  } else {
    const _Some = _bind;
    const _x = _Some;
    _M0IPB13StringBuilderPB6Logger13write__string(result, _x);
    while (true) {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(self);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some$2 = _bind$2;
        const _x$2 = _Some$2;
        _M0IPB13StringBuilderPB6Logger13write__string(result, sep);
        _M0IPB13StringBuilderPB6Logger13write__string(result, _x$2);
        continue;
      }
    }
  }
  return _M0MPB13StringBuilder10to__string(result);
}
function _M0MPB5Iter24nextGicE(self) {
  return _M0MPB4Iter4nextGRPC16string10StringViewE(self);
}
function _M0MPC16string6String20unsafe__charcode__at(self, idx) {
  return self.charCodeAt(idx);
}
function _M0IPB13SourceLocReprPB4Show6output(self, logger) {
  const pkg = self.pkg;
  const _data = _M0MPC16string10StringView4data(pkg);
  const _start = _M0MPC16string10StringView13start__offset(pkg);
  const _end = _start + _M0MPC16string10StringView6length(pkg) | 0;
  let _cursor = _start;
  let accept_state = -1;
  let match_end = -1;
  let match_tag_saver_0 = -1;
  let tag_0 = -1;
  let _bind;
  _L: {
    _L$2: {
      _L$3: while (true) {
        if (_cursor < _end) {
          const next_char = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
          _cursor = _cursor + 1 | 0;
          if (next_char === 47) {
            _L$4: while (true) {
              tag_0 = _cursor;
              if (_cursor < _end) {
                const next_char$2 = _M0MPC16string6String20unsafe__charcode__at(_data, _cursor);
                _cursor = _cursor + 1 | 0;
                if (next_char$2 === 47) {
                  while (true) {
                    if (_cursor < _end) {
                      _cursor = _cursor + 1 | 0;
                      continue;
                    } else {
                      match_tag_saver_0 = tag_0;
                      accept_state = 0;
                      match_end = _cursor;
                      break _L$2;
                    }
                  }
                } else {
                  continue;
                }
              } else {
                break _L$2;
              }
            }
          } else {
            continue;
          }
        } else {
          break _L$2;
        }
      }
      break _L;
    }
    if (accept_state === 0) {
      const package_name = _M0MPC16string6String4view(_data, match_tag_saver_0 + 1 | 0, match_end);
      const module_name = _M0MPC16string6String4view(_data, _start, match_tag_saver_0);
      _bind = { _0: module_name, _1: package_name };
    } else {
      _bind = { _0: pkg, _1: undefined };
    }
  }
  const _module_name = _bind._0;
  const _package_name = _bind._1;
  if (_package_name === undefined) {
  } else {
    const _Some = _package_name;
    const _pkg_name = _Some;
    logger.method_table.method_2(logger.self, _pkg_name);
    logger.method_table.method_3(logger.self, 47);
  }
  logger.method_table.method_2(logger.self, self.filename);
  logger.method_table.method_3(logger.self, 58);
  logger.method_table.method_2(logger.self, self.start_line);
  logger.method_table.method_3(logger.self, 58);
  logger.method_table.method_2(logger.self, self.start_column);
  logger.method_table.method_3(logger.self, 45);
  logger.method_table.method_2(logger.self, self.end_line);
  logger.method_table.method_3(logger.self, 58);
  logger.method_table.method_2(logger.self, self.end_column);
  logger.method_table.method_3(logger.self, 64);
  logger.method_table.method_2(logger.self, _module_name);
}
function _M0IPB9SourceLocPB4Show6output(self, logger) {
  _M0IPB13SourceLocReprPB4Show6output(_M0MPB13SourceLocRepr5parse(self), logger);
}
function _M0MPC15array9ArrayView4joinGsE(self, separator) {
  if ((self.end - self.start | 0) === 0) {
    return "";
  } else {
    const _hd = self.buf[self.start];
    const _x_buf = self.buf;
    const _x_start = 1 + self.start | 0;
    const _x_end = self.end;
    const hd = _M0IPC16string6StringPB12ToStringView16to__string__view(_hd);
    let size_hint = _M0MPC16string10StringView6length(hd);
    const _bind = _x_end - _x_start | 0;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const s = _x_buf[_x_start + _ | 0];
        size_hint = size_hint + (_M0MPC16string10StringView6length(_M0IPC16string6StringPB12ToStringView16to__string__view(s)) + _M0MPC16string10StringView6length(separator) | 0) | 0;
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    size_hint = size_hint << 1;
    const buf = _M0MPB13StringBuilder11new_2einner(size_hint);
    _M0IPB13StringBuilderPB6Logger11write__view(buf, hd);
    if (_M0MPC16string6String24char__length__eq_2einner(separator.str, 0, separator.start, separator.end)) {
      const _bind$2 = _x_end - _x_start | 0;
      let _tmp$2 = 0;
      while (true) {
        const _ = _tmp$2;
        if (_ < _bind$2) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string6StringPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$2 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    } else {
      const _bind$2 = _x_end - _x_start | 0;
      let _tmp$2 = 0;
      while (true) {
        const _ = _tmp$2;
        if (_ < _bind$2) {
          const s = _x_buf[_x_start + _ | 0];
          const s$2 = _M0IPC16string6StringPB12ToStringView16to__string__view(s);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, separator);
          _M0IPB13StringBuilderPB6Logger11write__view(buf, s$2);
          _tmp$2 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    return _M0MPB13StringBuilder10to__string(buf);
  }
}
function _M0MPC15array5Array4joinGsE(self, separator) {
  return _M0MPC15array9ArrayView4joinGsE(new _M0TPB9ArrayViewGsE(self, 0, self.length), separator);
}
function _M0FP25apple7moonseo12parse__facts(raw) {
  const facts = [];
  const _bind = "\r";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "";
  const normalized = _M0MPC16string6String12replace__all(raw, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\n";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
  while (true) {
    let line;
    _L: {
      const _bind$4 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$4 === undefined) {
        break;
      } else {
        const _Some = _bind$4;
        const _line = _Some;
        line = _line;
        break _L;
      }
    }
    const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(line), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
      _M0MPC15array5Array4pushGsE(facts, trimmed);
    }
    continue;
  }
  return facts;
}
function _M0FP25apple7moonseo18has__real__sources(facts_raw) {
  return _M0FP25apple7moonseo12parse__facts(facts_raw).length > 0;
}
function _M0FP25apple7moonseo15is__chinese__ui(lang) {
  return lang === "zh";
}
function _M0FP25apple7moonseo20localized__ai__error(message, lang) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(message, undefined));
  if (!_M0FP25apple7moonseo15is__chinese__ui(lang) || trimmed === "") {
    return trimmed;
  }
  const lower = _M0MPC16string6String9to__lower(trimmed);
  let _tmp;
  const _bind = "request timed out while connecting to the upstream api";
  if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    _tmp = true;
  } else {
    const _bind$2 = "timed out while connecting to the upstream api";
    _tmp = _M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  }
  if (_tmp) {
    return `连接上游 AI 服务超时，通常是网络或 TLS 连通性问题，不是内容质量问题。原始错误：${_M0IPC16string6StringPB4Show10to__string(trimmed)}`;
  } else {
    const _bind$2 = "network or tls connectivity problem";
    if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      return `AI 服务连接异常，通常是网络或 TLS 连通性问题，不是内容质量问题。原始错误：${_M0IPC16string6StringPB4Show10to__string(trimmed)}`;
    } else {
      const _bind$3 = "returned an empty payload";
      if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        return `AI 服务返回了空结果，请稍后重试。原始错误：${_M0IPC16string6StringPB4Show10to__string(trimmed)}`;
      } else {
        const _bind$4 = "request failed with status";
        if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          return `AI 请求失败，请稍后重试。原始错误：${_M0IPC16string6StringPB4Show10to__string(trimmed)}`;
        } else {
          const _bind$5 = "unknown request error";
          if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
            return "AI 请求出现未知错误，请稍后重试。";
          } else {
            return trimmed;
          }
        }
      }
    }
  }
}
function _M0FP25apple7moonseo24contains__banned__claims(text) {
  const lower = _M0MPC16string6String9to__lower(text);
  const _bind = "best";
  if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    return true;
  } else {
    let _tmp;
    const _bind$2 = "guaranteed";
    if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      _tmp = true;
    } else {
      let _tmp$2;
      const _bind$3 = "#1";
      if (_M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$2 = true;
      } else {
        const _bind$4 = "perfect";
        _tmp$2 = _M0MPC16string6String8contains(lower, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
      }
      _tmp = _tmp$2;
    }
    return _tmp;
  }
}
function _M0FP25apple7moonseo21claim__safety__detail(text, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  return _M0FP25apple7moonseo24contains__banned__claims(text) ? (chinese ? "草稿中包含 best、guaranteed、perfect 或 #1 这类高风险营销表述。" : "The draft includes a risky marketing superlative such as best, guaranteed, perfect, or #1.") : chinese ? "当前草稿避开了高风险营销形容词。" : "The current copy avoids risky marketing superlatives.";
}
function _M0FP25apple7moonseo18count__occurrences(text, needle) {
  if (needle === "" || text.length < needle.length) {
    return 0;
  }
  const index = new _M0TPC13ref3RefGiE(0);
  const count = new _M0TPC13ref3RefGiE(0);
  const last_start = text.length - needle.length | 0;
  while (true) {
    if (index.val <= last_start) {
      if (_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(text, index.val, index.val + needle.length | 0)) === needle) {
        count.val = count.val + 1 | 0;
        index.val = index.val + needle.length | 0;
      } else {
        index.val = index.val + 1 | 0;
      }
      continue;
    } else {
      break;
    }
  }
  return count.val;
}
function _M0FP25apple7moonseo27count__keyword__occurrences(text, keyword) {
  return _M0FP25apple7moonseo18count__occurrences(_M0MPC16string6String9to__lower(text), _M0MPC16string6String9to__lower(keyword));
}
function _M0FP25apple7moonseo12count__words(text) {
  const _bind = "\n";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = ",";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = ".";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = " ";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = ":";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = " ";
  const _tmp$8 = _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _bind$9 = ";";
  const _tmp$9 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = " ";
  const _tmp$10 = _M0MPC16string6String12replace__all(_tmp$8, _tmp$9, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _bind$11 = "(";
  const _tmp$11 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = " ";
  const _tmp$12 = _M0MPC16string6String12replace__all(_tmp$10, _tmp$11, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _bind$13 = ")";
  const _tmp$13 = new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length);
  const _bind$14 = " ";
  const _tmp$14 = _M0MPC16string6String12replace__all(_tmp$12, _tmp$13, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length));
  const _bind$15 = "[";
  const _tmp$15 = new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length);
  const _bind$16 = " ";
  const _tmp$16 = _M0MPC16string6String12replace__all(_tmp$14, _tmp$15, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
  const _bind$17 = "]";
  const _tmp$17 = new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length);
  const _bind$18 = " ";
  const normalized = _M0MPC16string6String12replace__all(_tmp$16, _tmp$17, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length));
  const count = new _M0TPC13ref3RefGiE(0);
  const _bind$19 = " ";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$19, 0, _bind$19.length));
  while (true) {
    let token;
    _L: {
      const _bind$20 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$20 === undefined) {
        break;
      } else {
        const _Some = _bind$20;
        const _token = _Some;
        token = _token;
        break _L;
      }
    }
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(token), undefined)), "")) {
      count.val = count.val + 1 | 0;
    }
    continue;
  }
  return count.val;
}
function _M0FP25apple7moonseo12escape__html(input) {
  const _bind = "&";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "&amp;";
  const _tmp$2 = _M0MPC16string6String12replace__all(input, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "<";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "&lt;";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = ">";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = "&gt;";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = "\"";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = "&quot;";
  return _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
}
function _M0FP25apple7moonseo23render__single__finding(builder, finding, chinese, evidence_coverage_title) {
  const is_evidence_coverage = finding.title === evidence_coverage_title;
  const tone = finding.passed ? "pass" : "warn";
  const badge = finding.passed ? (chinese ? "通过" : "Pass") : chinese ? "待优化" : "Needs work";
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"audit-item ");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, tone);
  if (is_evidence_coverage) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" id=\"evidenceCoverageCard\"><div class=\"audit-top\"><strong>");
  } else {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "\"><div class=\"audit-top\"><strong>");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(finding.title));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, badge);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></div><p>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(finding.detail));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p>");
  if (is_evidence_coverage) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"evidenceCoverageDetail\" class=\"audit-detail-panel\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">当前校对证据</p><h4 id=\"evidenceCoverageTitle\">等待选择</h4><div id=\"evidenceCoverageBody\" class=\"evidence-excerpt\"><p>点击正文中的证据编号后，这里会展开对应来源内容。</p></div>" : "<p id=\"evidenceCoverageSource\" class=\"detail-kicker\">Current evidence</p><h4 id=\"evidenceCoverageTitle\">Waiting for selection</h4><div id=\"evidenceCoverageBody\" class=\"evidence-excerpt\"><p>Click an inline evidence marker in the draft to inspect the matching source note here.</p></div>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</article>");
}
function _M0FP25apple7moonseo16render__findings(findings, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const evidence_coverage_title = chinese ? "证据覆盖" : "Evidence coverage";
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"audit-list\">");
  const _bind = findings.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const finding = findings[_];
      if (!finding.passed) {
        _M0FP25apple7moonseo23render__single__finding(builder, finding, chinese, evidence_coverage_title);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$2 = findings.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$2) {
      const finding = findings[_];
      if (finding.passed) {
        _M0FP25apple7moonseo23render__single__finding(builder, finding, chinese, evidence_coverage_title);
      }
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo12audit__draft(draft, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const keyword_occurrences = _M0FP25apple7moonseo27count__keyword__occurrences(draft.plain_text, draft.keyword);
  const keyword_label = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(draft.keyword, undefined)) === "" ? (chinese ? "未指定" : "Not set") : draft.keyword;
  const word_count = _M0FP25apple7moonseo12count__words(draft.plain_text);
  let keyword_density;
  if (word_count === 0) {
    keyword_density = 0;
  } else {
    if (word_count === 0) {
      $panic();
    }
    keyword_density = (Math.imul(keyword_occurrences, 100) | 0) / word_count | 0;
  }
  const _tmp = new _M0TP25apple7moonseo12AuditFinding(chinese ? "标题长度" : "Title length", draft.title.length >= 35 && draft.title.length <= 70, chinese ? `当前 SEO 标题长度为 ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.title.length)} 个字符。` : `The SEO title is ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.title.length)} characters long.`);
  const _tmp$2 = chinese ? "Slug 规范" : "Slug hygiene";
  let _tmp$3;
  if (draft.slug.length <= 60) {
    const _tmp$4 = draft.slug;
    const _bind = "--";
    _tmp$3 = !_M0MPC16string6String8contains(_tmp$4, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  } else {
    _tmp$3 = false;
  }
  const findings = [_tmp, new _M0TP25apple7moonseo12AuditFinding(_tmp$2, _tmp$3, chinese ? `导出 slug：${_M0IPC16string6StringPB4Show10to__string(draft.slug)}` : `Clean export slug: ${_M0IPC16string6StringPB4Show10to__string(draft.slug)}`), new _M0TP25apple7moonseo12AuditFinding(chinese ? "Meta 描述" : "Meta description", draft.meta_description.length >= 110 && draft.meta_description.length <= 160, chinese ? `Meta 描述长度为 ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.meta_description.length)} 个字符。` : `Meta description length: ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.meta_description.length)} characters.`), new _M0TP25apple7moonseo12AuditFinding(chinese ? "正文长度" : "Body length", word_count >= 1300 && word_count <= 1800, chinese ? `当前草稿长度为 ${_M0IP016_24default__implPB4Show10to__stringGiE(word_count)} 个单词。` : `Draft length: ${_M0IP016_24default__implPB4Show10to__stringGiE(word_count)} words.`), new _M0TP25apple7moonseo12AuditFinding(chinese ? "关键词分布" : "Keyword footprint", keyword_occurrences >= 2 && (keyword_occurrences <= 6 && keyword_density <= 3), chinese ? `当前主关键词：${_M0IPC16string6StringPB4Show10to__string(keyword_label)}；在草稿中共出现 ${_M0IP016_24default__implPB4Show10to__stringGiE(keyword_occurrences)} 次。` : `Current primary keyword: ${_M0IPC16string6StringPB4Show10to__string(keyword_label)}. It appears ${_M0IP016_24default__implPB4Show10to__stringGiE(keyword_occurrences)} times across the draft.`), new _M0TP25apple7moonseo12AuditFinding(chinese ? "标题结构" : "Heading structure", _M0FP25apple7moonseo18count__occurrences(draft.article_html, "<h2") >= 3 && _M0FP25apple7moonseo18count__occurrences(draft.article_html, "<h3") >= 3, chinese ? "页面包含可扫描的 H2 分节，并且正文里出现了 H3 小标题。" : "The page includes scannable H2 sections plus H3 subheadings in the body."), new _M0TP25apple7moonseo12AuditFinding(chinese ? "表述风险" : "Claim safety", !_M0FP25apple7moonseo24contains__banned__claims(draft.plain_text), _M0FP25apple7moonseo21claim__safety__detail(draft.plain_text, lang)), new _M0TP25apple7moonseo12AuditFinding(chinese ? "证据覆盖" : "Evidence coverage", draft.evidence_count >= 3, chinese ? `当前草稿可按需展开 ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.evidence_count)} 条来源事实。` : `The draft exposes ${_M0IP016_24default__implPB4Show10to__stringGiE(draft.evidence_count)} source notes on demand.`)];
  const pass_count = new _M0TPC13ref3RefGiE(0);
  const _bind = findings.length;
  let _tmp$4 = 0;
  while (true) {
    const _ = _tmp$4;
    if (_ < _bind) {
      const finding = findings[_];
      if (finding.passed) {
        pass_count.val = pass_count.val + 1 | 0;
      }
      _tmp$4 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const total_count = findings.length;
  if (total_count === 0) {
    $panic();
  }
  const score = (Math.imul(pass_count.val, 100) | 0) / total_count | 0;
  const summary_text = chinese ? `SEO 就绪度：${_M0IP016_24default__implPB4Show10to__stringGiE(score)}/100（通过 ${_M0IP016_24default__implPB4Show10to__stringGiE(pass_count.val)}/${_M0IP016_24default__implPB4Show10to__stringGiE(total_count)} 项）` : `SEO readiness score: ${_M0IP016_24default__implPB4Show10to__stringGiE(score)}/100 (${_M0IP016_24default__implPB4Show10to__stringGiE(pass_count.val)}/${_M0IP016_24default__implPB4Show10to__stringGiE(total_count)} checks passed)`;
  const summary_html = chinese ? `<div class=\"score-card\"><strong>${_M0IP016_24default__implPB4Show10to__stringGiE(score)}/100</strong><p>共通过 ${_M0IP016_24default__implPB4Show10to__stringGiE(pass_count.val)}/${_M0IP016_24default__implPB4Show10to__stringGiE(total_count)} 项确定性检查。</p></div>` : `<div class=\"score-card\"><strong>${_M0IP016_24default__implPB4Show10to__stringGiE(score)}/100</strong><p>${_M0IP016_24default__implPB4Show10to__stringGiE(pass_count.val)} of ${_M0IP016_24default__implPB4Show10to__stringGiE(total_count)} deterministic checks passed.</p></div>`;
  const findings_html = _M0FP25apple7moonseo16render__findings(findings, lang);
  return new _M0TP25apple7moonseo11AuditReport(score, pass_count.val, total_count, summary_text, summary_html, findings_html);
}
function _M0FP25apple7moonseo16split__sentences(text) {
  const parts = [];
  const _bind = "。";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "。\n";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "！";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "！\n";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = "？";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = "？\n";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = ". ";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = ". \n";
  const _tmp$8 = _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _bind$9 = "! ";
  const _tmp$9 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = "! \n";
  const _tmp$10 = _M0MPC16string6String12replace__all(_tmp$8, _tmp$9, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _bind$11 = "? ";
  const _tmp$11 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = "? \n";
  const normalized = _M0MPC16string6String12replace__all(_tmp$10, _tmp$11, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _bind$13 = "\n";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length));
  while (true) {
    let part;
    _L: {
      const _bind$14 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$14 === undefined) {
        break;
      } else {
        const _Some = _bind$14;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(part), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
      _M0MPC15array5Array4pushGsE(parts, trimmed);
    }
    continue;
  }
  return parts;
}
function _M0FP25apple7moonseo18sentence__or__text(text) {
  const sentences = _M0FP25apple7moonseo16split__sentences(text);
  return sentences.length > 0 ? _M0MPC15array5Array2atGsE(sentences, 0) : text;
}
function _M0FP25apple7moonseo7excerpt(input, max_length) {
  return input.length <= max_length ? input : `${_M0IPC16string6StringPB4Show10to__string(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(input, 0, max_length - 1 | 0)), undefined)))}…`;
}
function _M0FP25apple7moonseo11join__words(words) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < words.length) {
      if (index > 0) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, " ");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPC15array5Array2atGsE(words, index));
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo30looks__like__meta__instruction(text, lang) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined));
  if (trimmed === "") {
    return false;
  }
  if (_M0FP25apple7moonseo15is__chinese__ui(lang)) {
    const _bind = "这一节应";
    if (_M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
      return true;
    } else {
      let _tmp;
      const _bind$2 = "本节应";
      if (_M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
        _tmp = true;
      } else {
        let _tmp$2;
        const _bind$3 = "小节应";
        if (_M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
          _tmp$2 = true;
        } else {
          let _tmp$3;
          const _bind$4 = "文章应";
          if (_M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
            _tmp$3 = true;
          } else {
            let _tmp$4;
            const _bind$5 = "FAQ 前";
            if (_M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
              _tmp$4 = true;
            } else {
              const _bind$6 = "总结型小节";
              _tmp$4 = _M0MPC16string6String8contains(trimmed, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
            }
            _tmp$3 = _tmp$4;
          }
          _tmp$2 = _tmp$3;
        }
        _tmp = _tmp$2;
      }
      return _tmp;
    }
  } else {
    const lower = _M0MPC16string6String9to__lower(trimmed);
    const _bind = "the opening section should";
    if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
      return true;
    } else {
      let _tmp;
      const _bind$2 = "the middle section should";
      if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
        _tmp = true;
      } else {
        let _tmp$2;
        const _bind$3 = "the closing section should";
        if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
          _tmp$2 = true;
        } else {
          let _tmp$3;
          const _bind$4 = "this summary section should";
          if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
            _tmp$3 = true;
          } else {
            let _tmp$4;
            const _bind$5 = "before the faq";
            if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
              _tmp$4 = true;
            } else {
              let _tmp$5;
              const _bind$6 = "rather than forcing";
              if (_M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
                _tmp$5 = true;
              } else {
                const _bind$7 = "a strong closing section should";
                _tmp$5 = _M0MPC16string6String11has__prefix(lower, new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length));
              }
              _tmp$4 = _tmp$5;
            }
            _tmp$3 = _tmp$4;
          }
          _tmp$2 = _tmp$3;
        }
        _tmp = _tmp$2;
      }
      return _tmp;
    }
  }
}
function _M0FP25apple7moonseo25sanitize__heading__source(text) {
  const _bind = ":";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = ";";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = ",";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = " ";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = ".";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = " ";
  const _tmp$8 = _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _bind$9 = "。";
  const _tmp$9 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = " ";
  const _tmp$10 = _M0MPC16string6String12replace__all(_tmp$8, _tmp$9, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _bind$11 = "！";
  const _tmp$11 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = " ";
  const _tmp$12 = _M0MPC16string6String12replace__all(_tmp$10, _tmp$11, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _bind$13 = "？";
  const _tmp$13 = new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length);
  const _bind$14 = " ";
  const _tmp$14 = _M0MPC16string6String12replace__all(_tmp$12, _tmp$13, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length));
  const _bind$15 = "(";
  const _tmp$15 = new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length);
  const _bind$16 = " ";
  const _tmp$16 = _M0MPC16string6String12replace__all(_tmp$14, _tmp$15, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
  const _bind$17 = ")";
  const _tmp$17 = new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length);
  const _bind$18 = " ";
  return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC16string6String12replace__all(_tmp$16, _tmp$17, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length)), undefined));
}
function _M0FP25apple7moonseo17capitalize__ascii(input) {
  if (input.length === 0) {
    return input;
  }
  const lower = _M0MPC16string6String9to__lower(input);
  const first = _M0MPC16string6String9to__upper(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(lower, 0, 1)));
  return lower.length === 1 ? first : `${_M0IPC16string6StringPB4Show10to__string(first)}${_M0IPC16string6StringPB4Show10to__string(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(lower, 1, undefined)))}`;
}
function _M0FP25apple7moonseo11title__case(input) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const first_word = new _M0TPC13ref3RefGbE(true);
  const _bind = " ";
  const _it = _M0MPC16string6String5split(input, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let word;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _word = _Some;
        word = _word;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(word), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(current, "")) {
      if (!first_word.val) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, " ");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo17capitalize__ascii(current));
      first_word.val = false;
    }
    continue;
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo25short__heading__candidate(text, lang) {
  const cleaned = _M0FP25apple7moonseo25sanitize__heading__source(text);
  if (cleaned === "") {
    return "";
  }
  if (_M0FP25apple7moonseo30looks__like__meta__instruction(cleaned, lang)) {
    return "";
  }
  if (_M0FP25apple7moonseo15is__chinese__ui(lang)) {
    return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP25apple7moonseo7excerpt(cleaned, 12), undefined));
  } else {
    const words = [];
    const _bind = " ";
    const _it = _M0MPC16string6String5split(cleaned, new _M0TPC16string10StringView(_bind, 0, _bind.length));
    while (true) {
      let raw;
      _L: {
        const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
        if (_bind$2 === undefined) {
          break;
        } else {
          const _Some = _bind$2;
          const _raw = _Some;
          raw = _raw;
          break _L;
        }
      }
      const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(raw), undefined));
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(current, "")) {
        _M0MPC15array5Array4pushGsE(words, current);
      }
      if (words.length >= 4) {
        break;
      }
      continue;
    }
    return words.length === 0 ? "" : _M0FP25apple7moonseo11title__case(_M0FP25apple7moonseo11join__words(words));
  }
}
function _M0FP25apple7moonseo23infer__body__subheading(text, fallback, lang) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined));
  if (trimmed === "") {
    return fallback;
  }
  const first_sentence = _M0FP25apple7moonseo18sentence__or__text(trimmed);
  const candidate = _M0FP25apple7moonseo25short__heading__candidate(first_sentence, lang);
  return candidate === "" ? fallback : candidate;
}
function _M0FP25apple7moonseo22body__subheading__pair(first_text, second_text, section_index, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  let fallback;
  switch (section_index) {
    case 1: {
      fallback = chinese ? { _0: "核心判断", _1: "支撑细节" } : { _0: "Core takeaway", _1: "Supporting detail" };
      break;
    }
    case 2: {
      fallback = chinese ? { _0: "实际体验", _1: "关键差异" } : { _0: "Practical use", _1: "Meaningful difference" };
      break;
    }
    default: {
      fallback = chinese ? { _0: "确认重点", _1: "适用边界" } : { _0: "What to verify", _1: "Where it may vary" };
    }
  }
  return { _0: _M0FP25apple7moonseo23infer__body__subheading(first_text, fallback._0, lang), _1: _M0FP25apple7moonseo23infer__body__subheading(second_text, fallback._1, lang) };
}
function _M0FP25apple7moonseo24emphasize__keyword__html(text, keyword) {
  const needle = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(keyword, undefined));
  if (needle === "") {
    return _M0FP25apple7moonseo12escape__html(text);
  }
  const lower_text = _M0MPC16string6String9to__lower(text);
  const lower_needle = _M0MPC16string6String9to__lower(needle);
  if (lower_text === "" || (lower_needle === "" || lower_text.length < lower_needle.length)) {
    return _M0FP25apple7moonseo12escape__html(text);
  }
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const cursor = new _M0TPC13ref3RefGiE(0);
  const start = new _M0TPC13ref3RefGiE(0);
  const matched = new _M0TPC13ref3RefGbE(false);
  while (true) {
    if ((cursor.val + lower_needle.length | 0) <= lower_text.length) {
      const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(lower_text, cursor.val, cursor.val + lower_needle.length | 0));
      if (current === lower_needle) {
        matched.val = true;
        _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(text, start.val, cursor.val))));
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "<strong>");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(text, cursor.val, cursor.val + lower_needle.length | 0))));
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong>");
        cursor.val = cursor.val + lower_needle.length | 0;
        start.val = cursor.val;
      } else {
        cursor.val = cursor.val + 1 | 0;
      }
      continue;
    } else {
      break;
    }
  }
  if (!matched.val) {
    return _M0FP25apple7moonseo12escape__html(text);
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(text, start.val, undefined))));
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo18bullet__list__html(items, keyword) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<ul class=\"article-bullets\">");
  const _bind = items.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const item = items[_];
      const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(item, undefined));
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "<li class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo24emphasize__keyword__html(trimmed, keyword));
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</li>");
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</ul>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo11join__slice(parts, start, end_) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = start;
  while (true) {
    const index = _tmp;
    if (index < end_) {
      if (index > start) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, " ");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPC15array5Array2atGsE(parts, index));
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo16sentence__groups(text) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined));
  if (trimmed === "") {
    return [];
  }
  const sentences = _M0FP25apple7moonseo16split__sentences(trimmed);
  if (sentences.length <= 3) {
    return [trimmed];
  }
  const groups = [];
  const index = new _M0TPC13ref3RefGiE(0);
  while (true) {
    if (index.val < sentences.length) {
      const remaining = sentences.length - index.val | 0;
      let take;
      if (remaining <= 3) {
        take = remaining;
      } else {
        if (remaining === 4) {
          take = 2;
        } else {
          if (remaining === 5) {
            take = 3;
          } else {
            if (3 === 0) {
              $panic();
            }
            if ((remaining % 3 | 0) === 1) {
              take = 2;
            } else {
              take = 3;
            }
          }
        }
      }
      _M0MPC15array5Array4pushGsE(groups, _M0FP25apple7moonseo11join__slice(sentences, index.val, index.val + take | 0));
      index.val = index.val + take | 0;
      continue;
    } else {
      break;
    }
  }
  return groups;
}
function _M0FP25apple7moonseo24split__paragraph__blocks(text) {
  const _bind = "\r\n";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "\n";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\n\n";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "\u001e";
  const normalized = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const explicit = [];
  const _bind$5 = "\u001e";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length));
  while (true) {
    let part;
    _L: {
      const _bind$6 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$6 === undefined) {
        break;
      } else {
        const _Some = _bind$6;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(part), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
      const _bind$6 = _M0FP25apple7moonseo16sentence__groups(trimmed);
      const _bind$7 = _bind$6.length;
      let _tmp$4 = 0;
      while (true) {
        const _ = _tmp$4;
        if (_ < _bind$7) {
          const paragraph = _bind$6[_];
          _M0MPC15array5Array4pushGsE(explicit, paragraph);
          _tmp$4 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    continue;
  }
  if (explicit.length > 0) {
    return explicit;
  }
  return _M0FP25apple7moonseo16sentence__groups(text);
}
function _M0FP25apple7moonseo23claim__paragraphs__html(claim_id, text, evidence_html, is_lede, keyword) {
  const paragraphs = _M0FP25apple7moonseo24split__paragraph__blocks(text);
  if (paragraphs.length === 0) {
    return "";
  }
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < paragraphs.length) {
      const paragraph = _M0MPC15array5Array2atGsE(paragraphs, index);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p");
      if (index === 0) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, " id=\"claim-");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "\"");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, " class=\"");
      if (index === 0 && is_lede) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "lede claim-block");
      } else {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "claim-block");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" data-claim-id=\"");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "\"><span class=\"claim-copy editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo24emphasize__keyword__html(paragraph, keyword));
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span>");
      if ((index + 1 | 0) === paragraphs.length && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(evidence_html, undefined)), "")) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span class=\"claim-inline-evidence\"> ");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, evidence_html);
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span>");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p>");
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo22split__claim__segments(text) {
  const paragraphs = _M0FP25apple7moonseo24split__paragraph__blocks(text);
  const segments = [];
  const _bind = paragraphs.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const paragraph = paragraphs[_];
      _L: {
        const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(paragraph, undefined));
        if (current === "") {
          break _L;
        }
        const sentences = _M0FP25apple7moonseo16split__sentences(current);
        if (sentences.length <= 2) {
          _M0MPC15array5Array4pushGsE(segments, current);
          break _L;
        }
        if (sentences.length <= 4) {
          const first = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP25apple7moonseo11join__slice(sentences, 0, 2), undefined));
          const second = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP25apple7moonseo11join__slice(sentences, 2, sentences.length), undefined));
          if (_M0IP016_24default__implPB2Eq10not__equalGsE(first, "")) {
            _M0MPC15array5Array4pushGsE(segments, first);
          }
          if (_M0IP016_24default__implPB2Eq10not__equalGsE(second, "")) {
            _M0MPC15array5Array4pushGsE(segments, second);
          }
          break _L;
        }
        const index = new _M0TPC13ref3RefGiE(0);
        while (true) {
          if (index.val < sentences.length) {
            const end_ = (index.val + 3 | 0) <= sentences.length ? index.val + 3 | 0 : sentences.length;
            const segment = _M0FP25apple7moonseo11join__slice(sentences, index.val, end_);
            if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(segment, undefined)), "")) {
              _M0MPC15array5Array4pushGsE(segments, _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(segment, undefined)));
            }
            index.val = end_;
            continue;
          } else {
            break;
          }
        }
        break _L;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return segments.length === 0 ? [_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined))] : segments;
}
function _M0FP25apple7moonseo17claim__subanchors(base_id, text) {
  const segments = _M0FP25apple7moonseo22split__claim__segments(text);
  if (segments.length <= 1) {
    return [new _M0TP25apple7moonseo11ClaimAnchor(base_id, _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined)))];
  }
  const claims = [];
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < segments.length) {
      _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor(`${_M0IPC16string6StringPB4Show10to__string(base_id)}-${_M0IP016_24default__implPB4Show10to__stringGiE(index + 1 | 0)}`, _M0MPC15array5Array2atGsE(segments, index)));
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return claims;
}
function _M0FP25apple7moonseo22claim__paragraph__html(claim_id, text, evidence_html, is_lede, keyword) {
  const claims = _M0FP25apple7moonseo17claim__subanchors(claim_id, text);
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < claims.length) {
      const claim = _M0MPC15array5Array2atGsE(claims, index);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo23claim__paragraphs__html(claim.id, claim.text, (index + 1 | 0) === claims.length ? evidence_html : "", is_lede && index === 0, keyword));
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo24parse__table__row__cells(row) {
  const cells = [];
  const _bind = "|";
  const _it = _M0MPC16string6String5split(row, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let part;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    const cell = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(part), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(cell, "")) {
      _M0MPC15array5Array4pushGsE(cells, cell);
    }
    continue;
  }
  return cells.length === 3 ? cells : [];
}
function _M0FP25apple7moonseo23comparison__table__html(columns, rows, keyword) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"article-table-wrap\"><table class=\"article-table\"><thead><tr>");
  const _bind = columns.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const column = columns[_];
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "<th>");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(column, undefined))));
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "</th>");
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</tr></thead><tbody>");
  const _bind$2 = rows.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$2) {
      const row = rows[_];
      const cells = _M0FP25apple7moonseo24parse__table__row__cells(row);
      if (cells.length === 3) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "<tr>");
        const _bind$3 = cells.length;
        let _tmp$3 = 0;
        while (true) {
          const _$2 = _tmp$3;
          if (_$2 < _bind$3) {
            const cell = cells[_$2];
            _M0IPB13StringBuilderPB6Logger13write__string(builder, "<td class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
            _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo24emphasize__keyword__html(cell, keyword));
            _M0IPB13StringBuilderPB6Logger13write__string(builder, "</td>");
            _tmp$3 = _$2 + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</tr>");
      }
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</tbody></table></div>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo25editable__paragraph__html(text, keyword) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo24emphasize__keyword__html(text, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo26editable__paragraphs__html(text, keyword) {
  const paragraphs = _M0FP25apple7moonseo24split__paragraph__blocks(text);
  if (paragraphs.length === 0) {
    return "";
  } else {
    const builder = _M0MPB13StringBuilder11new_2einner(0);
    const _bind = paragraphs.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const paragraph = paragraphs[_];
        _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo25editable__paragraph__html(paragraph, keyword));
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return _M0MPB13StringBuilder10to__string(builder);
  }
}
function _M0FP25apple7moonseo15faq__item__html(question, answer, keyword, claim_id) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"faq-item\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<h3 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo24emphasize__keyword__html(question, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h3>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html(claim_id, answer, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo20has__nonempty__items(items) {
  const _bind = items.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const item = items[_];
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(item, undefined)), "")) {
        return true;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return false;
}
function _M0FP25apple7moonseo17has__visible__faq(faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer) {
  return _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_one_question, undefined)), "") && (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_one_answer, undefined)), "") && (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_two_question, undefined)), "") && (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_two_answer, undefined)), "") && (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_three_question, undefined)), "") && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_three_answer, undefined)), "")))));
}
function _M0FP25apple7moonseo21join__nonempty__parts(parts) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const wrote = new _M0TPC13ref3RefGbE(false);
  const _bind = parts.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const part = parts[_];
      const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(part, undefined));
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(current, "")) {
        if (wrote.val) {
          _M0IPB13StringBuilderPB6Logger13write__string(builder, " ");
        }
        _M0IPB13StringBuilderPB6Logger13write__string(builder, current);
        wrote.val = true;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo13opening__html(claim_id, opening_answer, opening_problem, opening_value, keyword) {
  return _M0FP25apple7moonseo23claim__paragraphs__html(claim_id, _M0FP25apple7moonseo21join__nonempty__parts([opening_answer, opening_problem, opening_value]), "", true, keyword);
}
function _M0FP25apple7moonseo18split__claim__pair(text) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined));
  const sentences = _M0FP25apple7moonseo16split__sentences(trimmed);
  if (sentences.length >= 2) {
    if (2 === 0) {
      $panic();
    }
    const pivot = (sentences.length + 1 | 0) / 2 | 0;
    return { _0: _M0FP25apple7moonseo11join__slice(sentences, 0, pivot), _1: _M0FP25apple7moonseo11join__slice(sentences, pivot, sentences.length) };
  }
  if (2 === 0) {
    $panic();
  }
  const midpoint = trimmed.length / 2 | 0;
  const left = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(trimmed, 0, midpoint)), undefined));
  const right = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(trimmed, midpoint, undefined)), undefined));
  return _M0IP016_24default__implPB2Eq10not__equalGsE(left, "") && _M0IP016_24default__implPB2Eq10not__equalGsE(right, "") ? { _0: left, _1: right } : { _0: trimmed, _1: trimmed };
}
function _M0FP25apple7moonseo16subheading__html(text) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<h3 class=\"editable-field article-subheading\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(text));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h3>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo24build__ai__article__html(title, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, section_two_heading, section_two_body, section_three_heading, section_three_body, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer, keyword, lang) {
  let section_one_a;
  let section_one_b;
  _L: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_one_body);
    const _section_one_a = _bind._0;
    const _section_one_b = _bind._1;
    section_one_a = _section_one_a;
    section_one_b = _section_one_b;
    break _L;
  }
  let section_two_a;
  let section_two_b;
  _L$2: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_two_body);
    const _section_two_a = _bind._0;
    const _section_two_b = _bind._1;
    section_two_a = _section_two_a;
    section_two_b = _section_two_b;
    break _L$2;
  }
  let section_three_a;
  let section_three_b;
  _L$3: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_three_body);
    const _section_three_a = _bind._0;
    const _section_three_b = _bind._1;
    section_three_a = _section_three_a;
    section_three_b = _section_three_b;
    break _L$3;
  }
  let section_one_h3a;
  let section_one_h3b;
  _L$4: {
    const _bind = _M0FP25apple7moonseo22body__subheading__pair(section_one_a, section_one_b, 1, lang);
    const _section_one_h3a = _bind._0;
    const _section_one_h3b = _bind._1;
    section_one_h3a = _section_one_h3a;
    section_one_h3b = _section_one_h3b;
    break _L$4;
  }
  let section_two_h3a;
  let section_two_h3b;
  _L$5: {
    const _bind = _M0FP25apple7moonseo22body__subheading__pair(section_two_a, section_two_b, 2, lang);
    const _section_two_h3a = _bind._0;
    const _section_two_h3b = _bind._1;
    section_two_h3a = _section_two_h3a;
    section_two_h3b = _section_two_h3b;
    break _L$5;
  }
  let section_three_h3a;
  let section_three_h3b;
  _L$6: {
    const _bind = _M0FP25apple7moonseo22body__subheading__pair(section_three_a, section_three_b, 3, lang);
    const _section_three_h3a = _bind._0;
    const _section_three_h3b = _bind._1;
    section_three_h3a = _section_three_h3a;
    section_three_h3b = _section_three_h3b;
    break _L$6;
  }
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"article-card\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<h1 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(title));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h1>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo13opening__html("C1", opening_answer, opening_problem, opening_value, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(section_one_heading));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_one_h3a));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C2", section_one_a, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_one_h3b));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C3", section_one_b, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(key_points_heading, undefined)), "") && _M0FP25apple7moonseo20has__nonempty__items(key_points_items)) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(key_points_heading));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo18bullet__list__html(key_points_items, keyword));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(comparison_table_heading, undefined)), "") && (comparison_table_columns.length === 3 && _M0FP25apple7moonseo20has__nonempty__items(comparison_table_rows))) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(comparison_table_heading));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo23comparison__table__html(comparison_table_columns, comparison_table_rows, keyword));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(section_two_heading));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_two_h3a));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C4", section_two_a, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_two_h3b));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C5", section_two_b, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(section_three_heading));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_three_h3a));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C6", section_three_a, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo16subheading__html(section_three_h3b));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo22claim__paragraph__html("C7", section_three_b, "", false, keyword));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(summary_heading, undefined)), "") && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(summary_body, undefined)), "")) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(summary_heading));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo26editable__paragraphs__html(summary_body, keyword));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_heading, undefined)), "") && _M0FP25apple7moonseo17has__visible__faq(faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer)) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section><h2 class=\"editable-field\" contenteditable=\"true\" spellcheck=\"false\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(faq_heading));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h2>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo15faq__item__html(faq_one_question, faq_one_answer, keyword, "C8"));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo15faq__item__html(faq_two_question, faq_two_answer, keyword, "C9"));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo15faq__item__html(faq_three_question, faq_three_answer, keyword, "C10"));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</article>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo13build__claims(intro, section_one, section_two, section_three, faq_one_answer, faq_two_answer, faq_three_answer) {
  let section_one_a;
  let section_one_b;
  _L: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_one);
    const _section_one_a = _bind._0;
    const _section_one_b = _bind._1;
    section_one_a = _section_one_a;
    section_one_b = _section_one_b;
    break _L;
  }
  let section_two_a;
  let section_two_b;
  _L$2: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_two);
    const _section_two_a = _bind._0;
    const _section_two_b = _bind._1;
    section_two_a = _section_two_a;
    section_two_b = _section_two_b;
    break _L$2;
  }
  let section_three_a;
  let section_three_b;
  _L$3: {
    const _bind = _M0FP25apple7moonseo18split__claim__pair(section_three);
    const _section_three_a = _bind._0;
    const _section_three_b = _bind._1;
    section_three_a = _section_three_a;
    section_three_b = _section_three_b;
    break _L$3;
  }
  const claims = [];
  _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor("C1", intro));
  const _bind = _M0FP25apple7moonseo17claim__subanchors("C2", section_one_a);
  const _bind$2 = _bind.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const claim = _bind[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$3 = _M0FP25apple7moonseo17claim__subanchors("C3", section_one_b);
  const _bind$4 = _bind$3.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$4) {
      const claim = _bind$3[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$5 = _M0FP25apple7moonseo17claim__subanchors("C4", section_two_a);
  const _bind$6 = _bind$5.length;
  let _tmp$3 = 0;
  while (true) {
    const _ = _tmp$3;
    if (_ < _bind$6) {
      const claim = _bind$5[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp$3 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$7 = _M0FP25apple7moonseo17claim__subanchors("C5", section_two_b);
  const _bind$8 = _bind$7.length;
  let _tmp$4 = 0;
  while (true) {
    const _ = _tmp$4;
    if (_ < _bind$8) {
      const claim = _bind$7[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp$4 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$9 = _M0FP25apple7moonseo17claim__subanchors("C6", section_three_a);
  const _bind$10 = _bind$9.length;
  let _tmp$5 = 0;
  while (true) {
    const _ = _tmp$5;
    if (_ < _bind$10) {
      const claim = _bind$9[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp$5 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$11 = _M0FP25apple7moonseo17claim__subanchors("C7", section_three_b);
  const _bind$12 = _bind$11.length;
  let _tmp$6 = 0;
  while (true) {
    const _ = _tmp$6;
    if (_ < _bind$12) {
      const claim = _bind$11[_];
      _M0MPC15array5Array4pushGsE(claims, claim);
      _tmp$6 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_one_answer, undefined)), "")) {
    _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor("C8", _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_one_answer, undefined))));
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_two_answer, undefined)), "")) {
    _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor("C9", _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_two_answer, undefined))));
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_three_answer, undefined)), "")) {
    _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor("C10", _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(faq_three_answer, undefined))));
  }
  return claims;
}
function _M0FP25apple7moonseo19build__export__html(title, meta_description, article_html, slug, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "<!DOCTYPE html><html lang=\"zh\"><head><meta charset=\"UTF-8\" />" : "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<title>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(title));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</title><meta name=\"description\" content=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(meta_description));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" /><meta name=\"slug\" content=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(slug));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" /><style>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "body{margin:0;font-family:'Helvetica Neue',Arial,sans-serif;background:#f6f0e8;color:#1e1d1a;}main{max-width:1120px;margin:0 auto;padding:48px 24px 72px;}h1,h2,h3{font-family:'Helvetica Neue',Arial,sans-serif;font-weight:800;letter-spacing:-.02em;} .layout{display:grid;grid-template-columns:1fr;gap:24px;align-items:start;} .article-card{padding:0;background:transparent;border:0;border-radius:0;} .article-card h1{margin:0 0 12px;} .article-card p{margin:0;line-height:1.62;} .article-card p+p{margin-top:14px;} section+section{margin-top:20px;} .evidence-ref{display:inline-flex;align-items:center;justify-content:center;min-width:24px;height:24px;margin-left:4px;border:0;border-radius:999px;background:rgba(155,92,29,.12);color:#9b5c1d;font-size:12px;font-weight:700;vertical-align:middle;} @media (max-width:900px){.layout{grid-template-columns:1fr;}}");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</style></head><body><main><div class=\"layout\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, article_html);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></main></body></html>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo20build__preview__html(article_html) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"preview-shell\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"preview-grid\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, article_html);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></div>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo35default__comparison__table__columns(lang) {
  return lang === "zh" ? ["对比维度", "本产品", "通用替代方案"] : ["Feature", "This option", "Generic alternative"];
}
function _M0FP25apple7moonseo15fact__or__empty(facts, index) {
  return index < facts.length ? _M0MPC15array5Array2atGsE(facts, index) : "";
}
function _M0FP25apple7moonseo22normalize__or__default(value, fallback) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(value, undefined));
  return trimmed === "" ? fallback : trimmed;
}
function _M0FP25apple7moonseo32default__comparison__table__rows(facts, brand, keyword, lang) {
  const rows = [];
  const first_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 0);
  const second_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 1);
  const third_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 2);
  const keyword_label = lang === "zh" ? _M0FP25apple7moonseo22normalize__or__default(keyword, "核心亮点") : _M0FP25apple7moonseo22normalize__or__default(keyword, "Core benefit");
  if (lang === "zh") {
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? `核心亮点 | ${_M0IPC16string6StringPB4Show10to__string(first_fact)} | 需要用户自己从零判断是否匹配需求` : `${_M0IPC16string6StringPB4Show10to__string(keyword_label)} | ${_M0IPC16string6StringPB4Show10to__string(brand)} 优先强调可验证的产品信息 | 通用替代方案往往先讲泛泛卖点`);
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") ? `使用体验 | ${_M0IPC16string6StringPB4Show10to__string(second_fact)} | 常见替代方案可能只给笼统描述` : "使用体验 | 围绕实际使用场景说明价值 | 往往缺少具体场景说明");
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "") ? `决策信息 | ${_M0IPC16string6StringPB4Show10to__string(third_fact)} | 还需要额外查找和比对` : "决策信息 | 直接指出哪些细节值得进一步确认 | 常见替代方案容易省略限制条件");
  } else {
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? `Core benefit | ${_M0IPC16string6StringPB4Show10to__string(first_fact)} | Readers often need to infer the practical benefit themselves` : `${_M0IPC16string6StringPB4Show10to__string(keyword_label)} | ${_M0IPC16string6StringPB4Show10to__string(brand)} focuses on verifiable product value | Generic alternatives often lean on broad category claims`);
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") ? `Daily use | ${_M0IPC16string6StringPB4Show10to__string(second_fact)} | Generic alternatives may stay vague about real usage` : "Daily use | Explains the experience through practical use cases | Generic alternatives may rely on softer generalities");
    _M0MPC15array5Array4pushGsE(rows, _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "") ? `Decision detail | ${_M0IPC16string6StringPB4Show10to__string(third_fact)} | Readers may need extra comparison work before deciding` : "Decision detail | Makes remaining verification points explicit | Generic alternatives often skip tradeoffs and caveats");
  }
  return rows;
}
function _M0FP25apple7moonseo20default__key__points(facts, brand, lang) {
  const items = [];
  if (facts.length > 0) {
    const limit = facts.length < 3 ? facts.length : 3;
    let _tmp = 0;
    while (true) {
      const index = _tmp;
      if (index < limit) {
        _M0MPC15array5Array4pushGsE(items, _M0MPC15array5Array2atGsE(facts, index));
        _tmp = index + 1 | 0;
        continue;
      } else {
        break;
      }
    }
  }
  return items.length === 0 ? (lang === "zh" ? [`${_M0IPC16string6StringPB4Show10to__string(brand)} 的介绍应优先围绕可验证的产品事实展开。`, "用户最关心的是实际价值、使用方式和仍需确认的细节。", "结论应保持克制，避免超出来源材料的判断。"] : [`${_M0IPC16string6StringPB4Show10to__string(brand)} should be introduced through concrete, verifiable product facts.`, "Readers care most about practical value, usability, and what still needs verification.", "The draft should stay restrained and avoid conclusions that go beyond the available sources."]) : items;
}
function _M0FP25apple7moonseo16collapse__spaces(input) {
  const _bind = "\n";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(input, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\t";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = "  ";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = " ";
  const current = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  let _tmp$6 = current;
  while (true) {
    const _param = _tmp$6;
    const next = _param;
    const _bind$7 = "  ";
    if (_M0MPC16string6String8contains(next, new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length))) {
      const _bind$8 = "  ";
      const _tmp$7 = new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length);
      const _bind$9 = " ";
      _tmp$6 = _M0MPC16string6String12replace__all(next, _tmp$7, new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length));
      continue;
    } else {
      return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(next, undefined));
    }
  }
}
function _M0FP25apple7moonseo20keyword__from__title(title) {
  const _bind = "(2026 Updated Guide)";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "";
  const _tmp$2 = _M0MPC16string6String12replace__all(title, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "(2025 Updated Guide)";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = "(2024 Updated Guide)";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = "";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = "(2026 Guide)";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = "";
  const _tmp$8 = _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _bind$9 = "(2025 Guide)";
  const _tmp$9 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = "";
  const _tmp$10 = _M0MPC16string6String12replace__all(_tmp$8, _tmp$9, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _bind$11 = "(2024 Guide)";
  const _tmp$11 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = "";
  const _tmp$12 = _M0MPC16string6String12replace__all(_tmp$10, _tmp$11, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _bind$13 = "2026 Updated Guide";
  const _tmp$13 = new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length);
  const _bind$14 = "";
  const _tmp$14 = _M0MPC16string6String12replace__all(_tmp$12, _tmp$13, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length));
  const _bind$15 = "2025 Updated Guide";
  const _tmp$15 = new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length);
  const _bind$16 = "";
  const _tmp$16 = _M0MPC16string6String12replace__all(_tmp$14, _tmp$15, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
  const _bind$17 = "2024 Updated Guide";
  const _tmp$17 = new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length);
  const _bind$18 = "";
  const _tmp$18 = _M0MPC16string6String12replace__all(_tmp$16, _tmp$17, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length));
  const _bind$19 = "2026 Guide";
  const _tmp$19 = new _M0TPC16string10StringView(_bind$19, 0, _bind$19.length);
  const _bind$20 = "";
  const _tmp$20 = _M0MPC16string6String12replace__all(_tmp$18, _tmp$19, new _M0TPC16string10StringView(_bind$20, 0, _bind$20.length));
  const _bind$21 = "2025 Guide";
  const _tmp$21 = new _M0TPC16string10StringView(_bind$21, 0, _bind$21.length);
  const _bind$22 = "";
  const _tmp$22 = _M0MPC16string6String12replace__all(_tmp$20, _tmp$21, new _M0TPC16string10StringView(_bind$22, 0, _bind$22.length));
  const _bind$23 = "2024 Guide";
  const _tmp$23 = new _M0TPC16string10StringView(_bind$23, 0, _bind$23.length);
  const _bind$24 = "";
  const _tmp$24 = _M0MPC16string6String12replace__all(_tmp$22, _tmp$23, new _M0TPC16string10StringView(_bind$24, 0, _bind$24.length));
  const _bind$25 = "Updated Guide";
  const _tmp$25 = new _M0TPC16string10StringView(_bind$25, 0, _bind$25.length);
  const _bind$26 = "";
  const _tmp$26 = _M0MPC16string6String12replace__all(_tmp$24, _tmp$25, new _M0TPC16string10StringView(_bind$26, 0, _bind$26.length));
  const _bind$27 = "Guide";
  const _tmp$27 = new _M0TPC16string10StringView(_bind$27, 0, _bind$27.length);
  const _bind$28 = "";
  const without_suffix = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC16string6String12replace__all(_tmp$26, _tmp$27, new _M0TPC16string10StringView(_bind$28, 0, _bind$28.length)), undefined));
  const _bind$29 = "()";
  const _tmp$28 = new _M0TPC16string10StringView(_bind$29, 0, _bind$29.length);
  const _bind$30 = " ";
  const _tmp$29 = _M0MPC16string6String12replace__all(without_suffix, _tmp$28, new _M0TPC16string10StringView(_bind$30, 0, _bind$30.length));
  const _bind$31 = "（";
  const _tmp$30 = new _M0TPC16string10StringView(_bind$31, 0, _bind$31.length);
  const _bind$32 = " ";
  const _tmp$31 = _M0MPC16string6String12replace__all(_tmp$29, _tmp$30, new _M0TPC16string10StringView(_bind$32, 0, _bind$32.length));
  const _bind$33 = "）";
  const _tmp$32 = new _M0TPC16string10StringView(_bind$33, 0, _bind$33.length);
  const _bind$34 = " ";
  const _tmp$33 = _M0MPC16string6String12replace__all(_tmp$31, _tmp$32, new _M0TPC16string10StringView(_bind$34, 0, _bind$34.length));
  const _bind$35 = "(";
  const _tmp$34 = new _M0TPC16string10StringView(_bind$35, 0, _bind$35.length);
  const _bind$36 = " ";
  const _tmp$35 = _M0MPC16string6String12replace__all(_tmp$33, _tmp$34, new _M0TPC16string10StringView(_bind$36, 0, _bind$36.length));
  const _bind$37 = ")";
  const _tmp$36 = new _M0TPC16string10StringView(_bind$37, 0, _bind$37.length);
  const _bind$38 = " ";
  const collapsed = _M0FP25apple7moonseo16collapse__spaces(_M0MPC16string6String12replace__all(_tmp$35, _tmp$36, new _M0TPC16string10StringView(_bind$38, 0, _bind$38.length)));
  let without_leadin;
  const _bind$39 = "Best ";
  if (_M0MPC16string6String11has__prefix(collapsed, new _M0TPC16string10StringView(_bind$39, 0, _bind$39.length))) {
    const _bind$40 = "Best ";
    const _tmp$37 = new _M0TPC16string10StringView(_bind$40, 0, _bind$40.length);
    const _bind$41 = "";
    without_leadin = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC16string6String12replace__all(collapsed, _tmp$37, new _M0TPC16string10StringView(_bind$41, 0, _bind$41.length)), undefined));
  } else {
    const _bind$40 = "Top ";
    if (_M0MPC16string6String11has__prefix(collapsed, new _M0TPC16string10StringView(_bind$40, 0, _bind$40.length))) {
      const _bind$41 = "Top ";
      const _tmp$37 = new _M0TPC16string10StringView(_bind$41, 0, _bind$41.length);
      const _bind$42 = "";
      without_leadin = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC16string6String12replace__all(collapsed, _tmp$37, new _M0TPC16string10StringView(_bind$42, 0, _bind$42.length)), undefined));
    } else {
      without_leadin = collapsed;
    }
  }
  return without_leadin === "" ? title : without_leadin;
}
function _M0FP25apple7moonseo17inferred__keyword(primary_keyword, article_title, brand_name) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(primary_keyword, undefined));
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
    return trimmed;
  }
  const title = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(article_title, undefined));
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(title, "")) {
    return _M0FP25apple7moonseo20keyword__from__title(title);
  }
  return `${_M0IPC16string6StringPB4Show10to__string(brand_name)} guide`;
}
function _M0FP25apple7moonseo13join__opening(opening_answer, opening_problem, opening_value) {
  return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(`${_M0IPC16string6StringPB4Show10to__string(opening_answer)} ${_M0IPC16string6StringPB4Show10to__string(opening_problem)} ${_M0IPC16string6StringPB4Show10to__string(opening_value)}`, undefined));
}
function _M0FP25apple7moonseo17meta__description(title, intro) {
  return _M0FP25apple7moonseo7excerpt(`${_M0IPC16string6StringPB4Show10to__string(title)}. ${_M0IPC16string6StringPB4Show10to__string(intro)}`, 155);
}
function _M0FP25apple7moonseo22safe__generated__title(keyword, audience, lang) {
  const seed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(keyword, undefined));
  if (seed === "") {
    return lang === "zh" ? "品牌概览" : "Brand Overview";
  } else {
    lang === "zh";
    return _M0FP25apple7moonseo11title__case(seed);
  }
}
function _M0FP25apple7moonseo7slugify(input) {
  const slug = new _M0TPC13ref3RefGsE(_M0MPC16string6String9to__lower(input));
  const _tmp = slug.val;
  const _bind = "'";
  const _tmp$2 = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp, _tmp$2, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _tmp$3 = slug.val;
  const _bind$3 = ":";
  const _tmp$4 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp$3, _tmp$4, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _tmp$5 = slug.val;
  const _bind$5 = ",";
  const _tmp$6 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp$5, _tmp$6, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _tmp$7 = slug.val;
  const _bind$7 = ".";
  const _tmp$8 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp$7, _tmp$8, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _tmp$9 = slug.val;
  const _bind$9 = "(";
  const _tmp$10 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp$9, _tmp$10, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _tmp$11 = slug.val;
  const _bind$11 = ")";
  const _tmp$12 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = "";
  slug.val = _M0MPC16string6String12replace__all(_tmp$11, _tmp$12, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _tmp$13 = slug.val;
  const _bind$13 = "/";
  const _tmp$14 = new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length);
  const _bind$14 = "-";
  slug.val = _M0MPC16string6String12replace__all(_tmp$13, _tmp$14, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length));
  const _tmp$15 = slug.val;
  const _bind$15 = " ";
  const _tmp$16 = new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length);
  const _bind$16 = "-";
  slug.val = _M0MPC16string6String12replace__all(_tmp$15, _tmp$16, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
  let _tmp$17 = slug.val;
  while (true) {
    const _param = _tmp$17;
    const current = _param;
    const _bind$17 = "--";
    if (_M0MPC16string6String8contains(current, new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length))) {
      const _bind$18 = "--";
      const _tmp$18 = new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length);
      const _bind$19 = "-";
      _tmp$17 = _M0MPC16string6String12replace__all(current, _tmp$18, new _M0TPC16string10StringView(_bind$19, 0, _bind$19.length));
      continue;
    } else {
      slug.val = current;
      break;
    }
  }
  const _tmp$18 = slug.val;
  const _bind$17 = "-";
  return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String12trim_2einner(_tmp$18, new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length)));
}
function _M0FP25apple7moonseo25generate__demo__localized(article_title, brand_name, primary_keyword, audience, facts_raw, lang) {
  const chinese = false;
  const safe_brand = _M0FP25apple7moonseo22normalize__or__default(brand_name, "MoonSEO");
  const safe_keyword = _M0FP25apple7moonseo17inferred__keyword(primary_keyword, article_title, safe_brand);
  const safe_audience = _M0FP25apple7moonseo22normalize__or__default(audience, "readers");
  const facts = _M0FP25apple7moonseo12parse__facts(facts_raw);
  const title = _M0FP25apple7moonseo22normalize__or__default(article_title, _M0FP25apple7moonseo22safe__generated__title(safe_keyword, safe_audience, "en"));
  const slug = _M0FP25apple7moonseo7slugify(title);
  const first_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 0);
  const second_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 1);
  const third_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 2);
  const opening_answer = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} stands out when the article answers the core question quickly and stays anchored in concrete product details readers can verify.` : `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} needs a careful draft that answers the main question directly without drifting into unsupported marketing language.`;
  const opening_problem = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? `${_M0IPC16string6StringPB4Show10to__string(safe_audience)} usually need clear proof of value, a simple explanation of how the experience works, and enough context to judge whether the product fits their needs.` : `${_M0IPC16string6StringPB4Show10to__string(safe_audience)} still need a practical overview of what matters most, even when the supporting source material has not been fully added yet.`;
  const opening_value = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? "This guide uses the approved source material to show what matters most, how the experience works, and which details deserve a closer look before deciding." : "This draft therefore stays conservative, focuses on the safest practical takeaways, and leaves room for later verification once real source material is available.";
  const opening = _M0FP25apple7moonseo13join__opening(opening_answer, opening_problem, opening_value);
  const section_one_heading = chinese ? "品牌概览" : `What ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} offers`;
  const section_two_heading = chinese ? "使用体验" : "How the experience works";
  const section_three_heading = chinese ? "补充说明" : "What readers should verify";
  const key_points_heading = chinese ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 的关键亮点` : `Key reasons to consider ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}`;
  const comparison_table_heading = chinese ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 对比速览` : "Quick comparison view";
  const summary_heading = chinese ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 更适合哪些人` : `Where ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} fits best`;
  const faq_heading = chinese ? "常见问题" : "Frequently asked questions";
  const section_one = _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? `The clearest way to introduce ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} is to stay close to the product facts readers can verify. One concrete detail already available is: ${_M0IPC16string6StringPB4Show10to__string(first_fact)}. That gives the article a grounded starting point and keeps the opening focused on actual value instead of vague claims.` : `The opening section should explain what ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} helps users do and why that matters in practice. Without concrete source facts, the copy should stay careful, specific, and free of broad promises.`;
  const section_two = _M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") && _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "") ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} becomes more credible when the article explains how the experience works in concrete terms. Here, the available materials point to details such as ${_M0IPC16string6StringPB4Show10to__string(second_fact)} and ${_M0IPC16string6StringPB4Show10to__string(third_fact)}. Framing those points as practical user-facing benefits creates a clearer and more believable middle section.` : _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? "The middle section should translate the available product facts into a practical experience readers can picture. It should stay close to what the source material actually supports, rather than stretching those facts into category-wide claims." : "The middle section should focus on concrete usage and practical value, while avoiding any details the source material cannot support yet. This keeps the draft useful without pretending the missing evidence already exists.";
  const section_three = _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") || (_M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") || _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "")) ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} becomes more convincing when the article closes by separating clearly supported value from details that may still vary by user, merchant, or region. A careful final section can reinforce the strongest product advantages, explain who is most likely to benefit, and point out the main limitation readers should confirm before they rely on it.` : `Even without dense source coverage, ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} can still be presented responsibly by gathering the clearest takeaways and naming the limits of what is currently confirmed. That kind of ending helps readers leave with a practical impression instead of a sweeping claim that the materials cannot yet support.`;
  const summary_body = _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") || (_M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") || _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "")) ? `For readers comparing options, ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} becomes easier to judge when its practical value and everyday usage model are considered together. That makes the final section less about repeating claims and more about clarifying who will actually benefit most.\n\nThe most useful takeaway is usually the fit between the product's strongest supported advantages and the reader's real buying habits. If one key limitation or verification point still matters, this is the right place to surface it plainly before the FAQ.` : `Before readers move into FAQs, ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} benefits from one last section that gathers the clearest practical value in plain language. That helps the article land on a usable decision point instead of trailing off.\n\nIf some details still need confirmation, they should be framed as a practical reminder rather than a dramatic warning. Readers can then leave with a grounded sense of whether the product is worth exploring further.`;
  const key_points_items = _M0FP25apple7moonseo20default__key__points(facts, safe_brand, "en");
  const comparison_table_columns = _M0FP25apple7moonseo35default__comparison__table__columns("en");
  const comparison_table_rows = _M0FP25apple7moonseo32default__comparison__table__rows(facts, safe_brand, safe_keyword, "en");
  const faq_one_question = chinese ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 适合追求即时返现的用户吗？` : `Is ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} a strong fit for users who want immediate cashback?`;
  const faq_one_answer = chinese ? "是。只要来源事实已经支持即时返现、余额可见或下单抵扣，这些就足以说明它适合更关注实际价值的用户。" : "Yes. When the sources already support instant cashback, visible balances, or checkout value, those facts are enough to show why it fits readers who care about practical savings.";
  const faq_two_question = chinese ? `使用 ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 前还有哪些细节需要确认？` : `Are there still any details readers should verify before using ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}?`;
  const faq_two_answer = chinese ? "是。商户覆盖、地区差异、支付方式和余额使用限制等细节，如果来源没有完全写清楚，就应提醒读者进一步确认。" : "Yes. Merchant coverage, regional differences, payment options, and balance limitations should still be verified whenever the available sources do not fully confirm them.";
  const faq_three_question = chinese ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 的核心价值是否已经足够明确？` : `Is ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}'s core value proposition already clear from the available sources?`;
  const faq_three_answer = chinese ? "是。只要来源事实已经说明返现机制、余额可见性或使用便利性，这些信息就足以支撑一篇围绕实际价值展开的品牌文章。" : "Yes. When the sources already explain cashback, balance visibility, or practical usability, those points are enough to support a value-led brand article.";
  const claims = _M0FP25apple7moonseo13build__claims(opening, section_one, section_two, section_three, faq_one_answer, faq_two_answer, faq_three_answer);
  const article_html = _M0FP25apple7moonseo24build__ai__article__html(title, opening_answer, opening_problem, opening_value, section_one_heading, section_one, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, section_two_heading, section_two, section_three_heading, section_three, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer, safe_keyword, lang);
  const description = _M0FP25apple7moonseo17meta__description(title, opening);
  const preview_html = _M0FP25apple7moonseo20build__preview__html(article_html);
  const plain_text = `${_M0IPC16string6StringPB4Show10to__string(title)} ${_M0IPC16string6StringPB4Show10to__string(opening)} ${_M0IPC16string6StringPB4Show10to__string(section_one)} ${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo11join__slice(key_points_items, 0, key_points_items.length))} ${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo11join__slice(comparison_table_rows, 0, comparison_table_rows.length))} ${_M0IPC16string6StringPB4Show10to__string(section_two)} ${_M0IPC16string6StringPB4Show10to__string(section_three)} ${_M0IPC16string6StringPB4Show10to__string(summary_body)} ${_M0IPC16string6StringPB4Show10to__string(faq_one_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_one_answer)} ${_M0IPC16string6StringPB4Show10to__string(faq_two_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_two_answer)} ${_M0IPC16string6StringPB4Show10to__string(faq_three_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_three_answer)}`;
  const draft = new _M0TP25apple7moonseo5Draft(title, slug, description, article_html, "", preview_html, _M0FP25apple7moonseo19build__export__html(title, description, article_html, slug, lang), plain_text, safe_keyword, facts.length, claims);
  const report = _M0FP25apple7moonseo12audit__draft(draft, lang);
  return { _0: draft, _1: report };
}
function _M0FP25apple7moonseo24clamp__meta__description(candidate, title, opening) {
  const normalized = _M0FP25apple7moonseo22normalize__or__default(candidate, _M0FP25apple7moonseo17meta__description(title, opening));
  const clipped = _M0FP25apple7moonseo7excerpt(normalized, 155);
  return clipped.length < 110 ? _M0FP25apple7moonseo17meta__description(title, opening) : clipped;
}
function _M0FP25apple7moonseo37notes__request__no__comparison__table(notes_raw) {
  const notes = _M0MPC16string6String9to__lower(notes_raw);
  const _bind = "不要表格";
  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    return true;
  } else {
    let _tmp;
    const _bind$2 = "不需要表格";
    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      _tmp = true;
    } else {
      let _tmp$2;
      const _bind$3 = "不要对比表";
      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$2 = true;
      } else {
        let _tmp$3;
        const _bind$4 = "不需要对比表";
        if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          _tmp$3 = true;
        } else {
          let _tmp$4;
          const _bind$5 = "不要比较表";
          if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
            _tmp$4 = true;
          } else {
            let _tmp$5;
            const _bind$6 = "no table";
            if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
              _tmp$5 = true;
            } else {
              let _tmp$6;
              const _bind$7 = "no tables";
              if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length))) {
                _tmp$6 = true;
              } else {
                let _tmp$7;
                const _bind$8 = "without table";
                if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length))) {
                  _tmp$7 = true;
                } else {
                  let _tmp$8;
                  const _bind$9 = "without tables";
                  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length))) {
                    _tmp$8 = true;
                  } else {
                    let _tmp$9;
                    const _bind$10 = "no comparison table";
                    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length))) {
                      _tmp$9 = true;
                    } else {
                      let _tmp$10;
                      const _bind$11 = "no comparison chart";
                      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length))) {
                        _tmp$10 = true;
                      } else {
                        const _bind$12 = "do not include a table";
                        _tmp$10 = _M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
                      }
                      _tmp$9 = _tmp$10;
                    }
                    _tmp$8 = _tmp$9;
                  }
                  _tmp$7 = _tmp$8;
                }
                _tmp$6 = _tmp$7;
              }
              _tmp$5 = _tmp$6;
            }
            _tmp$4 = _tmp$5;
          }
          _tmp$3 = _tmp$4;
        }
        _tmp$2 = _tmp$3;
      }
      _tmp = _tmp$2;
    }
    return _tmp;
  }
}
function _M0FP25apple7moonseo23notes__request__no__faq(notes_raw) {
  const notes = _M0MPC16string6String9to__lower(notes_raw);
  const _bind = "不要faq";
  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    return true;
  } else {
    let _tmp;
    const _bind$2 = "不需要faq";
    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      _tmp = true;
    } else {
      let _tmp$2;
      const _bind$3 = "不要常见问题";
      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$2 = true;
      } else {
        let _tmp$3;
        const _bind$4 = "不需要常见问题";
        if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          _tmp$3 = true;
        } else {
          let _tmp$4;
          const _bind$5 = "no faq";
          if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
            _tmp$4 = true;
          } else {
            let _tmp$5;
            const _bind$6 = "no faqs";
            if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
              _tmp$5 = true;
            } else {
              let _tmp$6;
              const _bind$7 = "without faq";
              if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length))) {
                _tmp$6 = true;
              } else {
                let _tmp$7;
                const _bind$8 = "without faqs";
                if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length))) {
                  _tmp$7 = true;
                } else {
                  const _bind$9 = "no frequently asked questions";
                  _tmp$7 = _M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length));
                }
                _tmp$6 = _tmp$7;
              }
              _tmp$5 = _tmp$6;
            }
            _tmp$4 = _tmp$5;
          }
          _tmp$3 = _tmp$4;
        }
        _tmp$2 = _tmp$3;
      }
      _tmp = _tmp$2;
    }
    return _tmp;
  }
}
function _M0FP25apple7moonseo31notes__request__no__key__points(notes_raw) {
  const notes = _M0MPC16string6String9to__lower(notes_raw);
  const _bind = "不要列表";
  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    return true;
  } else {
    let _tmp;
    const _bind$2 = "不需要列表";
    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      _tmp = true;
    } else {
      let _tmp$2;
      const _bind$3 = "不要bullet";
      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$2 = true;
      } else {
        let _tmp$3;
        const _bind$4 = "不要 bullet";
        if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          _tmp$3 = true;
        } else {
          let _tmp$4;
          const _bind$5 = "不要key points";
          if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length))) {
            _tmp$4 = true;
          } else {
            let _tmp$5;
            const _bind$6 = "不要 key points";
            if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length))) {
              _tmp$5 = true;
            } else {
              let _tmp$6;
              const _bind$7 = "no bullet";
              if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length))) {
                _tmp$6 = true;
              } else {
                let _tmp$7;
                const _bind$8 = "no bullets";
                if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length))) {
                  _tmp$7 = true;
                } else {
                  let _tmp$8;
                  const _bind$9 = "no bullet points";
                  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length))) {
                    _tmp$8 = true;
                  } else {
                    let _tmp$9;
                    const _bind$10 = "without bullet";
                    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length))) {
                      _tmp$9 = true;
                    } else {
                      let _tmp$10;
                      const _bind$11 = "without bullet points";
                      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length))) {
                        _tmp$10 = true;
                      } else {
                        let _tmp$11;
                        const _bind$12 = "no key points";
                        if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length))) {
                          _tmp$11 = true;
                        } else {
                          let _tmp$12;
                          const _bind$13 = "without key points";
                          if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length))) {
                            _tmp$12 = true;
                          } else {
                            let _tmp$13;
                            const _bind$14 = "no list";
                            if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length))) {
                              _tmp$13 = true;
                            } else {
                              const _bind$15 = "without list";
                              _tmp$13 = _M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length));
                            }
                            _tmp$12 = _tmp$13;
                          }
                          _tmp$11 = _tmp$12;
                        }
                        _tmp$10 = _tmp$11;
                      }
                      _tmp$9 = _tmp$10;
                    }
                    _tmp$8 = _tmp$9;
                  }
                  _tmp$7 = _tmp$8;
                }
                _tmp$6 = _tmp$7;
              }
              _tmp$5 = _tmp$6;
            }
            _tmp$4 = _tmp$5;
          }
          _tmp$3 = _tmp$4;
        }
        _tmp$2 = _tmp$3;
      }
      _tmp = _tmp$2;
    }
    return _tmp;
  }
}
function _M0FP25apple7moonseo13contains__cjk(input) {
  const _it = _M0MPC16string6String4iter(input);
  while (true) {
    let scalar;
    _L: {
      const _bind = _M0MPB4Iter4nextGcE(_it);
      if (_bind === -1) {
        break;
      } else {
        const _Some = _bind;
        const _scalar = _Some;
        scalar = _scalar;
        break _L;
      }
    }
    const code = scalar;
    if (code >= 19968 && code <= 40959 || (code >= 13312 && code <= 19903 || code >= 12288 && code <= 12351)) {
      return true;
    }
    continue;
  }
  return false;
}
function _M0FP25apple7moonseo14payload__value(parts, index, fallback) {
  return index < parts.length ? _M0FP25apple7moonseo22normalize__or__default(_M0MPC15array5Array2atGsE(parts, index), fallback) : fallback;
}
function _M0FP25apple7moonseo25payload__value__for__lang(parts, index, fallback, lang) {
  const value = _M0FP25apple7moonseo14payload__value(parts, index, fallback);
  return lang === "en" && _M0FP25apple7moonseo13contains__cjk(value) ? fallback : value;
}
function _M0FP25apple7moonseo25payload__lines__for__lang(parts, index, fallback, lang) {
  const fallback_joined = _M0FP25apple7moonseo11join__slice(fallback, 0, fallback.length);
  const value = _M0FP25apple7moonseo25payload__value__for__lang(parts, index, fallback_joined, lang);
  const lines = [];
  const _bind = "\n";
  const _it = _M0MPC16string6String5split(value, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let line;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _line = _Some;
        line = _line;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(line), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(current, "")) {
      _M0MPC15array5Array4pushGsE(lines, current);
    }
    continue;
  }
  return lines.length === 0 ? fallback : lines;
}
function _M0FP25apple7moonseo23requested__output__lang(notes_raw) {
  const notes = _M0MPC16string6String9to__lower(notes_raw);
  let _tmp;
  const _bind = "简体中文";
  if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind, 0, _bind.length))) {
    _tmp = true;
  } else {
    let _tmp$2;
    const _bind$2 = "中文";
    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
      _tmp$2 = true;
    } else {
      let _tmp$3;
      const _bind$3 = "汉语";
      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$3 = true;
      } else {
        let _tmp$4;
        const _bind$4 = "chinese";
        if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length))) {
          _tmp$4 = true;
        } else {
          const _bind$5 = "mandarin";
          _tmp$4 = _M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length));
        }
        _tmp$3 = _tmp$4;
      }
      _tmp$2 = _tmp$3;
    }
    _tmp = _tmp$2;
  }
  if (_tmp) {
    return "zh";
  } else {
    const _bind$2 = "英文";
    if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length))) {
    } else {
      let _tmp$2;
      const _bind$3 = "英语";
      if (_M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length))) {
        _tmp$2 = true;
      } else {
        const _bind$4 = "english";
        _tmp$2 = _M0MPC16string6String8contains(notes, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
      }
      _tmp$2;
    }
    return "en";
  }
}
function _M0FP25apple7moonseo26sanitize__generated__title(candidate, keyword, audience, lang) {
  const normalized = _M0FP25apple7moonseo22normalize__or__default(candidate, _M0FP25apple7moonseo22safe__generated__title(keyword, audience, lang));
  return _M0FP25apple7moonseo24contains__banned__claims(normalized) || normalized.length < 24 ? _M0FP25apple7moonseo22safe__generated__title(keyword, audience, lang) : normalized;
}
function _M0FP25apple7moonseo29generate__ai__demo__localized(article_title, brand_name, primary_keyword, audience, facts_raw, notes_raw, ai_payload, lang) {
  const output_lang = _M0FP25apple7moonseo23requested__output__lang(notes_raw);
  const chinese_output = output_lang === "zh";
  const omit_faq = _M0FP25apple7moonseo23notes__request__no__faq(notes_raw);
  const omit_key_points = _M0FP25apple7moonseo31notes__request__no__key__points(notes_raw);
  const omit_comparison_table = _M0FP25apple7moonseo37notes__request__no__comparison__table(notes_raw);
  const safe_brand = _M0FP25apple7moonseo22normalize__or__default(brand_name, "MoonSEO");
  const safe_keyword = _M0FP25apple7moonseo17inferred__keyword(primary_keyword, article_title, safe_brand);
  const safe_audience = _M0FP25apple7moonseo22normalize__or__default(audience, "readers");
  const facts = _M0FP25apple7moonseo12parse__facts(facts_raw);
  const parts = [];
  const _bind = "\u001f";
  const _it = _M0MPC16string6String5split(ai_payload, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let part;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    _M0MPC15array5Array4pushGsE(parts, _M0IPC16string10StringViewPB4Show10to__string(part));
    continue;
  }
  const first_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 0);
  const second_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 1);
  const third_fact = _M0FP25apple7moonseo15fact__or__empty(facts, 2);
  const opening_answer_fallback = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? (chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 更适合用结论先行的方式来介绍，这样读者能立刻明白它是否值得进一步了解。` : `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} is strongest when the article answers the core question immediately and stays anchored in concrete product value.`) : chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 需要一篇谨慎、具体、可信的品牌文章，而不是没有依据的营销文案。` : `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} needs a careful, specific, credible article rather than unsupported marketing copy.`;
  const opening_problem_fallback = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? (chinese_output ? "对大多数读者来说，真正重要的不是空泛卖点，而是它提供了什么、怎么用、以及是否适合自己的场景。" : "Readers care less about generic category hype and more about what it offers, how it works, and whether it fits their real shopping needs.") : chinese_output ? "在真实来源还不充分时，读者仍然需要一份围绕核心问题展开、而不是泛泛铺陈的概览。" : "Even when source support is still thin, readers still need a practical answer to the main question instead of vague setup copy.";
  const opening_value_fallback = _M0FP25apple7moonseo18has__real__sources(facts_raw) ? (chinese_output ? `这篇文章会基于现有来源材料，帮助读者快速看清 ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 的核心价值、使用方式以及仍需确认的细节。` : `This guide uses the available source material to show ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}'s core value, explain the experience clearly, and highlight the details readers should still verify.`) : chinese_output ? "因此草稿会先聚焦最可靠的结论，再明确哪些信息仍待核实。" : "The draft therefore focuses on the safest practical takeaways first and stays explicit about what still needs verification.";
  const section_one_heading_fallback = chinese_output ? "品牌概览" : `What ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} offers`;
  const section_two_heading_fallback = chinese_output ? "使用体验" : "How the experience works";
  const section_three_heading_fallback = chinese_output ? "补充说明" : "What readers should verify";
  const key_points_heading_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 的关键亮点` : `Key reasons to consider ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}`;
  const comparison_table_heading_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 对比速览` : "Quick comparison view";
  const summary_heading_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 更适合哪些人` : `Where ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} fits best`;
  const faq_heading_fallback = chinese_output ? "常见问题" : "Frequently asked questions";
  const section_one_body_fallback = chinese_output && _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? `介绍 ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 时，最重要的是先说清楚它到底提供了什么，而不是写成空泛的品类介绍。当前可确认的一条来源事实是：${_M0IPC16string6StringPB4Show10to__string(first_fact)}。这能帮助草稿在开头建立一个更可信、更具体的切入点。` : chinese_output ? `介绍 ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 时，最重要的是先说清楚它到底提供了什么，而不是写成空泛的品类介绍。在来源材料还不充分时，草稿应先围绕最实用、最容易被验证的信息展开。` : _M0IP016_24default__implPB2Eq10not__equalGsE(first_fact, "") ? `The opening section should explain what ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} actually offers instead of drifting into generic category language. One concrete source detail already available is: ${_M0IPC16string6StringPB4Show10to__string(first_fact)}. Using that detail as the starting point keeps the article grounded and specific.` : `The opening section should explain what ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} helps readers do in practical terms, while avoiding details the sources cannot support yet. That gives the draft a clear point of view without overclaiming.`;
  const section_two_body_fallback = chinese_output && (_M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") && _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "")) ? `中间部分应把产品体验写得更具体，同时紧扣已知来源。当前材料里已经出现了这些细节：${_M0IPC16string6StringPB4Show10to__string(second_fact)}；${_M0IPC16string6StringPB4Show10to__string(third_fact)}。把这些信息转成清晰的用户价值，会让文章比空泛的卖点描述更可信。` : chinese_output ? "中间部分应把产品体验写得更具体，同时紧扣已知来源。只要某些结论还没有明确依据，就应保持保守表达，不要把备注、判断或猜测写成既成事实。" : _M0IP016_24default__implPB2Eq10not__equalGsE(second_fact, "") && _M0IP016_24default__implPB2Eq10not__equalGsE(third_fact, "") ? `The middle section should make the experience more concrete while staying close to the sources. The available material already points to details such as ${_M0IPC16string6StringPB4Show10to__string(second_fact)} and ${_M0IPC16string6StringPB4Show10to__string(third_fact)}. Translating those into practical user-facing benefits creates a more believable draft.` : "The middle section should make the experience more concrete while staying close to the sources. When support is still thin, the copy should remain explicit about what is known and avoid turning notes or guesses into facts.";
  const section_three_body_fallback = chinese_output ? "把文章收束得自然，关键在于把已经明确的价值和仍需确认的限制分开说明。这样既能再次强调最可靠的卖点，也能提醒读者关注适用条件、使用边界或地区差异，让判断更稳妥。" : "The article lands better when it separates clearly supported value from the details that may still depend on setup, region, or user needs. That gives readers a grounded final impression, reinforces the strongest takeaways, and leaves room for the practical caution a careful buyer would expect.";
  const summary_body_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 是否值得继续了解，往往取决于读者能否在 FAQ 前快速抓住核心价值和适用人群。把这些重点收拢成一个贴主题的小节，会让判断更直接。\n\n如果仍有需要确认的限制，也应该在这里顺手点明，但不要写成空泛结论。这样读者在进入 FAQ 前，就已经知道自己最该关注什么。` : `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} becomes easier to evaluate when the article pauses before the FAQ and gathers the strongest supported takeaways around fit and value. That gives readers a more useful checkpoint than a generic wrap-up.\n\nIf there is one limitation or verification point worth remembering, it should appear here in plain language. The result feels more like decision guidance and less like a formal conclusion.`;
  const key_points_items_fallback = _M0FP25apple7moonseo20default__key__points(facts, safe_brand, output_lang);
  const comparison_table_columns_fallback = _M0FP25apple7moonseo35default__comparison__table__columns(output_lang);
  const comparison_table_rows_fallback = _M0FP25apple7moonseo32default__comparison__table__rows(facts, safe_brand, safe_keyword, output_lang);
  const faq_one_question_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 适合重视即时价值的用户吗？` : `Is ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} a good fit for readers who care about immediate value?`;
  const faq_one_answer_fallback = chinese_output ? "是。只要来源事实能支撑即时返现、余额可见或下单抵扣，这些就已经构成了对用户最有感知的价值。" : "Yes. When the sources support instant cashback, visible balances, or checkout value, those are already meaningful benefits for readers who care about practical savings.";
  const faq_two_question_fallback = chinese_output ? `选择 ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 前还需要确认哪些信息？` : `What should readers still confirm before choosing ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}?`;
  const faq_two_answer_fallback = chinese_output ? "需要确认。商户范围、地区差异、支付方式和余额使用限制等信息，只要来源没有完全覆盖，就应提醒读者再核实。" : "Readers should still confirm merchant coverage, regional differences, payment options, and balance limitations whenever those details are not fully established by the sources.";
  const faq_three_question_fallback = chinese_output ? `${_M0IPC16string6StringPB4Show10to__string(safe_brand)} 的优势是否已经足够清楚？` : `Is ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}'s main advantage already clear from the available material?`;
  const faq_three_answer_fallback = chinese_output ? "是。只要返现机制、使用便利性和余额可见性已经被来源事实说明清楚，就足以形成一篇围绕实际价值展开的文章。" : "Yes. When cashback, usability, and balance visibility are already supported by the sources, they are enough to anchor a value-led article.";
  const raw_ai_title = _M0FP25apple7moonseo25payload__value__for__lang(parts, 0, _M0FP25apple7moonseo22safe__generated__title(safe_keyword, safe_audience, output_lang), output_lang);
  const opening_answer = _M0FP25apple7moonseo25payload__value__for__lang(parts, 2, opening_answer_fallback, output_lang);
  const opening_problem = _M0FP25apple7moonseo25payload__value__for__lang(parts, 3, opening_problem_fallback, output_lang);
  const opening_value = _M0FP25apple7moonseo25payload__value__for__lang(parts, 4, opening_value_fallback, output_lang);
  const opening = _M0FP25apple7moonseo13join__opening(opening_answer, opening_problem, opening_value);
  const ai_title = _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(article_title, undefined)), "") ? _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(article_title, undefined)) : _M0FP25apple7moonseo26sanitize__generated__title(raw_ai_title, safe_keyword, safe_audience, output_lang);
  const ai_meta = _M0FP25apple7moonseo24clamp__meta__description(_M0FP25apple7moonseo25payload__value__for__lang(parts, 1, _M0FP25apple7moonseo17meta__description(ai_title, opening), output_lang), ai_title, opening);
  const section_one_heading = _M0FP25apple7moonseo25payload__value__for__lang(parts, 5, section_one_heading_fallback, output_lang);
  const section_one_body = _M0FP25apple7moonseo25payload__value__for__lang(parts, 6, section_one_body_fallback, output_lang);
  const section_two_heading = _M0FP25apple7moonseo25payload__value__for__lang(parts, 7, section_two_heading_fallback, output_lang);
  const section_two_body = _M0FP25apple7moonseo25payload__value__for__lang(parts, 8, section_two_body_fallback, output_lang);
  const section_three_heading = _M0FP25apple7moonseo25payload__value__for__lang(parts, 9, section_three_heading_fallback, output_lang);
  const section_three_body = _M0FP25apple7moonseo25payload__value__for__lang(parts, 10, section_three_body_fallback, output_lang);
  const key_points_heading = omit_key_points ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 11, key_points_heading_fallback, output_lang);
  const key_points_items = omit_key_points ? [] : _M0FP25apple7moonseo25payload__lines__for__lang(parts, 12, key_points_items_fallback, output_lang);
  const comparison_table_heading = omit_comparison_table ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 13, comparison_table_heading_fallback, output_lang);
  const comparison_table_columns = omit_comparison_table ? [] : _M0FP25apple7moonseo25payload__lines__for__lang(parts, 14, comparison_table_columns_fallback, output_lang);
  const comparison_table_rows = omit_comparison_table ? [] : _M0FP25apple7moonseo25payload__lines__for__lang(parts, 15, comparison_table_rows_fallback, output_lang);
  const summary_heading = _M0FP25apple7moonseo25payload__value__for__lang(parts, 16, summary_heading_fallback, output_lang);
  const summary_body = _M0FP25apple7moonseo25payload__value__for__lang(parts, 17, summary_body_fallback, output_lang);
  const faq_heading = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 18, faq_heading_fallback, output_lang);
  const faq_one_question = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 19, faq_one_question_fallback, output_lang);
  const faq_one_answer = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 20, faq_one_answer_fallback, output_lang);
  const faq_two_question = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 21, faq_two_question_fallback, output_lang);
  const faq_two_answer = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 22, faq_two_answer_fallback, output_lang);
  const faq_three_question = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 23, faq_three_question_fallback, output_lang);
  const faq_three_answer = omit_faq ? "" : _M0FP25apple7moonseo25payload__value__for__lang(parts, 24, faq_three_answer_fallback, output_lang);
  const claims = _M0FP25apple7moonseo13build__claims(opening, section_one_body, section_two_body, section_three_body, faq_one_answer, faq_two_answer, faq_three_answer);
  const article_html = _M0FP25apple7moonseo24build__ai__article__html(ai_title, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, section_two_heading, section_two_body, section_three_heading, section_three_body, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer, safe_keyword, lang);
  const plain_text = `${_M0IPC16string6StringPB4Show10to__string(ai_title)} ${_M0IPC16string6StringPB4Show10to__string(opening)} ${_M0IPC16string6StringPB4Show10to__string(section_one_body)} ${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo11join__slice(key_points_items, 0, key_points_items.length))} ${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo11join__slice(comparison_table_rows, 0, comparison_table_rows.length))} ${_M0IPC16string6StringPB4Show10to__string(section_two_body)} ${_M0IPC16string6StringPB4Show10to__string(section_three_body)} ${_M0IPC16string6StringPB4Show10to__string(summary_body)} ${_M0IPC16string6StringPB4Show10to__string(faq_one_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_one_answer)} ${_M0IPC16string6StringPB4Show10to__string(faq_two_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_two_answer)} ${_M0IPC16string6StringPB4Show10to__string(faq_three_question)} ${_M0IPC16string6StringPB4Show10to__string(faq_three_answer)}`;
  const draft = new _M0TP25apple7moonseo5Draft(ai_title, _M0FP25apple7moonseo7slugify(ai_title), ai_meta, article_html, "", _M0FP25apple7moonseo20build__preview__html(article_html), _M0FP25apple7moonseo19build__export__html(ai_title, ai_meta, article_html, _M0FP25apple7moonseo7slugify(ai_title), lang), plain_text, safe_keyword, facts.length, claims);
  const report = _M0FP25apple7moonseo12audit__draft(draft, lang);
  return { _0: draft, _1: report };
}
function _M0FP25apple7moonseo22audit__report__for__ui(draft, lang) {
  return _M0FP25apple7moonseo12audit__draft(draft, lang);
}
function _M0FP25apple7moonseo28audit__report__for__rendered(title, meta_description, slug, article_html, plain_text, keyword, evidence_count, lang) {
  return _M0FP25apple7moonseo12audit__draft(new _M0TP25apple7moonseo5Draft(title, slug, meta_description, article_html, "", "", "", plain_text, keyword, evidence_count, []), lang);
}
function _M0FP25apple7moonseo31claim__review__report__snapshot(supported_count, needs_review_count, unsupported_count, total_count, audit_available, findings_html) {
  return new _M0TP25apple7moonseo17ClaimReviewReport(supported_count, needs_review_count, unsupported_count, total_count, audit_available, "", findings_html);
}
function _M0FP25apple7moonseo30claim__anchors__from__snapshot(payload) {
  const claims = [];
  const _bind = "\u001e";
  const _it = _M0MPC16string6String5split(payload, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let record;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _record = _Some;
        record = _record;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(record, undefined));
    if (current === "") {
      continue;
    }
    const fields = [];
    const _bind$2 = "\u001f";
    const _it$2 = _M0MPC16string6String5split(current, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
    while (true) {
      let field;
      _L$2: {
        const _bind$3 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it$2);
        if (_bind$3 === undefined) {
          break;
        } else {
          const _Some = _bind$3;
          const _field = _Some;
          field = _field;
          break _L$2;
        }
      }
      _M0MPC15array5Array4pushGsE(fields, _M0IPC16string10StringViewPB4Show10to__string(field));
      continue;
    }
    if (fields.length >= 2) {
      const claim_id = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 0), undefined));
      const claim_text = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 1), undefined));
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(claim_id, "") && _M0IP016_24default__implPB2Eq10not__equalGsE(claim_text, "")) {
        _M0MPC15array5Array4pushGsE(claims, new _M0TP25apple7moonseo11ClaimAnchor(claim_id, claim_text));
      }
    }
    continue;
  }
  return claims;
}
function _M0FP25apple7moonseo28empty__claim__review__report(total_count, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  return new _M0TP25apple7moonseo17ClaimReviewReport(0, 0, 0, total_count, true, "", chinese ? "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>等待 AI 审阅</strong><span>待生成</span></div><p>当前仅显示 MoonBit 的规则检查。生成草稿后，系统会补充逐条 claim 的语义审查结果。</p></article></div></section>" : "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Waiting for AI review</strong><span>Pending</span></div><p>Only the deterministic MoonBit checks are visible for now. After draft generation, the system adds semantic claim-level review here.</p></article></div></section>");
}
function _M0FP25apple7moonseo30loading__claim__review__report(total_count, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  return new _M0TP25apple7moonseo17ClaimReviewReport(0, 0, 0, total_count, true, "", chinese ? "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>正在审阅关键 claim</strong><span>进行中</span></div><p>请稍候，系统正在将草稿中的核心事实表述与已上传资料进行语义比对。</p></article></div></section>" : "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Reviewing key claims</strong><span>In progress</span></div><p>Please wait while the system compares the draft's core factual claims against the uploaded source materials.</p></article></div></section>");
}
function _M0FP25apple7moonseo29failed__claim__review__report(message, total_count, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const localized_message = _M0FP25apple7moonseo20localized__ai__error(message, lang);
  const retry_button = chinese ? "<button type=\"button\" class=\"claim-review-retry secondary\">重试 claim 审计</button>" : "<button type=\"button\" class=\"claim-review-retry secondary\">Retry claim review</button>";
  return new _M0TP25apple7moonseo17ClaimReviewReport(0, 0, 0, total_count, true, "", chinese ? `<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim 审阅暂不可用</strong><span>待重试</span></div><p>${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo12escape__html(localized_message))}</p>${_M0IPC16string6StringPB4Show10to__string(retry_button)}</article></div></section>` : `<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>AI claim review unavailable</strong><span>Retry needed</span></div><p>${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo12escape__html(localized_message))}</p>${_M0IPC16string6StringPB4Show10to__string(retry_button)}</article></div></section>`);
}
function _M0FP25apple7moonseo35insufficient__claim__review__report(lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  return new _M0TP25apple7moonseo17ClaimReviewReport(0, 0, 0, 0, false, "", chinese ? "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>资料不足，无法做事实支撑审计</strong><span>待补充</span></div><p>请上传 fact sheet，或填写官网 URL 让系统抓取官网正文，再进行逐条事实支撑审计。</p></article></div></section>" : "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\"><article class=\"audit-item warn\"><div class=\"audit-top\"><strong>Insufficient sources for fact-grounding audit</strong><span>Add sources</span></div><p>Upload a fact sheet or enter a website URL so the app can fetch website copy before running claim-by-claim review.</p></article></div></section>");
}
function _M0FP25apple7moonseo16numbered__claims(claims) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < claims.length) {
      const claim = _M0MPC15array5Array2atGsE(claims, index);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, claim.id);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, ": ");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, claim.text);
      if ((index + 1 | 0) < claims.length) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "\n");
      }
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo15numbered__facts(facts) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < facts.length) {
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "[");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0IP016_24default__implPB4Show10to__stringGiE(index + 1 | 0));
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "] ");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPC15array5Array2atGsE(facts, index));
      if ((index + 1 | 0) < facts.length) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "\n");
      }
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo28build__claim__review__prompt(article_title, brand_name, primary_keyword, audience, facts_raw, notes_raw, claims, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const safe_brand = _M0FP25apple7moonseo22normalize__or__default(brand_name, "MoonSEO");
  const safe_keyword = _M0FP25apple7moonseo17inferred__keyword(primary_keyword, article_title, safe_brand);
  const safe_audience = _M0FP25apple7moonseo22normalize__or__default(audience, "general readers");
  const safe_title = _M0FP25apple7moonseo22normalize__or__default(article_title, _M0FP25apple7moonseo22safe__generated__title(safe_keyword, safe_audience, lang));
  const facts = _M0FP25apple7moonseo12parse__facts(facts_raw);
  const notes = _M0FP25apple7moonseo12parse__facts(notes_raw);
  const fact_lines = facts.length === 0 ? (chinese ? "（没有可审计的来源材料）" : "(no source materials available for audit)") : _M0FP25apple7moonseo15numbered__facts(facts);
  const note_lines = notes.length === 0 ? (chinese ? "（没有额外写作要求）" : "(no additional writing instructions)") : _M0FP25apple7moonseo15numbered__facts(notes);
  const claim_lines = _M0FP25apple7moonseo16numbered__claims(claims);
  return chinese ? `请对下面这篇草稿做逐条事实支撑审计，只返回原始 JSON，不要返回 Markdown。\n\n文章标题：${_M0IPC16string6StringPB4Show10to__string(safe_title)}\n品牌名称：${_M0IPC16string6StringPB4Show10to__string(safe_brand)}\n主关键词：${_M0IPC16string6StringPB4Show10to__string(safe_keyword)}\n目标受众：${_M0IPC16string6StringPB4Show10to__string(safe_audience)}\n\n来源事实：\n${_M0IPC16string6StringPB4Show10to__string(fact_lines)}\n\n补充写作要求：\n${_M0IPC16string6StringPB4Show10to__string(note_lines)}\n\n待审阅 claims：\n${_M0IPC16string6StringPB4Show10to__string(claim_lines)}\n\n任务要求：\n1. 必须逐条审阅上面的 claims，不要新增 claim，也不要改动 claim_id。\n2. 对每条 claim 判断 verdict，只能是 supported、needs_review、unsupported 三者之一。\n3. evidence_numbers 必须是来源事实编号数组，例如 [1, 3]；如果完全没有支撑，可以返回空数组 []。\n4. reason 必须使用自然、完整的简体中文解释，除非直接引用英文原文；不要写成英文说明。\n5. reason 要简洁说明为什么这样判定，必须优先基于给定来源事实；如果某个视角、人称或写法是补充写作要求明确指定的，不要把这种写法本身判为问题。reason 尽量控制在 1 句、30 个中文字符以内。\n6. reason 里不要再写“source [1]”“source [4]”这类来源编号引用，因为界面会在下方单独展示对应摘录。\n7. rewrite 给出一句更安全、且更贴近来源的改写建议；如果 claim 已经 fully supported，也可以返回空字符串。rewrite 只保留 1 句。\n8. rewrite 必须沿用原 claim 的正文语言，直接返回一条可贴回正文的句子。如果原 claim 是英文，rewrite 必须是英文；即使 reason 使用中文，也不要把 rewrite 写成中文。\n9. rewrite 必须尽量保留原 claim 的叙述视角、人称和语气。如果补充写作要求明确要求第一人称、消费者视角或某种叙述角度，rewrite 必须延续该视角，不要改写成第三方说明文口吻。\n10. 如果 claim 使用了超出来源事实的信息、夸张措辞、过度概括或偷换概念，应判为 needs_review 或 unsupported；但不要仅因为它采用了用户明确要求的写作视角就判错。\n11. 只返回 JSON，格式必须严格为：{\"claims\":[{\"claim_id\":\"C1\",\"claim\":\"...\",\"verdict\":\"supported|needs_review|unsupported\",\"evidence_numbers\":[1,2],\"reason\":\"...\",\"rewrite\":\"...\"}]}` : `Review the draft below claim by claim for factual grounding and return raw JSON only, with no markdown fences.\n\nArticle title: ${_M0IPC16string6StringPB4Show10to__string(safe_title)}\nBrand name: ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}\nPrimary keyword: ${_M0IPC16string6StringPB4Show10to__string(safe_keyword)}\nAudience: ${_M0IPC16string6StringPB4Show10to__string(safe_audience)}\n\nSource facts:\n${_M0IPC16string6StringPB4Show10to__string(fact_lines)}\n\nAdditional writing instructions:\n${_M0IPC16string6StringPB4Show10to__string(note_lines)}\n\nClaims to review:\n${_M0IPC16string6StringPB4Show10to__string(claim_lines)}\n\nRequirements:\n1. Review each provided claim ID. Do not invent new claims and do not change the claim_id values.\n2. For each claim, set verdict to exactly one of: supported, needs_review, unsupported.\n3. evidence_numbers must be an array of source-note numbers such as [1, 3]. If no source supports the claim, return an empty array [].\n4. reason should briefly explain the decision using the provided source facts first. If a viewpoint, narrative angle, or person is explicitly required by the additional writing instructions, do not treat that framing alone as a problem. Keep reason to 1 short sentence when possible.\n5. Do not mention source-number references like \"source [4]\" inside reason, because the UI will show the matched excerpt separately below.\n6. rewrite should offer a safer replacement sentence when the claim is risky or unsupported. It may be empty if the claim is fully supported. Keep rewrite to a single sentence.\n7. Keep rewrite in the same body-copy language as the original claim so it can be pasted back into the draft directly.\n8. Preserve the original narrative perspective, person, and tone whenever possible. If the writing instructions explicitly ask for first-person, consumer perspective, or another specific viewpoint, the rewrite must keep that viewpoint instead of switching to detached third-person copy.\n9. If a claim introduces information beyond the provided sources, overgeneralizes, exaggerates, or shifts the meaning of a source fact, mark it as needs_review or unsupported. But do not mark a claim problematic only because it follows a user-requested writing perspective.\n10. Return JSON only, in exactly this shape: {\"claims\":[{\"claim_id\":\"C1\",\"claim\":\"...\",\"verdict\":\"supported|needs_review|unsupported\",\"evidence_numbers\":[1,2],\"reason\":\"...\",\"rewrite\":\"...\"}]}`;
}
function _M0FP25apple7moonseo37build__claim__review__prompt__batches(article_title, brand_name, primary_keyword, audience, facts_raw, notes_raw, claims, lang, batch_size) {
  const normalized_batch_size = batch_size <= 0 ? 8 : batch_size;
  const prompts = [];
  const start = new _M0TPC13ref3RefGiE(0);
  while (true) {
    if (start.val < claims.length) {
      const current = [];
      const index = new _M0TPC13ref3RefGiE(start.val);
      while (true) {
        if (index.val < claims.length && current.length < normalized_batch_size) {
          _M0MPC15array5Array4pushGsE(current, _M0MPC15array5Array2atGsE(claims, index.val));
          index.val = index.val + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      if (current.length > 0) {
        _M0MPC15array5Array4pushGsE(prompts, _M0FP25apple7moonseo28build__claim__review__prompt(article_title, brand_name, primary_keyword, audience, facts_raw, notes_raw, current, lang));
      }
      start.val = start.val + normalized_batch_size | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind = "\u001d";
  return _M0MPC15array5Array4joinGsE(prompts, new _M0TPC16string10StringView(_bind, 0, _bind.length));
}
function _M0FP25apple7moonseo16field__or__empty(fields, index) {
  return index < fields.length ? _M0MPC15array5Array2atGsE(fields, index) : "";
}
function _M0FP25apple7moonseo19find__claim__record(items, claim_id) {
  const _bind = items.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const fields = items[_];
      if (_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP25apple7moonseo16field__or__empty(fields, 0), undefined)) === claim_id) {
        return fields;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return [];
}
function _M0FP25apple7moonseo25normalize__claim__verdict(value) {
  const lower = _M0MPC16string6String9to__lower(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(value, undefined)));
  return lower === "supported" ? "supported" : lower === "unsupported" ? "unsupported" : "needs_review";
}
function _M0FP25apple7moonseo24compact__source__excerpt(source_note) {
  const _bind = "\r";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(source_note, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\n";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = " ";
  const normalized = _M0MPB4Iter4join(_M0MPB4Iter11filter__mapGRPC16string10StringViewsE(_M0MPC16string6String5split(_tmp$4, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length)), (part) => {
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(part, undefined));
    return current === "" ? undefined : current;
  }), " ");
  return normalized.length <= 180 ? normalized : `${_M0IPC16string6StringPB4Show10to__string(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(normalized, 0, 180)))}...`;
}
function _M0FP25apple7moonseo20lookup__source__note(source_notes, source_id) {
  const target = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(source_id, undefined));
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < source_notes.length) {
      if (_M0IP016_24default__implPB4Show10to__stringGiE(index + 1 | 0) === target) {
        return _M0MPC15array5Array2atGsE(source_notes, index);
      }
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return "";
}
function _M0FP25apple7moonseo24parse__evidence__numbers(evidence_numbers) {
  const source_ids = [];
  const _bind = ",";
  const _it = _M0MPC16string6String5split(evidence_numbers, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let part;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0IPC16string10StringViewPB4Show10to__string(part), undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(trimmed, "")) {
      _M0MPC15array5Array4pushGsE(source_ids, trimmed);
    }
    continue;
  }
  return source_ids;
}
function _M0FP25apple7moonseo29render__source__excerpt__list(builder, evidence_numbers, source_notes, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const source_ids = _M0FP25apple7moonseo24parse__evidence__numbers(evidence_numbers);
  if (source_ids.length === 0) {
    return undefined;
  }
  const _bind = source_ids.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const source_id = source_ids[_];
      _L: {
        const source_note = _M0FP25apple7moonseo20lookup__source__note(source_notes, source_id);
        const preview = _M0FP25apple7moonseo24compact__source__excerpt(source_note);
        const usable_excerpt = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(preview, undefined)).length >= 12;
        if (!usable_excerpt) {
          break _L;
        }
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"source-note\" data-source-id=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, source_id);
        if (_M0IP016_24default__implPB2Eq10not__equalGsE(source_note, "")) {
          _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" title=\"");
          _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(source_note));
        }
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "\"><div class=\"source-note-head\"><span class=\"source-pill\">[");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, source_id);
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "]</span><strong>");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "来源材料摘录" : "Source material excerpt");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong></div><p class=\"source-note-copy\">");
        _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(source_note === "" ? (chinese ? "当前没有找到对应的来源摘录。" : "No matching source excerpt was found for this source ID.") : preview));
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p></article>");
        break _L;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      return;
    }
  }
}
function _M0FP25apple7moonseo27render__claim__review__item(builder, claim_id, _claim, verdict, evidence_numbers, reason, rewrite, source_notes, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const tone = verdict === "supported" ? "pass" : "warn";
  const badge = verdict === "supported" ? (chinese ? "已支撑" : "Supported") : verdict === "unsupported" ? (chinese ? "不支撑" : "Unsupported") : chinese ? "需复核" : "Needs review";
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"claim-card ");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, tone);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" id=\"review-");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" data-claim-id=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" data-stale-status=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(chinese ? "待重审" : "Re-review needed"));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button type=\"button\" class=\"claim-link\" data-claim-id=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "\"><span class=\"claim-chip\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span><span class=\"claim-status\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, badge);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"claim-detail\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p class=\"claim-reason claim-reason-lead\"><strong>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "为什么判定" : "Why it was flagged");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(reason));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></p>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"source-stack\">");
  _M0FP25apple7moonseo29render__source__excerpt__list(builder, evidence_numbers, source_notes, lang);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(verdict, "supported") && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(rewrite, undefined)), "")) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"claim-rewrite-box\"><p class=\"claim-rewrite\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(chinese ? `建议改写：${_M0IPC16string6StringPB4Show10to__string(rewrite)}` : `Suggested rewrite: ${_M0IPC16string6StringPB4Show10to__string(rewrite)}`));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p><button type=\"button\" class=\"claim-apply\" data-claim-id=\"");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, claim_id);
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "\" data-claim-rewrite=\"");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(rewrite));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "\">");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "一键优化" : "Rewrite with sources");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</button><p class=\"claim-apply-note\" hidden>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "已应用到左侧草稿。" : "Applied to the draft on the left.");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p></div>");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></article>");
}
function _M0FP25apple7moonseo36claim__review__report__from__payload(payload, claims, facts_raw, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const items = [];
  const record_sep = "\u001e";
  const field_sep = "\u001f";
  const _it = _M0MPC16string6String5split(payload, new _M0TPC16string10StringView(record_sep, 0, record_sep.length));
  while (true) {
    let record;
    _L: {
      const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind === undefined) {
        break;
      } else {
        const _Some = _bind;
        const _record = _Some;
        record = _record;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(record);
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(current, undefined)), "")) {
      const fields = [];
      const _it$2 = _M0MPC16string6String5split(current, new _M0TPC16string10StringView(field_sep, 0, field_sep.length));
      while (true) {
        let field;
        _L$2: {
          const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(_it$2);
          if (_bind === undefined) {
            break;
          } else {
            const _Some = _bind;
            const _field = _Some;
            field = _field;
            break _L$2;
          }
        }
        _M0MPC15array5Array4pushGsE(fields, _M0IPC16string10StringViewPB4Show10to__string(field));
        continue;
      }
      _M0MPC15array5Array4pushGRPB5ArrayGsEE(items, fields);
    }
    continue;
  }
  const source_notes = _M0FP25apple7moonseo12parse__facts(facts_raw);
  const supported = new _M0TPC13ref3RefGiE(0);
  const needs_review = new _M0TPC13ref3RefGiE(0);
  const unsupported = new _M0TPC13ref3RefGiE(0);
  const needs_builder = _M0MPB13StringBuilder11new_2einner(0);
  const supported_builder = _M0MPB13StringBuilder11new_2einner(0);
  const _bind = claims.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const claim = claims[_];
      const fields = _M0FP25apple7moonseo19find__claim__record(items, claim.id);
      const reviewed_claim = _M0FP25apple7moonseo22normalize__or__default(_M0FP25apple7moonseo16field__or__empty(fields, 1), claim.text);
      const verdict = fields.length === 0 ? "needs_review" : _M0FP25apple7moonseo25normalize__claim__verdict(_M0FP25apple7moonseo16field__or__empty(fields, 2));
      const evidence_numbers = _M0FP25apple7moonseo16field__or__empty(fields, 3);
      const reason = _M0FP25apple7moonseo22normalize__or__default(_M0FP25apple7moonseo16field__or__empty(fields, 4), chinese ? "当前没有返回这条 claim 的结构化审阅结果，建议人工复核。" : "No structured review was returned for this claim, so it should be checked manually.");
      const rewrite = _M0FP25apple7moonseo16field__or__empty(fields, 5);
      switch (verdict) {
        case "supported": {
          supported.val = supported.val + 1 | 0;
          break;
        }
        case "unsupported": {
          unsupported.val = unsupported.val + 1 | 0;
          break;
        }
        default: {
          needs_review.val = needs_review.val + 1 | 0;
        }
      }
      if (verdict === "supported") {
        _M0FP25apple7moonseo27render__claim__review__item(supported_builder, claim.id, reviewed_claim, verdict, evidence_numbers, reason, rewrite, source_notes, lang);
      } else {
        _M0FP25apple7moonseo27render__claim__review__item(needs_builder, claim.id, reviewed_claim, verdict, evidence_numbers, reason, rewrite, source_notes, lang);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const total = claims.length;
  const review_count = needs_review.val + unsupported.val | 0;
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section id=\"factAuditSection\" class=\"audit-accordion audit-section-shell\"><div class=\"audit-accordion-body\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<details class=\"claim-group claim-group-review\" open>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<summary class=\"claim-group-head\"><h4>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "需复核 claims" : "Claims needing review");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h4><span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0IP016_24default__implPB4Show10to__stringGiE(review_count));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></summary><div class=\"claim-list\">");
  if (review_count === 0) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"audit-item pass\"><div class=\"audit-top\"><strong>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "当前没有高风险 claim" : "No high-risk claims right now");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "通过" : "Pass");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></div><p>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(chinese ? "这一轮审阅没有发现需要人工复核的关键表述。" : "This run did not flag any key claims for manual review."));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p></article>");
  } else {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPB13StringBuilder10to__string(needs_builder));
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></details>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<details class=\"claim-group claim-group-supported\" open>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<summary class=\"claim-group-head\"><h4>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "已支撑 claims" : "Supported claims");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</h4><span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0IP016_24default__implPB4Show10to__stringGiE(supported.val));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></summary><div class=\"claim-list\">");
  if (supported.val === 0) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "<article class=\"audit-item warn\"><div class=\"audit-top\"><strong>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "当前还没有已支撑 claim" : "No supported claims yet");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "待补强" : "Needs work");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></div><p>");
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(chinese ? "当前草稿里的关键表述还没有形成明确的事实支撑闭环。" : "The draft has not yet established clear source support for its key claims."));
    _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p></article>");
  } else {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPB13StringBuilder10to__string(supported_builder));
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></details></div></section>");
  return new _M0TP25apple7moonseo17ClaimReviewReport(supported.val, needs_review.val, unsupported.val, total, true, "", _M0MPB13StringBuilder10to__string(builder));
}
function _M0FP25apple7moonseo23render__audit__overview(claim_report, seo_report, lang) {
  const chinese = _M0FP25apple7moonseo15is__chinese__ui(lang);
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"audit-overview-grid\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button type=\"button\" class=\"audit-summary-button\" data-audit-target=\"factAuditSection\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span class=\"audit-summary-label\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "事实支撑" : "Fact grounding");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span><strong>");
  if (claim_report.audit_available) {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, `${_M0IP016_24default__implPB4Show10to__stringGiE(claim_report.supported_count)}/${_M0IP016_24default__implPB4Show10to__stringGiE(claim_report.total_count)}`);
  } else {
    _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "资料不足" : "Insufficient sources");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span class=\"audit-summary-meta\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(!claim_report.audit_available && chinese ? "无法做事实支撑审计" : !claim_report.audit_available ? "Fact-grounding audit unavailable" : chinese ? `${_M0IP016_24default__implPB4Show10to__stringGiE(claim_report.needs_review_count + claim_report.unsupported_count | 0)} 条待复核` : `${_M0IP016_24default__implPB4Show10to__stringGiE(claim_report.needs_review_count + claim_report.unsupported_count | 0)} need review`));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button type=\"button\" class=\"audit-summary-button\" data-audit-target=\"seoRuleSection\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span class=\"audit-summary-label\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, chinese ? "SEO 规则" : "SEO rules");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span><strong>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, `${_M0IP016_24default__implPB4Show10to__stringGiE(seo_report.pass_count)}/${_M0IP016_24default__implPB4Show10to__stringGiE(seo_report.total_count)}`);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</strong><span class=\"audit-summary-meta\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP25apple7moonseo12escape__html(chinese ? "MoonBit 确定性检查" : "MoonBit deterministic checks"));
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</span></button></div>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo26render__seo__rule__section(report, lang) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section id=\"seoRuleSection\" class=\"audit-accordion audit-section-shell\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"audit-accordion-body\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, report.findings_html);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></section>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo13bullet__lines(lines, empty_line) {
  if (lines.length === 0) {
    return empty_line;
  }
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const _bind = lines.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const line = lines[_];
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "- ");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, line);
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "\n");
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP25apple7moonseo23normalize__prompt__fact(fact) {
  const _bind = "✅";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(fact, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "❌";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = "✔";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = " ";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = "✘";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = " ";
  const _tmp$8 = _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
  const _bind$9 = "☑";
  const _tmp$9 = new _M0TPC16string10StringView(_bind$9, 0, _bind$9.length);
  const _bind$10 = " ";
  const _tmp$10 = _M0MPC16string6String12replace__all(_tmp$8, _tmp$9, new _M0TPC16string10StringView(_bind$10, 0, _bind$10.length));
  const _bind$11 = "☒";
  const _tmp$11 = new _M0TPC16string10StringView(_bind$11, 0, _bind$11.length);
  const _bind$12 = " ";
  const _tmp$12 = _M0MPC16string6String12replace__all(_tmp$10, _tmp$11, new _M0TPC16string10StringView(_bind$12, 0, _bind$12.length));
  const _bind$13 = "断言";
  const _tmp$13 = new _M0TPC16string10StringView(_bind$13, 0, _bind$13.length);
  const _bind$14 = " ";
  const _tmp$14 = _M0MPC16string6String12replace__all(_tmp$12, _tmp$13, new _M0TPC16string10StringView(_bind$14, 0, _bind$14.length));
  const _bind$15 = "内容";
  const _tmp$15 = new _M0TPC16string10StringView(_bind$15, 0, _bind$15.length);
  const _bind$16 = " ";
  const _tmp$16 = _M0MPC16string6String12replace__all(_tmp$14, _tmp$15, new _M0TPC16string10StringView(_bind$16, 0, _bind$16.length));
  const _bind$17 = "判断";
  const _tmp$17 = new _M0TPC16string10StringView(_bind$17, 0, _bind$17.length);
  const _bind$18 = " ";
  const _tmp$18 = _M0MPC16string6String12replace__all(_tmp$16, _tmp$17, new _M0TPC16string10StringView(_bind$18, 0, _bind$18.length));
  const _bind$19 = "备注";
  const _tmp$19 = new _M0TPC16string10StringView(_bind$19, 0, _bind$19.length);
  const _bind$20 = " ";
  const _tmp$20 = _M0MPC16string6String12replace__all(_tmp$18, _tmp$19, new _M0TPC16string10StringView(_bind$20, 0, _bind$20.length));
  const _bind$21 = "正确写法提示";
  const _tmp$21 = new _M0TPC16string10StringView(_bind$21, 0, _bind$21.length);
  const _bind$22 = " ";
  const _tmp$22 = _M0MPC16string6String12replace__all(_tmp$20, _tmp$21, new _M0TPC16string10StringView(_bind$22, 0, _bind$22.length));
  const _bind$23 = "（";
  const _tmp$23 = new _M0TPC16string10StringView(_bind$23, 0, _bind$23.length);
  const _bind$24 = "(";
  const _tmp$24 = _M0MPC16string6String12replace__all(_tmp$22, _tmp$23, new _M0TPC16string10StringView(_bind$24, 0, _bind$24.length));
  const _bind$25 = "）";
  const _tmp$25 = new _M0TPC16string10StringView(_bind$25, 0, _bind$25.length);
  const _bind$26 = ")";
  const cleaned = _M0FP25apple7moonseo16collapse__spaces(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC16string6String12replace__all(_tmp$24, _tmp$25, new _M0TPC16string10StringView(_bind$26, 0, _bind$26.length)), undefined)));
  return cleaned === "" ? "" : _M0FP25apple7moonseo7excerpt(cleaned, 220);
}
function _M0FP25apple7moonseo20draft__prompt__facts(facts) {
  const cleaned = [];
  const _bind = facts.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const fact = facts[_];
      const normalized = _M0FP25apple7moonseo23normalize__prompt__fact(fact);
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(normalized, "")) {
        _M0MPC15array5Array4pushGsE(cleaned, normalized);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return cleaned;
}
function _M0FP25apple7moonseo17build__ai__prompt(article_title, brand_name, primary_keyword, audience, facts_raw, notes_raw, lang) {
  const output_lang = _M0FP25apple7moonseo23requested__output__lang(notes_raw);
  const chinese = output_lang === "zh";
  const safe_brand = _M0FP25apple7moonseo22normalize__or__default(brand_name, "MoonSEO");
  const safe_keyword = _M0FP25apple7moonseo17inferred__keyword(primary_keyword, article_title, safe_brand);
  const safe_audience = _M0FP25apple7moonseo22normalize__or__default(audience, "general readers");
  const requested_title = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(article_title, undefined)) === "" ? (chinese ? "（未指定，可自行生成）" : "(not provided, generate one)") : _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(article_title, undefined));
  const facts = _M0FP25apple7moonseo12parse__facts(facts_raw);
  const notes = _M0FP25apple7moonseo12parse__facts(notes_raw);
  const fact_lines = facts.length === 0 ? (chinese ? "- 当前没有真实来源材料，请谨慎写作，不要臆造事实。" : "- No real source materials were provided. Write conservatively and do not invent facts.") : _M0FP25apple7moonseo13bullet__lines(_M0FP25apple7moonseo20draft__prompt__facts(facts), "");
  const note_lines = notes.length === 0 ? (chinese ? "- 没有额外写作要求。" : "- No extra writing instructions.") : _M0FP25apple7moonseo13bullet__lines(notes, "");
  return chinese ? `请为一个品牌/产品主题页面生成文案，且只返回原始 JSON，不要返回 Markdown 代码块。\n\n品牌名称：${_M0IPC16string6StringPB4Show10to__string(safe_brand)}\n主关键词：${_M0IPC16string6StringPB4Show10to__string(safe_keyword)}\n目标受众：${_M0IPC16string6StringPB4Show10to__string(safe_audience)}\n指定标题：${_M0IPC16string6StringPB4Show10to__string(requested_title)}\n来源事实：\n${_M0IPC16string6StringPB4Show10to__string(fact_lines)}\n补充写作要求：\n${_M0IPC16string6StringPB4Show10to__string(note_lines)}\n要求：\n1. 全文必须使用自然、完整、专业的简体中文，除品牌名、产品名、官网域名外，不要夹杂英文句子或英文小标题。\n2. 请写成真正可发布的品牌文章，不要写成提纲、摘要或提示词回应。\n3. 总体长度控制在 1400 到 1800 个中文字符之间，确保像一篇完整长文，而不是短摘要。\n4. 写作前先在脑中规划清楚：结论先行的 opening、一个列表型亮点区块、一个紧凑的对比表格、三个不重复的核心小节、一个 FAQ 前的总结型主题小节，以及结尾如何自然收束；不要把这份规划直接输出。\n5. opening 必须采用倒金字塔逻辑：前 40 到 80 字先给出结论或答案；随后补充用户痛点/需求背景（不要提竞品）；再说明读完这篇文章能获得什么价值。\n6. 主关键词必须出现在标题里，并在前 100 个词内自然出现；品牌名也必须在前 100 个词内至少出现一次。\n7. 主关键词自然出现 3 到 5 次，并且不要集中堆在同一段里；至少要分别落在 opening、正文至少一个主 section，以及 summary 或 FAQ 其中一处。还要自然带出 3 到 4 个语义紧密的相关词，不要堆砌。\n8. 标题要清晰具体，像真实品牌文章标题，不要写成空泛模板或流程标题。\n9. meta_description 控制在 90 到 140 个中文字符之间，可直接用于搜索摘要。\n10. opening_answer、opening_problem、opening_value 三个字段必须分别承担三段开场职责：先给结论，再给背景，再给阅读价值；不要把三段内容混在一个字段里。\n11. 三个主 section 的标题都要具体、并列、互不重复，且围绕关键主题词展开，不要出现跨级跳跃或工作流式标题。\n12. 每个主 section 正文都要围绕一个核心主题展开，遵守 topic sentence first；优先按 claim → evidence → conclusion 的顺序推进，每段 2 到 4 句，最多不要超过 5 句。每个 section 最好像一个清晰的小点，分别回答不同的买家问题，而不是三段相似的长文。只要自然，就优先把主关键词放进 section_heading、topic sentence 或段落第一句，而不是只在全文中出现一次。\n13. 默认情况下，请额外返回一个列表区块：key_points_heading 和 key_points_items。key_points_items 必须是 3 到 4 条紧凑的列表项，且每条都是完整短句，用来概括品牌最值得关注的功能、优势或注意点。如果补充要求明确说不要列表、不要 bullet points、不要 key points，则返回空字符串 key_points_heading 和空数组 key_points_items。\n14. 默认情况下，请额外返回一个对比表格区块：comparison_table_heading、comparison_table_columns、comparison_table_rows。comparison_table_columns 必须是 3 个列标题组成的字符串数组。comparison_table_rows 必须是 3 到 4 行字符串数组，每一行都使用“特征 | ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} | 通用替代方案”这种单行格式，便于后续渲染成 HTML 表格。如果补充要求没有明确要求竞品品牌名，则表格里也不要出现任何竞品品牌名。如果补充要求明确说不要表格、不要对比表、不要 comparison table 或 no table，则返回空字符串 comparison_table_heading 和空数组 comparison_table_columns、comparison_table_rows。\n15. FAQ 前默认必须再返回一个独立的总结型区块：summary_heading 和 summary_body。这个区块要放在 FAQ 前面，承担“把前文重点收拢并帮助读者做判断”的作用，但标题绝对不要写成 Conclusion、In conclusion、Final thoughts、结论、总结或类似套路词，也不要写成明显在宣布“这里开始总结”的标题。summary_heading 必须是一个具体、贴主题、偏买家判断或适用场景的 H2。\n16. summary_body 必须写成 2 个短段落，中间用空行分隔。每段只讲一件事，优先控制在 2 到 3 句，最多不要超过 5 句；第一段更偏向适用人群/核心价值，第二段更偏向限制、边界或决策提醒。\n17. 对比表格必须优先比较买家真正会拿来做决定的维度，例如适配范围、安装方式、调节体验、承重/稳定性、桌面占用、线缆管理或后续校准，而不是空泛口号。每一行第一列尽量控制在 2 到 6 个字或 2 到 5 个英文词；每个单元格优先使用紧凑短语，而不是完整长句。\n18. 如果某一段内容天然适合做功能列表、优点列表、步骤列表或结构化对比，请优先把这些信息压进 key_points_items、comparison_table_rows 或正文中的列表式表达，而不是堆成长句。\n19. 默认情况下，FAQ 必须写 3 个短问短答，只能回答正文已覆盖的主题；每个回答都要先给 Yes/No，再补一句理由，不要新增新话题。如果补充要求明确说不要 FAQ、不要 FAQs、不要常见问题，则 faq_heading 和所有 faq 字段都返回空字符串。\n20. 如果补充要求里明确要求某种写作角度、人称视角或结构，必须在 opening 和至少一个小节里体现。\n21. 不要臆造消费者调研、市场份额、使用习惯、口碑评价或功能细节，除非来源事实明确写出。\n22. 优先使用来源中明确出现的产品事实、功能细节和数字信息；有数据时要自然写进正文，而不是写成空泛判断。\n23. 除非标题、来源事实或补充要求明确提到 SEO、搜索流量、搜索引擎、关键词、内容审计，否则不要在正文里讨论 SEO、搜索意图、SEO 内容审计、写作流程或内容工作流。\n24. section_one_body 和 section_two_body 不要自己写 [1][2][3] 这种引用标记。\n25. 不要使用 best、guaranteed、perfect、#1、最强、第一、保证、绝对、顶级 这类高风险表述，除非用户明确要求并且来源可支持。\n26. 如果来源事实来自 PDF、断言清单或混合语言摘录，先提炼底层产品事实，再写成通顺中文；不要把“断言 / 备注 / 正确写法提示 / ✅ / ❌”这类判断符号或编辑备注直接抄进正文。\n27. 如果来源事实里同时出现中英文或提取噪声，正文必须仍然保持单一、干净的中文成稿，不要中英混写，也不要直接粘贴原始 checklist 片段。\n28. 语气要可信、克制，像真实品牌官网内容，不要像 AI 套话。\n29. 仅返回 JSON，字段必须严格为：title, meta_description, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer。其中 key_points_items、comparison_table_columns、comparison_table_rows 都必须是字符串数组。` : `Write copy for a brand or product page and return raw JSON only, with no markdown fences.\n\nBrand name: ${_M0IPC16string6StringPB4Show10to__string(safe_brand)}\nPrimary keyword: ${_M0IPC16string6StringPB4Show10to__string(safe_keyword)}\nAudience: ${_M0IPC16string6StringPB4Show10to__string(safe_audience)}\nRequested title: ${_M0IPC16string6StringPB4Show10to__string(requested_title)}\nSource facts:\n${_M0IPC16string6StringPB4Show10to__string(fact_lines)}\nAdditional writing instructions:\n${_M0IPC16string6StringPB4Show10to__string(note_lines)}\nRequirements:\n1. Default to polished, publishable English prose.\n2. If the source notes explicitly request another output language, honor that request and write the whole draft consistently in that language.\n3. The article subject is the requested topic/title, not SEO, search intent, keyword strategy, audits, or the writing workflow. Do not mention SEO, search engines, content audits, search intent, keyword usage, or the drafting tool unless the title, source facts, or additional instructions explicitly ask for those topics.\n4. Target a real long-form article of roughly 1450 to 1650 words. If the draft is materially shorter than 1300 words, expand it before finalizing.\n5. Before writing, silently plan a clear article blueprint: an answer-first opening, a compact list block of key reasons to care, a compact comparison table, three non-overlapping section roles, a pre-FAQ summary section with its own thematic H2, and a closing angle that ties the piece together. Do not output the plan itself.\n6. Use the provided source facts as the center of the article, not generic category commentary.\n7. In the first 40 to 80 words, lead with the conclusion or direct answer. Then introduce the reader need or pain point without naming competitors, and close the opening by clarifying the value of reading on.\n8. Mention the brand at least once in the first 100 words, and place the primary keyword in both the title and the first 100 words.\n9. Reflect any requested angle or perspective clearly in the opening and at least one section heading.\n10. Do not invent consumer sentiment, survey data, market trends, user behavior patterns, or feature details unless they are directly supported by the source notes.\n11. Use at least three concrete source facts directly in the prose when the sources provide them, and connect them with a claim → evidence → conclusion rhythm instead of loose assertions.\n12. Use the primary keyword naturally 3 to 5 times, do not bunch those mentions into a single paragraph, and spread them across the opening, at least one main section, and either the summary or FAQ. Also weave in 3 to 4 semantically related terms without keyword stuffing.\n13. Make the title specific, search-friendly, and free of risky claims like best, guaranteed, perfect, #1, unbeatable, or world-class unless those exact words were explicitly required by the user.\n14. Keep meta_description around 130 to 155 characters.\n15. Return the opening as three separate fields: opening_answer, opening_problem, and opening_value. Together they should read like a real inverted-pyramid opening instead of a generic scene-setter.\n16. Each section heading must be concrete, parallel in scope, and centered on the main topic rather than workflow language.\n17. Each section body should fully develop one idea at a time with short, readable paragraphs. Use topic sentence first, keep most paragraphs to 2 to 4 sentences, and avoid filler. Each section should feel like its own clear sub-point that answers a different buyer question rather than three similar blocks. When it stays natural, prefer placing the primary keyword in a section heading, topic sentence, or first paragraph rather than mentioning it only once in the whole article.\n18. Treat the three main sections as the bulk of the article, not placeholders. Aim for roughly 280 to 380 words for each main section body, and make sure the combined opening plus sections already puts the draft near long-form territory before the FAQ.\n19. Expand with concrete explanation, examples, use-case framing, caveats, and reader decision guidance when the source facts allow it. Do not stop after one short paragraph per section.\n20. By default, return an additional list block using key_points_heading and key_points_items. key_points_items must be an array of 3 to 4 short bullet-style statements that summarize the brand's most useful features, strengths, or cautions. If the additional instructions explicitly say no bullet points, no list, or no key points, return an empty string for key_points_heading and an empty array for key_points_items.\n21. By default, return an additional comparison block using comparison_table_heading, comparison_table_columns, and comparison_table_rows. comparison_table_columns must be a JSON array of exactly 3 column labels. comparison_table_rows must be a JSON array of 3 to 4 strings, each using a single-line format like \"Feature | ${_M0IPC16string6StringPB4Show10to__string(safe_brand)} | Generic alternative\" so it can be rendered into an HTML table later. Unless the user explicitly requests competitor brands, comparison language should stay generic and must not mention competitor brand names. If the additional instructions explicitly say no table, no tables, no comparison table, without table, or do not include a table, return an empty string for comparison_table_heading and empty arrays for comparison_table_columns and comparison_table_rows.\n22. Before the FAQ, return an additional summary block using summary_heading and summary_body. This block should synthesize the strongest takeaways, help the reader make a decision, and read like a thematic final section rather than a boilerplate conclusion. Do not use headings like Conclusion, In conclusion, Final thoughts, Summary, Wrap-up, 结论, 总结, or any close variant, and do not make the heading sound like it is announcing a recap. summary_heading should feel closer to a buyer lens, fit question, or use-case judgment than a summary label.\n23. summary_body must contain exactly 2 short paragraphs separated by a blank line. Each paragraph should focus on one idea, usually 2 to 3 sentences, and never more than 5 sentences. Prefer the first paragraph for fit/value and the second paragraph for caveat, limitation, or decision guidance.\n24. The comparison table should focus on buyer decision dimensions that genuinely help evaluation, such as fit range, mounting approach, adjustability, stability/load handling, desk footprint, cable management, or calibration. Keep first-column labels short, ideally 2 to 5 words, and keep cell content compact and scannable rather than full long sentences.\n25. If a feature set, advantage list, process, or buyer decision naturally benefits from structured comparison, prefer encoding that information in key_points_items, comparison_table_rows, or list-like prose instead of flattening everything into one dense paragraph.\n26. By default, add exactly 3 FAQ items. Each FAQ answer must start with a clear Yes or No, followed by a short reason. The FAQ must only address topics already covered in the article and must not introduce new claims. If the additional instructions explicitly say no FAQ, no FAQs, or no frequently asked questions, return an empty string for faq_heading and empty strings for every FAQ field.\n27. Do not include citation markers like [1], [2], or [3] in section_one_body or section_two_body.\n28. If the source notes come from a PDF, checklist, or mixed-language extraction, first infer the underlying product fact and rewrite it as clean prose. Do not paste editorial labels, verdict markers, checkmarks, correction notes, or bilingual fragments directly into the article.\n29. Keep the entire draft in one consistent output language. If the sources are mixed-language, silently translate the useful facts into the requested draft language instead of echoing the original wording.\n30. Keep the tone credible, restrained, and suitable for a real brand page.\n31. Return JSON only, with exactly these keys: title, meta_description, opening_answer, opening_problem, opening_value, section_one_heading, section_one_body, section_two_heading, section_two_body, section_three_heading, section_three_body, key_points_heading, key_points_items, comparison_table_heading, comparison_table_columns, comparison_table_rows, summary_heading, summary_body, faq_heading, faq_one_question, faq_one_answer, faq_two_question, faq_two_answer, faq_three_question, faq_three_answer. key_points_items, comparison_table_columns, and comparison_table_rows must each be JSON arrays of strings.`;
}
function _M0FP25apple7moonseo16export__filename(draft) {
  return `${_M0IPC16string6StringPB4Show10to__string(draft.slug)}.html`;
}
function _M0FP25apple7moonseo30render__export__html__document(title, meta_description, article_html, slug, lang) {
  return _M0FP25apple7moonseo19build__export__html(title, meta_description, article_html, slug, lang);
}
function _M0FP45apple7moonseo3cmd3web11has__prefix(input, prefix) {
  return input.length >= prefix.length && _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(input, 0, prefix.length)) === prefix;
}
function _M0FP45apple7moonseo3cmd3web13strip__prefix(input, prefix) {
  return _M0FP45apple7moonseo3cmd3web11has__prefix(input, prefix) ? _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(input, prefix.length, undefined)) : input;
}
function _M0FP45apple7moonseo3cmd3web14first__segment(input, separator) {
  const _it = _M0MPC16string6String5split(input, new _M0TPC16string10StringView(separator, 0, separator.length));
  while (true) {
    let part;
    _L: {
      const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind === undefined) {
        break;
      } else {
        const _Some = _bind;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    return _M0IPC16string10StringViewPB4Show10to__string(part);
  }
  return "";
}
function _M0FP45apple7moonseo3cmd3web19normalize__hostname(raw_website) {
  const trimmed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(raw_website, undefined));
  const without_scheme = _M0FP45apple7moonseo3cmd3web13strip__prefix(_M0FP45apple7moonseo3cmd3web13strip__prefix(_M0FP45apple7moonseo3cmd3web13strip__prefix(trimmed, "https://"), "http://"), "//");
  const without_path = _M0FP45apple7moonseo3cmd3web14first__segment(without_scheme, "/");
  const without_query = _M0FP45apple7moonseo3cmd3web14first__segment(_M0FP45apple7moonseo3cmd3web14first__segment(without_path, "?"), "#");
  const without_port = _M0FP45apple7moonseo3cmd3web14first__segment(without_query, ":");
  return _M0FP45apple7moonseo3cmd3web13strip__prefix(without_port, "www.");
}
function _M0FP45apple7moonseo3cmd3web17capitalize__ascii(input) {
  if (input.length === 0) {
    return input;
  }
  const lower = _M0MPC16string6String9to__lower(input);
  const first = _M0MPC16string6String9to__upper(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(lower, 0, 1)));
  return lower.length === 1 ? first : `${_M0IPC16string6StringPB4Show10to__string(first)}${_M0IPC16string6StringPB4Show10to__string(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(lower, 1, undefined)))}`;
}
function _M0FP45apple7moonseo3cmd3web18infer__brand__name(direct_brand, raw_website) {
  const direct = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(direct_brand, undefined));
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(direct, "")) {
    return direct;
  }
  const first_label = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web14first__segment(_M0FP45apple7moonseo3cmd3web19normalize__hostname(raw_website), "."), undefined));
  if (first_label === "") {
    return "";
  }
  const _bind = "-";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(first_label, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "_";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const normalized = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const first_word = new _M0TPC13ref3RefGbE(true);
  const _bind$5 = " ";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length));
  while (true) {
    let part;
    _L: {
      const _bind$6 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$6 === undefined) {
        break;
      } else {
        const _Some = _bind$6;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(part, undefined));
    if (current === "") {
      continue;
    }
    if (!first_word.val) {
      _M0IPB13StringBuilderPB6Logger13write__string(builder, " ");
    }
    _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP45apple7moonseo3cmd3web17capitalize__ascii(current));
    first_word.val = false;
    continue;
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP45apple7moonseo3cmd3web21persist__input__value(key, value) {
  _M0FP45apple7moonseo3cmd3web22set__persistent__value(key, value);
}
function _M0FP45apple7moonseo3cmd3web32reset__persistent__brief__inputs() {
  _M0FP45apple7moonseo3cmd3web24clear__persistent__value("moonseo.brand_name");
  _M0FP45apple7moonseo3cmd3web24clear__persistent__value("moonseo.website_url");
  _M0FP45apple7moonseo3cmd3web24clear__persistent__value("moonseo.article_title");
  _M0FP45apple7moonseo3cmd3web24clear__persistent__value("moonseo.primary_keyword");
  _M0FP45apple7moonseo3cmd3web24clear__persistent__value("moonseo.notes_input");
}
function _M0FP45apple7moonseo3cmd3web19current__page__mode() {
  const mode = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web15get__data__attr("previewPanel", "pageMode"), undefined));
  return mode === "" ? "idle" : mode;
}
function _M0FP45apple7moonseo3cmd3web15set__page__mode(mode) {
  _M0FP45apple7moonseo3cmd3web15set__data__attr("previewPanel", "pageMode", mode);
}
function _M0FP45apple7moonseo3cmd3web14is__page__mode(mode) {
  return _M0FP45apple7moonseo3cmd3web19current__page__mode() === mode;
}
function _M0FP45apple7moonseo3cmd3web11close__menu(id) {
  _M0FP45apple7moonseo3cmd3web14close__details(id);
}
function _M0FP45apple7moonseo3cmd3web10open__menu(id) {
  _M0FP45apple7moonseo3cmd3web13open__details(id);
}
function _M0FP45apple7moonseo3cmd3web12toggle__menu(id) {
  if (_M0FP45apple7moonseo3cmd3web17is__details__open(id)) {
    _M0FP45apple7moonseo3cmd3web11close__menu(id);
    return;
  } else {
    _M0FP45apple7moonseo3cmd3web10open__menu(id);
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web33toggle__mutually__exclusive__menu(current_id, other_id) {
  const should_open = !_M0FP45apple7moonseo3cmd3web17is__details__open(current_id);
  _M0FP45apple7moonseo3cmd3web11close__menu(other_id);
  if (should_open) {
    _M0FP45apple7moonseo3cmd3web10open__menu(current_id);
    return;
  } else {
    _M0FP45apple7moonseo3cmd3web11close__menu(current_id);
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web27close__all__floating__menus() {
  _M0FP45apple7moonseo3cmd3web11close__menu("uploadMenu");
  _M0FP45apple7moonseo3cmd3web11close__menu("briefDrawer");
  _M0FP45apple7moonseo3cmd3web11close__menu("settingsMenu");
}
function _M0FP45apple7moonseo3cmd3web27sync__export__from__preview(preview_id, export_id) {
  const article_html = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web31snapshot__export__article__html(preview_id), undefined));
  if (article_html === "") {
    return undefined;
  }
  const title = _M0FP45apple7moonseo3cmd3web15get__data__attr(export_id, "exportTitle");
  const meta_description = _M0FP45apple7moonseo3cmd3web15get__data__attr(export_id, "exportMeta");
  const slug = _M0FP45apple7moonseo3cmd3web15get__data__attr(export_id, "exportSlug");
  const lang = _M0FP45apple7moonseo3cmd3web15get__data__attr(export_id, "exportLang");
  _M0FP45apple7moonseo3cmd3web28set__cached__export__content(export_id, _M0FP25apple7moonseo30render__export__html__document(title, meta_description, article_html, slug, lang));
}
function _M0FP45apple7moonseo3cmd3web28handle__upload__menu__toggle() {
  _M0FP45apple7moonseo3cmd3web33toggle__mutually__exclusive__menu("uploadMenu", "briefDrawer");
}
function _M0FP45apple7moonseo3cmd3web27handle__brief__menu__toggle() {
  _M0FP45apple7moonseo3cmd3web33toggle__mutually__exclusive__menu("briefDrawer", "uploadMenu");
}
function _M0FP45apple7moonseo3cmd3web30handle__settings__menu__toggle() {
  _M0FP45apple7moonseo3cmd3web12toggle__menu("settingsMenu");
}
function _M0FP45apple7moonseo3cmd3web13content__lang() {
  return "en";
}
function _M0FP45apple7moonseo3cmd3web20set__status__loading(message) {
  _M0FP45apple7moonseo3cmd3web19set__status__banner("statusBanner", "loading", message, false);
}
function _M0FP45apple7moonseo3cmd3web20set__status__success(message) {
  _M0FP45apple7moonseo3cmd3web19set__status__banner("statusBanner", "success", message, false);
}
function _M0FP45apple7moonseo3cmd3web18set__status__error(message) {
  _M0FP45apple7moonseo3cmd3web19set__status__banner("statusBanner", "error", message, false);
}
function _M0FP45apple7moonseo3cmd3web20website__chip__label(state, lang) {
  const chinese = lang === "zh";
  return state === "loading" ? (chinese ? "抓取中" : "Fetching") : state === "ready" ? (chinese ? "官网正文" : "Website copy") : state === "empty" ? (chinese ? "官网来源" : "Website source") : chinese ? "抓取失败" : "Fetch failed";
}
function _M0FP45apple7moonseo3cmd3web19upload__chip__label(kind, lang) {
  const chinese = lang === "zh";
  return kind === "parsed" ? (chinese ? "已解析" : "Parsed") : kind === "failed" ? (chinese ? "解析失败" : "Parse failed") : chinese ? "来源附件" : "Source attached";
}
function _M0FP45apple7moonseo3cmd3web27set__website__source__state(state, source_url, text, chip_text) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("websiteFacts", text);
  _M0FP45apple7moonseo3cmd3web15set__data__attr("websiteFacts", "sourceState", state);
  _M0FP45apple7moonseo3cmd3web15set__data__attr("websiteFacts", "sourceUrl", source_url);
  if (_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(source_url, undefined)) === "") {
    _M0FP45apple7moonseo3cmd3web28clear__website__source__chip("sourceList");
    return;
  } else {
    _M0FP45apple7moonseo3cmd3web29render__website__source__chip("sourceList", _M0FP45apple7moonseo3cmd3web20website__chip__label(state, _M0FP45apple7moonseo3cmd3web16get__lang__state()), chip_text);
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web30apply__upload__source__payload(payload) {
  const lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const source_parts = [];
  const chip_parts = [];
  const _bind = "\u001e";
  const _it = _M0MPC16string6String5split(payload, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let record;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _record = _Some;
        record = _record;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(record, undefined));
    if (current === "") {
      continue;
    }
    const fields = [];
    const _bind$2 = "\u001f";
    const _it$2 = _M0MPC16string6String5split(current, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
    while (true) {
      let field;
      _L$2: {
        const _bind$3 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it$2);
        if (_bind$3 === undefined) {
          break;
        } else {
          const _Some = _bind$3;
          const _field = _Some;
          field = _field;
          break _L$2;
        }
      }
      _M0MPC15array5Array4pushGsE(fields, _M0IPC16string10StringViewPB4Show10to__string(field));
      continue;
    }
    if (fields.length < 3) {
      continue;
    }
    const kind = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 0), undefined));
    const name = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 1), undefined));
    const content = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 2), undefined));
    _M0MPC15array5Array4pushGsE(chip_parts, `${_M0IPC16string6StringPB4Show10to__string(kind)}\u001f${_M0IPC16string6StringPB4Show10to__string(_M0FP45apple7moonseo3cmd3web19upload__chip__label(kind, lang))}\u001f${_M0IPC16string6StringPB4Show10to__string(name)}\u001f${_M0IPC16string6StringPB4Show10to__string(content)}`);
    if (kind === "parsed") {
      _M0MPC15array5Array4pushGsE(source_parts, content);
    }
    continue;
  }
  const _bind$2 = "\n";
  _M0FP45apple7moonseo3cmd3web17set__input__value("sourceFacts", _M0MPC15array5Array4joinGsE(source_parts, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length)));
  const _bind$3 = "\u001e";
  _M0FP45apple7moonseo3cmd3web29render__upload__source__chips("sourceList", _M0MPC15array5Array4joinGsE(chip_parts, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length)));
}
function _M0FP45apple7moonseo3cmd3web31handle__source__upload__payload(payload) {
  const appended = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(payload, undefined));
  if (appended === "") {
    return undefined;
  }
  const existing = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("uploadSourceCache"), undefined));
  const next_payload = existing === "" ? appended : `${_M0IPC16string6StringPB4Show10to__string(existing)}\u001e${_M0IPC16string6StringPB4Show10to__string(appended)}`;
  _M0FP45apple7moonseo3cmd3web17set__input__value("uploadSourceCache", next_payload);
  _M0FP45apple7moonseo3cmd3web30apply__upload__source__payload(next_payload);
}
function _M0FP45apple7moonseo3cmd3web30handle__upload__source__remove(index_text) {
  const target_index = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(index_text, undefined));
  if (target_index === "") {
    return undefined;
  }
  const records = [];
  const _tmp = _M0FP45apple7moonseo3cmd3web17get__input__value("uploadSourceCache");
  const _bind = "\u001e";
  const _it = _M0MPC16string6String5split(_tmp, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let record;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _record = _Some;
        record = _record;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(record, undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(current, "")) {
      _M0MPC15array5Array4pushGsE(records, current);
    }
    continue;
  }
  const kept = [];
  let _tmp$2 = 0;
  while (true) {
    const current_index = _tmp$2;
    if (current_index < records.length) {
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IP016_24default__implPB4Show10to__stringGiE(current_index), target_index)) {
        _M0MPC15array5Array4pushGsE(kept, _M0MPC15array5Array2atGsE(records, current_index));
      }
      _tmp$2 = current_index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$2 = "\u001e";
  const payload = _M0MPC15array5Array4joinGsE(kept, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  _M0FP45apple7moonseo3cmd3web17set__input__value("uploadSourceCache", payload);
  _M0FP45apple7moonseo3cmd3web30apply__upload__source__payload(payload);
}
function _M0FP45apple7moonseo3cmd3web30handle__website__source__input(raw_url) {
  const url = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(raw_url, undefined));
  const current_url = _M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceUrl");
  const current_state = _M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceState");
  if (url === "") {
    _M0FP45apple7moonseo3cmd3web27set__website__source__state("empty", "", "", "");
    return undefined;
  }
  if (current_url === url && current_state === "ready") {
    return undefined;
  }
  _M0FP45apple7moonseo3cmd3web27set__website__source__state("loading", url, "", url);
  _M0FP45apple7moonseo3cmd3web22request__website__text(url, (text) => {
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("websiteUrl"), undefined)), url)) {
      return undefined;
    }
    if (_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(text, undefined)) === "") {
      _M0FP45apple7moonseo3cmd3web27set__website__source__state("empty", url, "", url);
      return;
    } else {
      _M0FP45apple7moonseo3cmd3web27set__website__source__state("ready", url, text, url);
      return;
    }
  }, (message) => {
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("websiteUrl"), undefined)), url)) {
      return undefined;
    }
    _M0FP45apple7moonseo3cmd3web27set__website__source__state("error", url, "", message);
  });
}
function _M0FP45apple7moonseo3cmd3web26combine__source__materials(uploaded_facts, website_facts) {
  const parts = [];
  const uploaded = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(uploaded_facts, undefined));
  const website = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(website_facts, undefined));
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(uploaded, "")) {
    _M0MPC15array5Array4pushGsE(parts, uploaded);
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(website, "")) {
    _M0MPC15array5Array4pushGsE(parts, website);
  }
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < parts.length) {
      if (index > 0) {
        _M0IPB13StringBuilderPB6Logger13write__string(builder, "\n");
      }
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0MPC15array5Array2atGsE(parts, index));
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP45apple7moonseo3cmd3web12read__inputs() {
  const brand_name = _M0FP45apple7moonseo3cmd3web17get__input__value("brandName");
  const website_url = _M0FP45apple7moonseo3cmd3web17get__input__value("websiteUrl");
  const source_materials = _M0FP45apple7moonseo3cmd3web26combine__source__materials(_M0FP45apple7moonseo3cmd3web17get__input__value("sourceFacts"), _M0FP45apple7moonseo3cmd3web17get__input__value("websiteFacts"));
  return { _0: _M0FP45apple7moonseo3cmd3web17get__input__value("articleTitle"), _1: _M0FP45apple7moonseo3cmd3web18infer__brand__name(brand_name, website_url), _2: _M0FP45apple7moonseo3cmd3web17get__input__value("primaryKeyword"), _3: _M0FP45apple7moonseo3cmd3web17get__input__value("audience"), _4: source_materials, _5: _M0FP45apple7moonseo3cmd3web17get__input__value("notesInput") };
}
function _M0FP45apple7moonseo3cmd3web19idle__preview__html(lang) {
  return lang === "zh" ? "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>你好，今天想写些什么？</h2></div>" : "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>Hello, what would you like to write today?</h2></div>";
}
function _M0FP45apple7moonseo3cmd3web27idle__audit__overview__html(lang) {
  return lang === "zh" ? "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 claim 审计结果</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 MoonBit 确定性检查</span></button></div>" : "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to review claim support</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to inspect MoonBit checks</span></button></div>";
}
function _M0FP45apple7moonseo3cmd3web24idle__audit__panel__html(lang) {
  return lang === "zh" ? "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO 审计面板</p><h3>生成后，这里会出现事实支撑与 SEO 检查。</h3></div>" : "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO audit rail</p><h3>Fact grounding and SEO checks will appear here after generation.</h3></div>";
}
function _M0FP45apple7moonseo3cmd3web33generating__audit__overview__html(lang) {
  return lang === "zh" ? "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 claim 审计结果</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>待生成</strong><span class=\"audit-summary-meta\">生成后可查看 MoonBit 确定性检查</span></button></div>" : "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to review claim support</span></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Pending</strong><span class=\"audit-summary-meta\">Generate a draft to inspect MoonBit checks</span></button></div>";
}
function _M0FP45apple7moonseo3cmd3web30generating__audit__panel__html(lang) {
  return lang === "zh" ? "<div class=\"audit-list\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>事实支撑</strong><span>待生成</span></div><p>生成草稿后，会逐条核对 claim 是否被来源材料支撑。</p></article><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>SEO 规则检查</strong><span>待生成</span></div><p>生成后可查看 MoonBit 的确定性规则检查。</p></article></div>" : "<div class=\"audit-list\"><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>Fact grounding</strong><span>Pending</span></div><p>Each claim will be reviewed against the uploaded source materials after generation.</p></article><article class=\"audit-item pass\"><div class=\"audit-top\"><strong>SEO rule checks</strong><span>Pending</span></div><p>MoonBit deterministic checks will appear after the draft is generated.</p></article></div>";
}
function _M0FP45apple7moonseo3cmd3web20set__export__enabled(enabled) {
  _M0FP45apple7moonseo3cmd3web13set__disabled("exportButton", !enabled);
}
function _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state(state) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("rerunAuditStateCache", state);
}
function _M0FP45apple7moonseo3cmd3web19render__idle__state() {
  _M0FP45apple7moonseo3cmd3web15set__page__mode("idle");
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
  _M0FP45apple7moonseo3cmd3web9set__html("previewPanel", _M0FP45apple7moonseo3cmd3web19idle__preview__html(_M0FP45apple7moonseo3cmd3web16get__lang__state()));
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP45apple7moonseo3cmd3web27idle__audit__overview__html(_M0FP45apple7moonseo3cmd3web16get__lang__state()));
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", _M0FP45apple7moonseo3cmd3web24idle__audit__panel__html(_M0FP45apple7moonseo3cmd3web16get__lang__state()));
  _M0FP45apple7moonseo3cmd3web20set__export__enabled(false);
}
function _M0FP45apple7moonseo3cmd3web47rerender__source__chips__for__current__language() {
  _M0FP45apple7moonseo3cmd3web30apply__upload__source__payload(_M0FP45apple7moonseo3cmd3web17get__input__value("uploadSourceCache"));
  const website_state = _M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceState");
  const website_url = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceUrl"), undefined));
  const website_text = _M0FP45apple7moonseo3cmd3web17get__input__value("websiteFacts");
  if (website_url === "") {
    _M0FP45apple7moonseo3cmd3web28clear__website__source__chip("sourceList");
    return;
  } else {
    const chip_text = website_state === "error" || website_state === "loading" ? website_url : _M0IP016_24default__implPB2Eq10not__equalGsE(website_url, "") ? website_url : website_text;
    _M0FP45apple7moonseo3cmd3web29render__website__source__chip("sourceList", _M0FP45apple7moonseo3cmd3web20website__chip__label(website_state, _M0FP45apple7moonseo3cmd3web16get__lang__state()), chip_text);
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web19cache__render__mode(mode) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("renderModeCache", mode);
}
function _M0FP45apple7moonseo3cmd3web29cache__generation__base__mode(mode) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("generationBaseModeCache", mode);
}
function _M0FP45apple7moonseo3cmd3web21cache__draft__payload(payload) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("draftPayloadCache", payload);
}
function _M0FP45apple7moonseo3cmd3web27cache__claim__review__state(state, payload) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimReviewStateCache", state);
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimReviewPayloadCache", payload);
}
function _M0FP45apple7moonseo3cmd3web26cache__claim__review__html(html) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimReviewHtmlCache", html);
}
function _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(supported, needs_review, unsupported, total) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimSupportedCountCache", _M0IP016_24default__implPB4Show10to__stringGiE(supported));
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimNeedsReviewCountCache", _M0IP016_24default__implPB4Show10to__stringGiE(needs_review));
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimUnsupportedCountCache", _M0IP016_24default__implPB4Show10to__stringGiE(unsupported));
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimTotalCountCache", _M0IP016_24default__implPB4Show10to__stringGiE(total));
}
function _M0FP45apple7moonseo3cmd3web27cache__draft__audit__inputs(keyword, evidence_count) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("draftKeywordCache", keyword);
  _M0FP45apple7moonseo3cmd3web17set__input__value("draftEvidenceCountCache", _M0IP016_24default__implPB4Show10to__stringGiE(evidence_count));
}
function _M0FP45apple7moonseo3cmd3web37cache__claim__snapshot__from__preview() {
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimSnapshotCache", _M0FP45apple7moonseo3cmd3web24snapshot__claim__payload("previewPanel"));
}
function _M0FP45apple7moonseo3cmd3web18parse__cached__int(id) {
  const value = new _M0TPC13ref3RefGiE(0);
  const _it = _M0MPC16string10StringView4iter(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value(id), undefined));
  while (true) {
    let scalar;
    _L: {
      const _bind = _M0MPB4Iter4nextGcE(_it);
      if (_bind === -1) {
        break;
      } else {
        const _Some = _bind;
        const _scalar = _Some;
        scalar = _scalar;
        break _L;
      }
    }
    const code = scalar;
    if (code >= 48 && code <= 57) {
      value.val = (Math.imul(value.val, 10) | 0) + (code - 48 | 0) | 0;
    }
    continue;
  }
  return value.val;
}
function _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state(state) {
  _M0FP45apple7moonseo3cmd3web17set__input__value("draftEditedStateCache", state);
}
function _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner() {
  const lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const stale = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("draftEditedStateCache"), undefined)) === "dirty";
  const claim_loading = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined)) === "loading";
  const rerun_loading = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("rerunAuditStateCache"), undefined)) === "loading";
  _M0FP45apple7moonseo3cmd3web19set__status__banner("auditStaleBanner", "loading", lang === "zh" ? "你修改过正文，当前审计结果可能已过期。" : "You edited the draft, so the current audit results may be outdated.", !stale || (claim_loading || rerun_loading));
}
function _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button() {
  const lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const stale = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("draftEditedStateCache"), undefined)) === "dirty";
  const loading = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("rerunAuditStateCache"), undefined)) === "loading";
  const claim_loading = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined)) === "loading";
  const claim_failed = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined)) === "failed";
  const label = loading && lang === "zh" ? "审计中..." : loading ? "Reviewing..." : claim_loading && lang === "zh" ? "审计中..." : claim_loading ? "Reviewing..." : lang === "zh" ? "重新审计" : "Re-run audit";
  _M0FP45apple7moonseo3cmd3web9set__text("rerunAuditButton", label);
  _M0FP45apple7moonseo3cmd3web9set__attr("rerunAuditButton", "aria-label", label);
  _M0FP45apple7moonseo3cmd3web9set__attr("rerunAuditButton", "title", label);
  _M0FP45apple7moonseo3cmd3web13set__disabled("rerunAuditButton", loading || (claim_loading || !stale && !claim_failed));
  _M0FP45apple7moonseo3cmd3web9set__attr("rerunAuditButton", "style", stale || (loading || (claim_failed || claim_loading)) ? "" : "display:none");
}
function _M0FP45apple7moonseo3cmd3web29current__preview__seo__report(ui_lang) {
  return _M0FP25apple7moonseo28audit__report__for__rendered(_M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportTitle"), _M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportMeta"), _M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportSlug"), _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web31snapshot__export__article__html("previewPanel"), undefined)), _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web30snapshot__preview__plain__text("previewPanel"), undefined)), _M0FP45apple7moonseo3cmd3web17get__input__value("draftKeywordCache"), _M0FP45apple7moonseo3cmd3web18parse__cached__int("draftEvidenceCountCache"), ui_lang);
}
function _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(claim_report, seo_report, ui_lang) {
  _M0FP45apple7moonseo3cmd3web26cache__claim__review__html(claim_report.findings_html);
  _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(claim_report.supported_count, claim_report.needs_review_count, claim_report.unsupported_count, claim_report.total_count);
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP25apple7moonseo23render__audit__overview(claim_report, seo_report, ui_lang));
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", `${_M0IPC16string6StringPB4Show10to__string(claim_report.findings_html)}${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo26render__seo__rule__section(seo_report, ui_lang))}`);
}
function _M0FP45apple7moonseo3cmd3web29cached__claim__review__report() {
  const state = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined));
  return _M0FP25apple7moonseo31claim__review__report__snapshot(_M0FP45apple7moonseo3cmd3web18parse__cached__int("claimSupportedCountCache"), _M0FP45apple7moonseo3cmd3web18parse__cached__int("claimNeedsReviewCountCache"), _M0FP45apple7moonseo3cmd3web18parse__cached__int("claimUnsupportedCountCache"), _M0FP45apple7moonseo3cmd3web18parse__cached__int("claimTotalCountCache"), _M0IP016_24default__implPB2Eq10not__equalGsE(state, "insufficient"), _M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewHtmlCache"));
}
function _M0FP45apple7moonseo3cmd3web32rerun__seo__audit__from__preview() {
  if (!_M0FP45apple7moonseo3cmd3web14is__page__mode("ready")) {
    return undefined;
  }
  const article_html = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web31snapshot__export__article__html("previewPanel"), undefined));
  const plain_text = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web30snapshot__preview__plain__text("previewPanel"), undefined));
  if (article_html === "" || plain_text === "") {
    return undefined;
  }
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const claim_report = _M0FP45apple7moonseo3cmd3web29cached__claim__review__report();
  const seo_report = _M0FP25apple7moonseo28audit__report__for__rendered(_M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportTitle"), _M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportMeta"), _M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportSlug"), article_html, plain_text, _M0FP45apple7moonseo3cmd3web17get__input__value("draftKeywordCache"), _M0FP45apple7moonseo3cmd3web18parse__cached__int("draftEvidenceCountCache"), ui_lang);
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP25apple7moonseo23render__audit__overview(claim_report, seo_report, ui_lang));
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", `${_M0IPC16string6StringPB4Show10to__string(claim_report.findings_html)}${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo26render__seo__rule__section(seo_report, ui_lang))}`);
  _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "SEO 审计已按当前正文重新计算。" : "SEO audit refreshed from the current draft.");
}
function _M0FP45apple7moonseo3cmd3web35rerun__claim__review__from__preview() {
  if (!_M0FP45apple7moonseo3cmd3web14is__page__mode("ready")) {
    return false;
  }
  let source_materials_raw;
  let primary_keyword;
  let _article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const __article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    _article_title = __article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  if (!_M0FP25apple7moonseo18has__real__sources(source_materials_raw)) {
    return false;
  }
  const article_html = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web31snapshot__export__article__html("previewPanel"), undefined));
  const plain_text = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web30snapshot__preview__plain__text("previewPanel"), undefined));
  const claims = _M0FP25apple7moonseo30claim__anchors__from__snapshot(_M0FP45apple7moonseo3cmd3web17get__input__value("claimSnapshotCache"));
  if (article_html === "" || (plain_text === "" || claims.length === 0)) {
    return false;
  }
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const seo_report = _M0FP45apple7moonseo3cmd3web29current__preview__seo__report(ui_lang);
  const loading_claim_report = _M0FP25apple7moonseo30loading__claim__review__report(claims.length, ui_lang);
  _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("loading", "");
  _M0FP45apple7moonseo3cmd3web26cache__claim__review__html(loading_claim_report.findings_html);
  _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(0, 0, 0, claims.length);
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("loading");
  _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(loading_claim_report, seo_report, ui_lang);
  _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", "", ui_lang);
  _M0FP45apple7moonseo3cmd3web25show__audit__section__dom("factAuditSection");
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
  _M0FP45apple7moonseo3cmd3web20set__status__loading(ui_lang === "zh" ? "正在按当前正文重新审阅关键 claims。" : "Reviewing key claims against the current draft.");
  const prompts_payload = _M0FP25apple7moonseo37build__claim__review__prompt__batches(_M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportTitle"), brand_name, primary_keyword, audience, source_materials_raw, notes_raw, claims, ui_lang, 8);
  _M0FP45apple7moonseo3cmd3web29request__ai__payload__batches("/api/claim-review", prompts_payload, (payload) => {
    const claim_report = _M0FP25apple7moonseo36claim__review__report__from__payload(payload, claims, source_materials_raw, ui_lang);
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("success", payload);
    _M0FP45apple7moonseo3cmd3web26cache__claim__review__html(claim_report.findings_html);
    _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(claim_report.supported_count, claim_report.needs_review_count, claim_report.unsupported_count, claim_report.total_count);
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
    _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(claim_report, seo_report, ui_lang);
    _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", payload, ui_lang);
    _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
    _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "SEO 和 claim 审计已按当前正文重新计算。" : "SEO and claim audits refreshed from the current draft.");
  }, (message) => {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("failed", message);
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
    _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("dirty");
    _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(_M0FP25apple7moonseo29failed__claim__review__report(message, claims.length, ui_lang), seo_report, ui_lang);
    _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", "", ui_lang);
    _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    _M0FP45apple7moonseo3cmd3web18set__status__error(ui_lang === "zh" ? `SEO 审计已刷新，但 claim review 重跑失败：${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo20localized__ai__error(message, ui_lang))}` : `SEO audit refreshed, but claim review rerun failed: ${_M0IPC16string6StringPB4Show10to__string(message)}`);
  });
  return true;
}
function _M0FP45apple7moonseo3cmd3web43retry__failed__claim__review__from__preview() {
  if (!_M0FP45apple7moonseo3cmd3web14is__page__mode("ready")) {
    return false;
  }
  let source_materials_raw;
  let primary_keyword;
  let _article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const __article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    _article_title = __article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  if (!_M0FP25apple7moonseo18has__real__sources(source_materials_raw)) {
    return false;
  }
  const article_html = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web31snapshot__export__article__html("previewPanel"), undefined));
  const plain_text = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web30snapshot__preview__plain__text("previewPanel"), undefined));
  const claims = _M0FP25apple7moonseo30claim__anchors__from__snapshot(_M0FP45apple7moonseo3cmd3web17get__input__value("claimSnapshotCache"));
  if (article_html === "" || (plain_text === "" || claims.length === 0)) {
    return false;
  }
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const seo_report = _M0FP45apple7moonseo3cmd3web29current__preview__seo__report(ui_lang);
  const loading_claim_report = _M0FP25apple7moonseo30loading__claim__review__report(claims.length, ui_lang);
  _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("loading", "");
  _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(0, 0, 0, claims.length);
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("loading");
  _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(loading_claim_report, seo_report, ui_lang);
  _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", "", ui_lang);
  _M0FP45apple7moonseo3cmd3web25show__audit__section__dom("factAuditSection");
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
  _M0FP45apple7moonseo3cmd3web20set__status__loading(ui_lang === "zh" ? "正在重新尝试逐条 claim 审计。" : "Retrying the claim-by-claim review.");
  const prompts_payload = _M0FP25apple7moonseo37build__claim__review__prompt__batches(_M0FP45apple7moonseo3cmd3web15get__data__attr("exportButton", "exportTitle"), brand_name, primary_keyword, audience, source_materials_raw, notes_raw, claims, ui_lang, 8);
  _M0FP45apple7moonseo3cmd3web29request__ai__payload__batches("/api/claim-review", prompts_payload, (payload) => {
    const claim_report = _M0FP25apple7moonseo36claim__review__report__from__payload(payload, claims, source_materials_raw, ui_lang);
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("success", payload);
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
    _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(claim_report, seo_report, ui_lang);
    _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", payload, ui_lang);
    _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
    _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "逐条 claim 审计已恢复，你可以继续查看事实支撑。" : "Claim review is available again. You can inspect the fact grounding now.");
  }, (message) => {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("failed", message);
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
    _M0FP45apple7moonseo3cmd3web32render__claim__review__with__seo(_M0FP25apple7moonseo29failed__claim__review__report(message, claims.length, ui_lang), seo_report, ui_lang);
    _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", "", ui_lang);
    _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    _M0FP45apple7moonseo3cmd3web18set__status__error(ui_lang === "zh" ? `逐条 claim 审计重试失败：${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo20localized__ai__error(message, ui_lang))}` : `Retrying the claim review failed: ${_M0IPC16string6StringPB4Show10to__string(message)}`);
  });
  return true;
}
function _M0FP45apple7moonseo3cmd3web39rerender__audit__for__current__language() {
  if (_M0FP45apple7moonseo3cmd3web14is__page__mode("idle")) {
    return undefined;
  }
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  let source_materials_raw;
  let primary_keyword;
  let article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const _article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    article_title = _article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  const render_mode = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("renderModeCache"), undefined));
  const draft_payload = _M0FP45apple7moonseo3cmd3web17get__input__value("draftPayloadCache");
  const claim_state = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined));
  const claim_payload = _M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewPayloadCache");
  let draft;
  _L$2: {
    const _bind = render_mode === "ai" && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(draft_payload, undefined)), "") ? _M0FP25apple7moonseo29generate__ai__demo__localized(article_title, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, draft_payload, _M0FP45apple7moonseo3cmd3web13content__lang()) : _M0FP25apple7moonseo25generate__demo__localized(article_title, brand_name, primary_keyword, audience, source_materials_raw, _M0FP45apple7moonseo3cmd3web13content__lang());
    const _draft = _bind._0;
    draft = _draft;
    break _L$2;
  }
  const seo_report = _M0FP25apple7moonseo22audit__report__for__ui(draft, ui_lang);
  const claim_report = claim_state === "success" ? _M0FP25apple7moonseo36claim__review__report__from__payload(claim_payload, draft.claims, source_materials_raw, ui_lang) : claim_state === "failed" ? _M0FP25apple7moonseo29failed__claim__review__report(claim_payload, draft.claims.length, ui_lang) : claim_state === "loading" ? _M0FP25apple7moonseo30loading__claim__review__report(draft.claims.length, ui_lang) : claim_state === "insufficient" ? _M0FP25apple7moonseo35insufficient__claim__review__report(ui_lang) : _M0FP25apple7moonseo28empty__claim__review__report(draft.claims.length, ui_lang);
  _M0FP45apple7moonseo3cmd3web20set__export__enabled(true);
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP25apple7moonseo23render__audit__overview(claim_report, seo_report, ui_lang));
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", `${_M0IPC16string6StringPB4Show10to__string(claim_report.findings_html)}${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo26render__seo__rule__section(seo_report, ui_lang))}`);
}
function _M0FP45apple7moonseo3cmd3web51rerender__generating__state__for__current__language() {
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const base_mode = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("generationBaseModeCache"), undefined));
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
  _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
  if (base_mode === "idle" || base_mode === "") {
    _M0FP45apple7moonseo3cmd3web9set__html("previewPanel", _M0FP45apple7moonseo3cmd3web19idle__preview__html(ui_lang));
  }
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP45apple7moonseo3cmd3web33generating__audit__overview__html(ui_lang));
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", _M0FP45apple7moonseo3cmd3web30generating__audit__panel__html(ui_lang));
  _M0FP45apple7moonseo3cmd3web20set__export__enabled(false);
  _M0FP45apple7moonseo3cmd3web20set__status__loading(ui_lang === "zh" ? "正在生成英文长文草稿。答辩时请优先使用稳定 Wi-Fi，网络会比热点更稳。" : "Generating a long-form English draft. For demos, stable Wi-Fi is more reliable than a mobile hotspot.");
}
function _M0FP45apple7moonseo3cmd3web28sync__generate__button__copy() {
  const lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const generating = _M0FP45apple7moonseo3cmd3web14is__page__mode("generating");
  _M0FP45apple7moonseo3cmd3web9set__text("generateButton", generating ? "…" : "↑");
  _M0FP45apple7moonseo3cmd3web9set__attr("generateButton", "aria-label", generating ? (lang === "zh" ? "正在生成草稿" : "Generating Draft") : lang === "zh" ? "生成草稿" : "Generate Draft");
  _M0FP45apple7moonseo3cmd3web9set__attr("generateButton", "title", generating ? (lang === "zh" ? "正在生成草稿" : "Generating Draft") : lang === "zh" ? "生成草稿" : "Generate Draft");
  _M0FP45apple7moonseo3cmd3web13set__disabled("generateButton", generating);
}
function _M0FP45apple7moonseo3cmd3web15apply__rendered(draft, report, claim_report, claim_payload, ui_lang) {
  _M0FP45apple7moonseo3cmd3web15set__page__mode("ready");
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
  _M0FP45apple7moonseo3cmd3web20set__export__enabled(true);
  _M0FP45apple7moonseo3cmd3web19cache__export__file("exportButton", _M0FP25apple7moonseo16export__filename(draft), draft.export_html, draft.title, draft.meta_description, draft.slug, _M0FP45apple7moonseo3cmd3web13content__lang());
  _M0FP45apple7moonseo3cmd3web9set__html("scorePanel", _M0FP25apple7moonseo23render__audit__overview(claim_report, report, ui_lang));
  _M0FP45apple7moonseo3cmd3web26cache__claim__review__html(claim_report.findings_html);
  _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(claim_report.supported_count, claim_report.needs_review_count, claim_report.unsupported_count, claim_report.total_count);
  _M0FP45apple7moonseo3cmd3web27cache__draft__audit__inputs(draft.keyword, draft.evidence_count);
  _M0FP45apple7moonseo3cmd3web9set__html("auditPanel", `${_M0IPC16string6StringPB4Show10to__string(claim_report.findings_html)}${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo26render__seo__rule__section(report, ui_lang))}`);
  _M0FP45apple7moonseo3cmd3web9set__html("previewPanel", draft.preview_html);
  _M0FP45apple7moonseo3cmd3web32sync__claim__evidence__refs__dom("previewPanel", claim_payload, ui_lang);
  _M0FP45apple7moonseo3cmd3web37cache__claim__snapshot__from__preview();
  _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
  _M0FP45apple7moonseo3cmd3web15set__data__attr("previewPanel", "selectedClaim", "");
  _M0FP45apple7moonseo3cmd3web27sync__export__from__preview("previewPanel", "exportButton");
  _M0FP45apple7moonseo3cmd3web29render__evidence__detail__dom("previewPanel", "evidenceCoverageDetail", "evidenceCoverageCard");
}
function _M0FP45apple7moonseo3cmd3web22trigger__claim__review(draft, seo_report, brand_name, primary_keyword, audience, facts_raw, notes_raw, ui_lang) {
  const prompts_payload = _M0FP25apple7moonseo37build__claim__review__prompt__batches(draft.title, brand_name, primary_keyword, audience, facts_raw, notes_raw, draft.claims, ui_lang, 8);
  _M0FP45apple7moonseo3cmd3web20set__status__loading(ui_lang === "zh" ? "正文已生成，AI 正在逐条审阅关键 claims 是否被来源材料支撑。" : "The draft is ready. AI is now reviewing key claims against the uploaded source materials.");
  _M0FP45apple7moonseo3cmd3web29request__ai__payload__batches("/api/claim-review", prompts_payload, (payload) => {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("success", payload);
    _M0FP45apple7moonseo3cmd3web15apply__rendered(draft, seo_report, _M0FP25apple7moonseo36claim__review__report__from__payload(payload, draft.claims, facts_raw, ui_lang), payload, ui_lang);
    _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "Fact grounding audit 已更新。你现在可以逐条查看 claim 的支撑情况。" : "The fact-grounding audit is ready. You can now inspect each reviewed claim.");
  }, (message) => {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("failed", message);
    _M0FP45apple7moonseo3cmd3web15apply__rendered(draft, seo_report, _M0FP25apple7moonseo29failed__claim__review__report(message, draft.claims.length, ui_lang), "", ui_lang);
    _M0FP45apple7moonseo3cmd3web18set__status__error(ui_lang === "zh" ? `草稿已生成，但逐条 claim 审阅暂时失败：${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo20localized__ai__error(message, ui_lang))}` : `The draft was generated, but the claim-by-claim review failed: ${_M0IPC16string6StringPB4Show10to__string(message)}`);
  });
}
function _M0FP45apple7moonseo3cmd3web19render__ai__content(payload) {
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  let source_materials_raw;
  let primary_keyword;
  let article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const _article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    article_title = _article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  let draft;
  _L$2: {
    const _bind = _M0FP25apple7moonseo29generate__ai__demo__localized(article_title, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, payload, _M0FP45apple7moonseo3cmd3web13content__lang());
    const _draft = _bind._0;
    draft = _draft;
    break _L$2;
  }
  _M0FP45apple7moonseo3cmd3web19cache__render__mode("ai");
  _M0FP45apple7moonseo3cmd3web21cache__draft__payload(payload);
  const seo_report = _M0FP25apple7moonseo22audit__report__for__ui(draft, ui_lang);
  _M0FP45apple7moonseo3cmd3web15apply__rendered(draft, seo_report, _M0FP25apple7moonseo18has__real__sources(source_materials_raw) ? _M0FP25apple7moonseo30loading__claim__review__report(draft.claims.length, ui_lang) : _M0FP25apple7moonseo35insufficient__claim__review__report(ui_lang), "", ui_lang);
  if (_M0FP25apple7moonseo18has__real__sources(source_materials_raw)) {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("loading", "");
    _M0FP45apple7moonseo3cmd3web25show__audit__section__dom("factAuditSection");
    _M0FP45apple7moonseo3cmd3web22trigger__claim__review(draft, seo_report, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, ui_lang);
    return;
  } else {
    _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("insufficient", "");
    _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "正文已生成，但当前没有真实来源材料，暂不进行事实支撑审计。" : "The draft is ready, but fact-grounding review is skipped until real source material is added.");
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web46refresh__claim__review__for__current__language() {
  if (_M0FP45apple7moonseo3cmd3web14is__page__mode("idle") || _M0FP45apple7moonseo3cmd3web14is__page__mode("generating")) {
    return undefined;
  }
  const claim_state = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("claimReviewStateCache"), undefined));
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(claim_state, "success")) {
    return undefined;
  }
  let source_materials_raw;
  let primary_keyword;
  let article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const _article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    article_title = _article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  if (!_M0FP25apple7moonseo18has__real__sources(source_materials_raw)) {
    return undefined;
  }
  const render_mode = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("renderModeCache"), undefined));
  const draft_payload = _M0FP45apple7moonseo3cmd3web17get__input__value("draftPayloadCache");
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  let draft;
  _L$2: {
    const _bind = render_mode === "ai" && _M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(draft_payload, undefined)), "") ? _M0FP25apple7moonseo29generate__ai__demo__localized(article_title, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, draft_payload, _M0FP45apple7moonseo3cmd3web13content__lang()) : _M0FP25apple7moonseo25generate__demo__localized(article_title, brand_name, primary_keyword, audience, source_materials_raw, _M0FP45apple7moonseo3cmd3web13content__lang());
    const _draft = _bind._0;
    draft = _draft;
    break _L$2;
  }
  const seo_report = _M0FP25apple7moonseo22audit__report__for__ui(draft, ui_lang);
  _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("loading", "");
  _M0FP45apple7moonseo3cmd3web15apply__rendered(draft, seo_report, _M0FP25apple7moonseo30loading__claim__review__report(draft.claims.length, ui_lang), "", ui_lang);
  _M0FP45apple7moonseo3cmd3web22trigger__claim__review(draft, seo_report, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, ui_lang);
}
function _M0FP45apple7moonseo3cmd3web15export__current() {
  _M0FP45apple7moonseo3cmd3web22download__cached__file("exportButton");
}
function _M0FP45apple7moonseo3cmd3web25restore__generate__button() {
  _M0FP45apple7moonseo3cmd3web29cache__generation__base__mode("ready");
  _M0FP45apple7moonseo3cmd3web15set__page__mode("ready");
  _M0FP45apple7moonseo3cmd3web28sync__generate__button__copy();
}
function _M0FP45apple7moonseo3cmd3web19trigger__generation() {
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const previous_mode = _M0FP45apple7moonseo3cmd3web19current__page__mode();
  let source_materials_raw;
  let primary_keyword;
  let article_title;
  let brand_name;
  let audience;
  let notes_raw;
  _L: {
    const _bind = _M0FP45apple7moonseo3cmd3web12read__inputs();
    const _article_title = _bind._0;
    const _brand_name = _bind._1;
    const _primary_keyword = _bind._2;
    const _audience = _bind._3;
    const _source_materials_raw = _bind._4;
    const _notes_raw = _bind._5;
    source_materials_raw = _source_materials_raw;
    primary_keyword = _primary_keyword;
    article_title = _article_title;
    brand_name = _brand_name;
    audience = _audience;
    notes_raw = _notes_raw;
    break _L;
  }
  const website_state = _M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceState");
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web17get__input__value("websiteUrl"), undefined)), "") && website_state === "loading") {
    _M0FP45apple7moonseo3cmd3web20set__status__loading(ui_lang === "zh" ? "官网正文仍在抓取中，请稍候再生成。" : "Website content is still loading. Please generate again in a moment.");
    return undefined;
  }
  const prompt = _M0FP25apple7moonseo17build__ai__prompt(article_title, brand_name, primary_keyword, audience, source_materials_raw, notes_raw, _M0FP45apple7moonseo3cmd3web13content__lang());
  _M0FP45apple7moonseo3cmd3web29cache__generation__base__mode(previous_mode);
  _M0FP45apple7moonseo3cmd3web15set__page__mode("generating");
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
  _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
  _M0FP45apple7moonseo3cmd3web28sync__generate__button__copy();
  _M0FP45apple7moonseo3cmd3web51rerender__generating__state__for__current__language();
  _M0FP45apple7moonseo3cmd3web20request__ai__payload("/api/draft", prompt, (payload) => {
    _M0FP45apple7moonseo3cmd3web19render__ai__content(payload);
    _M0FP45apple7moonseo3cmd3web25restore__generate__button();
  }, (message) => {
    _M0FP45apple7moonseo3cmd3web15set__page__mode(previous_mode);
    _M0FP45apple7moonseo3cmd3web28sync__generate__button__copy();
    _M0FP45apple7moonseo3cmd3web18set__status__error(ui_lang === "zh" ? `AI 生成失败，当前保留你刚才的页面状态：${_M0IPC16string6StringPB4Show10to__string(_M0FP25apple7moonseo20localized__ai__error(message, ui_lang))}` : `AI generation failed, so the current page state was preserved: ${_M0IPC16string6StringPB4Show10to__string(message)}`);
  });
}
function _M0FP45apple7moonseo3cmd3web15apply__language(lang) {
  _M0FP45apple7moonseo3cmd3web16set__lang__state(lang);
  _M0FP45apple7moonseo3cmd3web9set__text("exportButton", lang === "zh" ? "导出 HTML" : "Export HTML");
  _M0FP45apple7moonseo3cmd3web9set__text("briefSummaryTitle", lang === "zh" ? "自定义" : "Custom");
  _M0FP45apple7moonseo3cmd3web9set__text("articleTitleLabel", lang === "zh" ? "文章标题" : "Article Title");
  _M0FP45apple7moonseo3cmd3web9set__text("brandLabel", lang === "zh" ? "品牌名称" : "Brand Name");
  _M0FP45apple7moonseo3cmd3web9set__text("keywordLabel", lang === "zh" ? "主关键词" : "Primary Keyword");
  _M0FP45apple7moonseo3cmd3web9set__text("websiteLabel", lang === "zh" ? "品牌官网" : "Brand Website");
  _M0FP45apple7moonseo3cmd3web9set__text("settingsLanguageLabel", lang === "zh" ? "语言" : "Language");
  _M0FP45apple7moonseo3cmd3web9set__html("settingsSummary", "<span class=\"settings-gear\" aria-hidden=\"true\">&#9881;</span>");
  _M0FP45apple7moonseo3cmd3web9set__attr("settingsSummary", "aria-label", lang === "zh" ? "设置" : "Settings");
  _M0FP45apple7moonseo3cmd3web9set__attr("settingsSummary", "title", lang === "zh" ? "设置" : "Settings");
  _M0FP45apple7moonseo3cmd3web9set__attr("brandName", "placeholder", lang === "zh" ? "例如 Snaplii" : "For example: Snaplii");
  lang === "zh";
  _M0FP45apple7moonseo3cmd3web9set__attr("websiteUrl", "placeholder", "https://");
  _M0FP45apple7moonseo3cmd3web9set__attr("articleTitle", "placeholder", lang === "zh" ? "例如 Best Gift Card App in Canada" : "For example: Best Gift Card App in Canada");
  _M0FP45apple7moonseo3cmd3web9set__attr("primaryKeyword", "placeholder", lang === "zh" ? "例如 gift card app in Canada" : "For example: gift card app in Canada");
  _M0FP45apple7moonseo3cmd3web9set__attr("notesInput", "placeholder", lang === "zh" ? "补充你的要求，或说明这篇文章想强调什么" : "Add a note about what this draft should emphasize");
  _M0FP45apple7moonseo3cmd3web9set__text("uploadButton", "+");
  _M0FP45apple7moonseo3cmd3web9set__attr("uploadButton", "aria-label", lang === "zh" ? "上传资料" : "Upload Sources");
  _M0FP45apple7moonseo3cmd3web9set__attr("uploadButton", "title", lang === "zh" ? "上传资料" : "Upload Sources");
  _M0FP45apple7moonseo3cmd3web9set__text("uploadPickerButton", lang === "zh" ? "选择文件" : "Choose Files");
  _M0FP45apple7moonseo3cmd3web9set__text("uploadFormatsNote", lang === "zh" ? "支持 fact sheet、PDF、DOC、DOCX、TXT、MD" : "Supports fact sheets, PDF, DOC, DOCX, TXT, and MD");
  _M0FP45apple7moonseo3cmd3web47rerender__source__chips__for__current__language();
  _M0FP45apple7moonseo3cmd3web28sync__generate__button__copy();
  if (_M0FP45apple7moonseo3cmd3web14is__page__mode("idle")) {
    _M0FP45apple7moonseo3cmd3web19render__idle__state();
  } else {
    if (_M0FP45apple7moonseo3cmd3web14is__page__mode("generating")) {
      _M0FP45apple7moonseo3cmd3web51rerender__generating__state__for__current__language();
    } else {
      _M0FP45apple7moonseo3cmd3web39rerender__audit__for__current__language();
      _M0FP45apple7moonseo3cmd3web46refresh__claim__review__for__current__language();
    }
  }
  if (!_M0FP45apple7moonseo3cmd3web14is__page__mode("generating")) {
    _M0FP45apple7moonseo3cmd3web20set__status__success(lang === "zh" ? "界面语言已更新。文章默认仍会按英文生成，除非你在输入里明确要求其他语言。" : "UI language updated. Drafts still default to English unless your input explicitly asks for another language.");
  }
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
}
function _M0FP45apple7moonseo3cmd3web16app__shell__html() {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section class=\"app-layout\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section class=\"left-rail\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"statusBanner\" class=\"status-banner\" hidden></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section class=\"panel draft-panel\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"previewPanel\" class=\"draft-scroll\"></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</section>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<section class=\"composer-bar\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"composer-shell\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"sourceUpload\" type=\"file\" accept=\".txt,.md,.pdf,.doc,.docx\" multiple hidden />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"sourceFacts\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"uploadSourceCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"websiteFacts\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"renderModeCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"generationBaseModeCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"draftPayloadCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimReviewStateCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimReviewPayloadCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimReviewHtmlCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimSupportedCountCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimNeedsReviewCountCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimUnsupportedCountCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimTotalCountCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"claimSnapshotCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"draftKeywordCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"draftEvidenceCountCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"draftEditedStateCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"rerunAuditStateCache\" hidden></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"sourceList\" class=\"source-list\"></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<textarea id=\"notesInput\" class=\"composer-input\" rows=\"3\"></textarea>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"composer-toolbar\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<details id=\"uploadMenu\" class=\"composer-menu\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<summary id=\"uploadButton\" class=\"toolbar-button icon-button secondary\" aria-label=\"Upload Sources\" title=\"Upload Sources\">+</summary>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"composer-menu-panel upload-menu-panel\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"uploadPickerButton\" type=\"button\" class=\"menu-action\">Choose Files</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p id=\"uploadFormatsNote\" class=\"menu-note\">Supports fact sheets, PDF, DOC, DOCX, TXT, and MD</p>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></details>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<details id=\"briefDrawer\" class=\"composer-menu brief-drawer\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<summary id=\"briefSummaryTitle\" class=\"toolbar-button\">Custom</summary>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"composer-menu-panel brief-body\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"brief-grid\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<label class=\"field\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span id=\"brandLabel\">Brand Name</span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"brandName\" type=\"text\" value=\"\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</label>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<label class=\"field\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span id=\"websiteLabel\">Brand Website</span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"websiteUrl\" type=\"url\" value=\"\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</label>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<label class=\"field\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span id=\"articleTitleLabel\">Article Title</span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"articleTitle\" type=\"text\" value=\"\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</label>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<label class=\"field\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<span id=\"keywordLabel\">Primary Keyword</span>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"primaryKeyword\" type=\"text\" value=\"\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</label>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<input id=\"audience\" type=\"hidden\" value=\"\" />");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></details>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"generateButton\" type=\"button\" class=\"send-button secondary\" aria-label=\"Generate Draft\" title=\"Generate Draft\">↑</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></div></section></section>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<aside class=\"panel audit-panel\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"audit-actions\"><div class=\"audit-toolbar\"><div class=\"audit-toolbar-actions\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"exportButton\" type=\"button\">Export HTML</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"rerunAuditButton\" type=\"button\" class=\"secondary\" style=\"display:none\">Re-run audit</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<details id=\"settingsMenu\" class=\"settings-menu\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<summary id=\"settingsSummary\" aria-label=\"Settings\" title=\"Settings\"><span class=\"settings-gear\" aria-hidden=\"true\">&#9881;</span></summary>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"settings-panel\"><div class=\"settings-section\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p id=\"settingsLanguageLabel\" class=\"settings-label\">Language</p>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"lang-switch\" aria-label=\"language switch\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"langZhButton\" type=\"button\" data-lang-switch=\"zh\" class=\"lang-pill\">中文</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<button id=\"langEnButton\" type=\"button\" data-lang-switch=\"en\" class=\"lang-pill active\">EN</button>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></div></div></details></div></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div class=\"audit-scroll\">");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"auditStaleBanner\" class=\"status-banner audit-stale-banner\" hidden></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"scorePanel\"></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "<div id=\"auditPanel\"></div>");
  _M0IPB13StringBuilderPB6Logger13write__string(builder, "</div></aside></section>");
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP45apple7moonseo3cmd3web24handle__claim__selection(claim_id) {
  const normalized = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(claim_id, undefined));
  if (normalized === "") {
    return undefined;
  }
  const current_selected = _M0FP45apple7moonseo3cmd3web15get__data__attr("previewPanel", "selectedClaim");
  if (current_selected === normalized) {
    _M0FP45apple7moonseo3cmd3web15set__data__attr("previewPanel", "selectedClaim", "");
    _M0FP45apple7moonseo3cmd3web23clear__claim__selection("previewPanel", "auditPanel");
    return;
  } else {
    _M0FP45apple7moonseo3cmd3web15set__data__attr("previewPanel", "selectedClaim", normalized);
    _M0FP45apple7moonseo3cmd3web23clear__claim__selection("previewPanel", "auditPanel");
    _M0FP45apple7moonseo3cmd3web18select__claim__dom("previewPanel", "auditPanel", normalized);
    _M0FP45apple7moonseo3cmd3web25show__audit__section__dom("factAuditSection");
    return;
  }
}
function _M0FP45apple7moonseo3cmd3web21split__event__payload(payload, separator) {
  const parts = [];
  const _it = _M0MPC16string6String5split(payload, new _M0TPC16string10StringView(separator, 0, separator.length));
  while (true) {
    let part;
    _L: {
      const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind === undefined) {
        break;
      } else {
        const _Some = _bind;
        const _part = _Some;
        part = _part;
        break _L;
      }
    }
    _M0MPC15array5Array4pushGsE(parts, _M0IPC16string10StringViewPB4Show10to__string(part));
    continue;
  }
  return parts;
}
function _M0FP45apple7moonseo3cmd3web20handle__claim__apply(payload) {
  const parts = _M0FP45apple7moonseo3cmd3web21split__event__payload(payload, "\u001f");
  if (parts.length < 2) {
    return undefined;
  }
  const claim_id = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(parts, 0), undefined));
  const rewrite = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(parts, 1), undefined));
  if (claim_id === "" || rewrite === "") {
    return undefined;
  }
  _M0FP45apple7moonseo3cmd3web26apply__claim__rewrite__dom("previewPanel", "auditPanel", claim_id, rewrite);
  _M0FP45apple7moonseo3cmd3web27sync__export__from__preview("previewPanel", "exportButton");
  _M0FP45apple7moonseo3cmd3web37cache__claim__snapshot__from__preview();
  _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("dirty");
  _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
  _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
  _M0FP45apple7moonseo3cmd3web20set__status__loading(_M0FP45apple7moonseo3cmd3web16get__lang__state() === "zh" ? "已应用改写建议，当前 claim 与 SEO 审计结果需要重新计算。" : "The rewrite was applied. Refresh the claim and SEO audits to review the updated draft.");
  _M0FP45apple7moonseo3cmd3web24handle__claim__selection(claim_id);
}
function _M0FP45apple7moonseo3cmd3web26compact__evidence__excerpt(text) {
  const _bind = "\r";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = " ";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "\n";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = " ";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = " ";
  const normalized = _M0MPB4Iter4join(_M0MPB4Iter11filter__mapGRPC16string10StringViewsE(_M0MPC16string6String5split(_tmp$4, new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length)), (part) => {
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(part, undefined));
    return current === "" ? undefined : current;
  }), " ");
  return normalized.length <= 220 ? normalized : `${_M0IPC16string6StringPB4Show10to__string(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String11sub_2einner(normalized, 0, 220)))}...`;
}
function _M0FP45apple7moonseo3cmd3web28evidence__selection__excerpt(source_id, fallback_body) {
  const combined_sources = _M0FP45apple7moonseo3cmd3web26combine__source__materials(_M0FP45apple7moonseo3cmd3web17get__input__value("sourceFacts"), _M0FP45apple7moonseo3cmd3web17get__input__value("websiteFacts"));
  const source_notes = _M0FP25apple7moonseo12parse__facts(combined_sources);
  const target = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(source_id, undefined));
  let _tmp = 0;
  while (true) {
    const index = _tmp;
    if (index < source_notes.length) {
      if (_M0IP016_24default__implPB4Show10to__stringGiE(index + 1 | 0) === target) {
        const source_note = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(source_notes, index), undefined));
        if (_M0IP016_24default__implPB2Eq10not__equalGsE(source_note, "")) {
          const preview = _M0FP45apple7moonseo3cmd3web26compact__evidence__excerpt(source_note);
          if (_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(preview, undefined)).length >= 12) {
            return preview;
          }
          break;
        }
      }
      _tmp = index + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const fallback = _M0FP45apple7moonseo3cmd3web26compact__evidence__excerpt(fallback_body);
  return _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(fallback, undefined)).length >= 12 ? fallback : "";
}
function _M0FP45apple7moonseo3cmd3web34evidence__selection__source__label() {
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  return ui_lang === "zh" ? "用于标记正文对应的来源摘录" : "Marks the source excerpt used beside the body";
}
function _M0FP45apple7moonseo3cmd3web20parse__source__index(source_id) {
  const value = new _M0TPC13ref3RefGiE(0);
  const _it = _M0MPC16string10StringView4iter(_M0MPC16string6String4trim(source_id, undefined));
  while (true) {
    let scalar;
    _L: {
      const _bind = _M0MPB4Iter4nextGcE(_it);
      if (_bind === -1) {
        break;
      } else {
        const _Some = _bind;
        const _scalar = _Some;
        scalar = _scalar;
        break _L;
      }
    }
    const code = scalar;
    if (code >= 48 && code <= 57) {
      value.val = (Math.imul(value.val, 10) | 0) + (code - 48 | 0) | 0;
    }
    continue;
  }
  return value.val;
}
function _M0FP45apple7moonseo3cmd3web21source__origin__label(kind, name) {
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  const trimmed_name = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(name, undefined));
  return kind === "website" ? (ui_lang === "zh" ? `来自官网：${_M0IPC16string6StringPB4Show10to__string(trimmed_name)}` : `From website: ${_M0IPC16string6StringPB4Show10to__string(trimmed_name)}`) : ui_lang === "zh" ? `来自上传文件：${_M0IPC16string6StringPB4Show10to__string(trimmed_name)}` : `From uploaded file: ${_M0IPC16string6StringPB4Show10to__string(trimmed_name)}`;
}
function _M0FP45apple7moonseo3cmd3web27evidence__selection__origin(source_id) {
  const target = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(source_id, undefined));
  const target_index = _M0FP45apple7moonseo3cmd3web20parse__source__index(target);
  const upload_payload = _M0FP45apple7moonseo3cmd3web17get__input__value("uploadSourceCache");
  const next_index = new _M0TPC13ref3RefGiE(1);
  const _bind = "\u001e";
  const _it = _M0MPC16string6String5split(upload_payload, new _M0TPC16string10StringView(_bind, 0, _bind.length));
  while (true) {
    let record;
    _L: {
      const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$2 === undefined) {
        break;
      } else {
        const _Some = _bind$2;
        const _record = _Some;
        record = _record;
        break _L;
      }
    }
    const current = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(record, undefined));
    if (current === "") {
      continue;
    }
    const fields = _M0FP45apple7moonseo3cmd3web21split__event__payload(current, "\u001f");
    if (fields.length < 3) {
      continue;
    }
    const kind = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 0), undefined));
    const name = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 1), undefined));
    const content = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(fields, 2), undefined));
    if (kind === "parsed") {
      const facts = _M0FP25apple7moonseo12parse__facts(content);
      if (facts.length > 0) {
        const start = next_index.val;
        const end_ = (next_index.val + facts.length | 0) - 1 | 0;
        if (target_index >= start && target_index <= end_) {
          return _M0FP45apple7moonseo3cmd3web21source__origin__label("upload", name);
        }
        next_index.val = end_ + 1 | 0;
      }
    }
    continue;
  }
  const website_facts = _M0FP25apple7moonseo12parse__facts(_M0FP45apple7moonseo3cmd3web17get__input__value("websiteFacts"));
  if (website_facts.length > 0) {
    const start = next_index.val;
    const end_ = (next_index.val + website_facts.length | 0) - 1 | 0;
    const website_url = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0FP45apple7moonseo3cmd3web15get__data__attr("websiteFacts", "sourceUrl"), undefined));
    if (target_index >= start && (target_index <= end_ && _M0IP016_24default__implPB2Eq10not__equalGsE(website_url, ""))) {
      return _M0FP45apple7moonseo3cmd3web21source__origin__label("website", website_url);
    }
  }
  return _M0FP45apple7moonseo3cmd3web34evidence__selection__source__label();
}
function _M0FP45apple7moonseo3cmd3web26evidence__selection__title(source_id) {
  const normalized = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(source_id, undefined));
  const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
  return ui_lang === "zh" ? `正文证据标记 [S${_M0IPC16string6StringPB4Show10to__string(normalized)}]` : `Body evidence marker [S${_M0IPC16string6StringPB4Show10to__string(normalized)}]`;
}
function _M0FP45apple7moonseo3cmd3web22escape__html__fragment(text) {
  const _bind = "&";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "&amp;";
  const _tmp$2 = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const _bind$3 = "<";
  const _tmp$3 = new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length);
  const _bind$4 = "&lt;";
  const _tmp$4 = _M0MPC16string6String12replace__all(_tmp$2, _tmp$3, new _M0TPC16string10StringView(_bind$4, 0, _bind$4.length));
  const _bind$5 = ">";
  const _tmp$5 = new _M0TPC16string10StringView(_bind$5, 0, _bind$5.length);
  const _bind$6 = "&gt;";
  const _tmp$6 = _M0MPC16string6String12replace__all(_tmp$4, _tmp$5, new _M0TPC16string10StringView(_bind$6, 0, _bind$6.length));
  const _bind$7 = "\"";
  const _tmp$7 = new _M0TPC16string10StringView(_bind$7, 0, _bind$7.length);
  const _bind$8 = "&quot;";
  return _M0MPC16string6String12replace__all(_tmp$6, _tmp$7, new _M0TPC16string10StringView(_bind$8, 0, _bind$8.length));
}
function _M0FP45apple7moonseo3cmd3web27evidence__excerpt__segments(text) {
  const _bind = "\r";
  const _tmp = new _M0TPC16string10StringView(_bind, 0, _bind.length);
  const _bind$2 = "\n";
  const normalized = _M0MPC16string6String12replace__all(text, _tmp, new _M0TPC16string10StringView(_bind$2, 0, _bind$2.length));
  const lines = [];
  const _bind$3 = "\n";
  const _it = _M0MPC16string6String5split(normalized, new _M0TPC16string10StringView(_bind$3, 0, _bind$3.length));
  while (true) {
    let raw_line;
    _L: {
      const _bind$4 = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
      if (_bind$4 === undefined) {
        break;
      } else {
        const _Some = _bind$4;
        const _raw_line = _Some;
        raw_line = _raw_line;
        break _L;
      }
    }
    const line = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string10StringView4trim(raw_line, undefined));
    if (_M0IP016_24default__implPB2Eq10not__equalGsE(line, "")) {
      _M0MPC15array5Array4pushGsE(lines, line);
    }
    continue;
  }
  if (lines.length > 1) {
    const trimmed = [];
    const total = new _M0TPC13ref3RefGiE(0);
    const _bind$4 = lines.length;
    let _tmp$2 = 0;
    while (true) {
      const _ = _tmp$2;
      if (_ < _bind$4) {
        const line = lines[_];
        if (total.val >= 280 || trimmed.length >= 4) {
          break;
        }
        const compact = _M0FP45apple7moonseo3cmd3web26compact__evidence__excerpt(line);
        if (_M0IP016_24default__implPB2Eq10not__equalGsE(compact, "")) {
          _M0MPC15array5Array4pushGsE(trimmed, compact);
          total.val = total.val + compact.length | 0;
        }
        _tmp$2 = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return trimmed;
  }
  const compact = _M0FP45apple7moonseo3cmd3web26compact__evidence__excerpt(text);
  if (compact === "") {
    return [];
  }
  const sentences = [];
  const current = new _M0TPC13ref3RefGsE("");
  const _it$2 = _M0MPC16string6String4iter(compact);
  while (true) {
    let scalar;
    _L: {
      const _bind$4 = _M0MPB4Iter4nextGcE(_it$2);
      if (_bind$4 === -1) {
        break;
      } else {
        const _Some = _bind$4;
        const _scalar = _Some;
        scalar = _scalar;
        break _L;
      }
    }
    current.val = `${current.val}${_M0IPC14char4CharPB4Show10to__string(scalar)}`;
    if (scalar === 10 || (scalar === 12290 || (scalar === 65281 || (scalar === 65311 || (scalar === 65307 || (scalar === 46 || (scalar === 33 || (scalar === 63 || scalar === 59)))))))) {
      const sentence = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(current.val, undefined));
      if (_M0IP016_24default__implPB2Eq10not__equalGsE(sentence, "")) {
        _M0MPC15array5Array4pushGsE(sentences, sentence);
      }
      current.val = "";
    }
    continue;
  }
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(current.val, undefined)), "")) {
    _M0MPC15array5Array4pushGsE(sentences, _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(current.val, undefined)));
  }
  if (sentences.length <= 2) {
    return [compact];
  }
  const grouped = [];
  const index = new _M0TPC13ref3RefGiE(0);
  while (true) {
    if (index.val < sentences.length && grouped.length < 3) {
      const first = _M0MPC15array5Array2atGsE(sentences, index.val);
      const second = (index.val + 1 | 0) < sentences.length ? _M0MPC15array5Array2atGsE(sentences, index.val + 1 | 0) : "";
      const paragraph = second === "" ? first : `${_M0IPC16string6StringPB4Show10to__string(first)} ${_M0IPC16string6StringPB4Show10to__string(second)}`;
      _M0MPC15array5Array4pushGsE(grouped, _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(paragraph, undefined)));
      index.val = index.val + 2 | 0;
      continue;
    } else {
      break;
    }
  }
  return grouped;
}
function _M0FP45apple7moonseo3cmd3web31render__evidence__excerpt__html(text) {
  const builder = _M0MPB13StringBuilder11new_2einner(0);
  const segments = _M0FP45apple7moonseo3cmd3web27evidence__excerpt__segments(text);
  if (segments.length === 0) {
    return "";
  }
  const _bind = segments.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const segment = segments[_];
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "<p>");
      _M0IPB13StringBuilderPB6Logger13write__string(builder, _M0FP45apple7moonseo3cmd3web22escape__html__fragment(segment));
      _M0IPB13StringBuilderPB6Logger13write__string(builder, "</p>");
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPB13StringBuilder10to__string(builder);
}
function _M0FP45apple7moonseo3cmd3web27handle__evidence__selection(payload) {
  const parts = _M0FP45apple7moonseo3cmd3web21split__event__payload(payload, "\u001f");
  if (parts.length < 5) {
    return undefined;
  }
  const source_id = _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(parts, 1), undefined));
  const body = _M0FP45apple7moonseo3cmd3web28evidence__selection__excerpt(source_id, _M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(_M0MPC15array5Array2atGsE(parts, 3), undefined)));
  const excerpt_html = _M0FP45apple7moonseo3cmd3web31render__evidence__excerpt__html(body);
  if (excerpt_html === "") {
    _M0FP45apple7moonseo3cmd3web9set__text("evidenceCoverageSource", "");
    _M0FP45apple7moonseo3cmd3web9set__text("evidenceCoverageTitle", "");
    _M0FP45apple7moonseo3cmd3web9set__html("evidenceCoverageBody", "");
    _M0FP45apple7moonseo3cmd3web27hide__evidence__detail__dom("evidenceCoverageCard");
    _M0FP45apple7moonseo3cmd3web28activate__evidence__ref__dom("previewPanel", source_id);
    return undefined;
  }
  _M0FP45apple7moonseo3cmd3web9set__text("evidenceCoverageSource", _M0FP45apple7moonseo3cmd3web27evidence__selection__origin(source_id));
  _M0FP45apple7moonseo3cmd3web9set__text("evidenceCoverageTitle", _M0FP45apple7moonseo3cmd3web26evidence__selection__title(source_id));
  _M0FP45apple7moonseo3cmd3web9set__html("evidenceCoverageBody", excerpt_html);
  _M0FP45apple7moonseo3cmd3web27show__evidence__detail__dom("previewPanel", "evidenceCoverageCard");
  _M0FP45apple7moonseo3cmd3web28activate__evidence__ref__dom("previewPanel", source_id);
  _M0FP45apple7moonseo3cmd3web25show__audit__section__dom("seoRuleSection");
}
function _M0FP45apple7moonseo3cmd3web23handle__summary__button(target_id) {
  if (_M0IP016_24default__implPB2Eq10not__equalGsE(_M0IPC16string10StringViewPB4Show10to__string(_M0MPC16string6String4trim(target_id, undefined)), "")) {
    _M0FP45apple7moonseo3cmd3web27toggle__audit__section__dom(target_id);
    return;
  } else {
    return;
  }
}
(() => {
  _M0FP45apple7moonseo3cmd3web9set__html("app", _M0FP45apple7moonseo3cmd3web16app__shell__html());
  _M0FP45apple7moonseo3cmd3web19cache__render__mode("idle");
  _M0FP45apple7moonseo3cmd3web21cache__draft__payload("");
  _M0FP45apple7moonseo3cmd3web27cache__claim__review__state("", "");
  _M0FP45apple7moonseo3cmd3web26cache__claim__review__html("");
  _M0FP45apple7moonseo3cmd3web28cache__claim__review__counts(0, 0, 0, 0);
  _M0FP45apple7moonseo3cmd3web17set__input__value("claimSnapshotCache", "");
  _M0FP45apple7moonseo3cmd3web27cache__draft__audit__inputs("", 0);
  _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("clean");
  _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
  _M0FP45apple7moonseo3cmd3web32reset__persistent__brief__inputs();
  _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events("brandName", (value) => {
    _M0FP45apple7moonseo3cmd3web21persist__input__value("moonseo.brand_name", value);
  });
  _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events("websiteUrl", (value) => {
    _M0FP45apple7moonseo3cmd3web21persist__input__value("moonseo.website_url", value);
  });
  _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events("articleTitle", (value) => {
    _M0FP45apple7moonseo3cmd3web21persist__input__value("moonseo.article_title", value);
  });
  _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events("primaryKeyword", (value) => {
    _M0FP45apple7moonseo3cmd3web21persist__input__value("moonseo.primary_keyword", value);
  });
  _M0FP45apple7moonseo3cmd3web31bind__persistent__input__events("notesInput", (value) => {
    _M0FP45apple7moonseo3cmd3web21persist__input__value("moonseo.notes_input", value);
  });
  _M0FP45apple7moonseo3cmd3web20bind__click__stopper("uploadMenu");
  _M0FP45apple7moonseo3cmd3web20bind__click__stopper("briefDrawer");
  _M0FP45apple7moonseo3cmd3web20bind__click__stopper("settingsMenu");
  _M0FP45apple7moonseo3cmd3web21bind__document__click(() => {
    _M0FP45apple7moonseo3cmd3web27close__all__floating__menus();
  });
  _M0FP45apple7moonseo3cmd3web19bind__menu__trigger("uploadButton", () => {
    _M0FP45apple7moonseo3cmd3web28handle__upload__menu__toggle();
  });
  _M0FP45apple7moonseo3cmd3web19bind__menu__trigger("briefSummaryTitle", () => {
    _M0FP45apple7moonseo3cmd3web27handle__brief__menu__toggle();
  });
  _M0FP45apple7moonseo3cmd3web19bind__menu__trigger("settingsSummary", () => {
    _M0FP45apple7moonseo3cmd3web30handle__settings__menu__toggle();
  });
  _M0FP45apple7moonseo3cmd3web27bind__preview__edit__events("previewPanel", () => {
    _M0FP45apple7moonseo3cmd3web27sync__export__from__preview("previewPanel", "exportButton");
    _M0FP45apple7moonseo3cmd3web37cache__claim__snapshot__from__preview();
    if (_M0FP45apple7moonseo3cmd3web14is__page__mode("ready")) {
      _M0FP45apple7moonseo3cmd3web25cache__draft__edit__state("dirty");
      _M0FP45apple7moonseo3cmd3web26sync__audit__stale__banner();
      _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
      return;
    } else {
      return;
    }
  });
  _M0FP45apple7moonseo3cmd3web27bind__evidence__ref__events("previewPanel", (payload) => {
    _M0FP45apple7moonseo3cmd3web27handle__evidence__selection(payload);
  });
  _M0FP45apple7moonseo3cmd3web27bind__claim__review__events("auditPanel", (claim_id) => {
    _M0FP45apple7moonseo3cmd3web24handle__claim__selection(claim_id);
  }, (payload) => {
    _M0FP45apple7moonseo3cmd3web20handle__claim__apply(payload);
  }, () => {
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("loading");
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    if (!_M0FP45apple7moonseo3cmd3web43retry__failed__claim__review__from__preview()) {
      _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
      _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
      return;
    } else {
      return;
    }
  });
  _M0FP45apple7moonseo3cmd3web29bind__summary__button__events("auditPanel", (target_id) => {
    _M0FP45apple7moonseo3cmd3web23handle__summary__button(target_id);
  });
  _M0FP45apple7moonseo3cmd3web29bind__summary__button__events("scorePanel", (target_id) => {
    _M0FP45apple7moonseo3cmd3web23handle__summary__button(target_id);
  });
  _M0FP45apple7moonseo3cmd3web27bind__source__upload__input("sourceUpload", (payload) => {
    _M0FP45apple7moonseo3cmd3web31handle__source__upload__payload(payload);
  });
  _M0FP45apple7moonseo3cmd3web34bind__source__chip__remove__events("sourceList", (index_text) => {
    _M0FP45apple7moonseo3cmd3web30handle__upload__source__remove(index_text);
  });
  _M0FP45apple7moonseo3cmd3web29bind__debounced__input__value("websiteUrl", 350, (url) => {
    _M0FP45apple7moonseo3cmd3web30handle__website__source__input(url);
  });
  _M0FP45apple7moonseo3cmd3web15apply__language("en");
  _M0FP45apple7moonseo3cmd3web25expose__generate__handler(() => {
    _M0FP45apple7moonseo3cmd3web19trigger__generation();
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("langZhButton", () => {
    _M0FP45apple7moonseo3cmd3web15apply__language("zh");
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("langEnButton", () => {
    _M0FP45apple7moonseo3cmd3web15apply__language("en");
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("uploadPickerButton", () => {
    _M0FP45apple7moonseo3cmd3web14trigger__click("sourceUpload");
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("generateButton", () => {
    _M0FP45apple7moonseo3cmd3web19trigger__generation();
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("exportButton", () => {
    _M0FP45apple7moonseo3cmd3web15export__current();
  });
  _M0FP45apple7moonseo3cmd3web20add__click__listener("rerunAuditButton", () => {
    const ui_lang = _M0FP45apple7moonseo3cmd3web16get__lang__state();
    _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("loading");
    _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
    _M0FP45apple7moonseo3cmd3web32rerun__seo__audit__from__preview();
    if (!_M0FP45apple7moonseo3cmd3web35rerun__claim__review__from__preview()) {
      _M0FP45apple7moonseo3cmd3web26cache__rerun__audit__state("");
      _M0FP45apple7moonseo3cmd3web26sync__rerun__audit__button();
      _M0FP45apple7moonseo3cmd3web20set__status__success(ui_lang === "zh" ? "SEO 审计已按当前正文重新计算；这次没有触发 claim review。" : "SEO audit refreshed from the current draft; claim review did not rerun this time.");
      return;
    } else {
      return;
    }
  });
})();
