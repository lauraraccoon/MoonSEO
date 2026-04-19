///|
/// Generic DOM Bridges
extern "js" fn dom_get_value(
  id : String,
  kind : String,
  name : String,
) -> String =
  #| function(id, kind, name) {
  #|   const el = document.getElementById(id);
  #|   if (kind === "input") {
  #|     return el && "value" in el ? String(el.value || "") : "";
  #|   }
  #|   if (kind === "data") {
  #|     return el && el.dataset ? String(el.dataset[name] || "") : "";
  #|   }
  #|   if (kind === "details") {
  #|     return !!(el && el.hasAttribute("open")) ? "true" : "false";
  #|   }
  #|   return "";
  #| }

///|
extern "js" fn dom_set_value(
  id : String,
  kind : String,
  name : String,
  value : String,
) -> Unit =
  #| function(id, kind, name, value) {
  #|   const el = document.getElementById(id);
  #|   if (!el) {
  #|     return;
  #|   }
  #|   if (kind === "input") {
  #|     if ("value" in el) {
  #|       el.value = value;
  #|     }
  #|     return;
  #|   }
  #|   if (kind === "html") {
  #|     el.innerHTML = value;
  #|     return;
  #|   }
  #|   if (kind === "text") {
  #|     el.textContent = value;
  #|     return;
  #|   }
  #|   if (kind === "attr") {
  #|     el.setAttribute(name, value);
  #|     return;
  #|   }
  #|   if (kind === "data" && el.dataset) {
  #|     el.dataset[name] = value;
  #|   }
  #| }

///|
extern "js" fn dom_set_flag(id : String, kind : String, enabled : Bool) -> Unit =
  #| function(id, kind, enabled) {
  #|   const el = document.getElementById(id);
  #|   if (!el) {
  #|     return;
  #|   }
  #|   if (kind === "disabled" && "disabled" in el) {
  #|     el.disabled = enabled;
  #|     return;
  #|   }
  #|   if (kind === "details") {
  #|     if (enabled) {
  #|       el.setAttribute("open", "");
  #|     } else {
  #|       el.removeAttribute("open");
  #|     }
  #|   }
  #| }

///|
fn get_input_value(id : String) -> String {
  dom_get_value(id, "input", "")
}

///|
fn set_input_value(id : String, value : String) -> Unit {
  dom_set_value(id, "input", "", value)
}

///|
fn set_html(id : String, html : String) -> Unit {
  dom_set_value(id, "html", "", html)
}

///|
fn set_text(id : String, text : String) -> Unit {
  dom_set_value(id, "text", "", text)
}

///|
fn set_attr(id : String, name : String, value : String) -> Unit {
  dom_set_value(id, "attr", name, value)
}

///|
fn set_disabled(id : String, disabled : Bool) -> Unit {
  dom_set_flag(id, "disabled", disabled)
}

///|
fn get_data_attr(id : String, name : String) -> String {
  dom_get_value(id, "data", name)
}

///|
fn set_data_attr(id : String, name : String, value : String) -> Unit {
  dom_set_value(id, "data", name, value)
}

///|
fn is_details_open(id : String) -> Bool {
  dom_get_value(id, "details", "") == "true"
}

///|
fn open_details(id : String) -> Unit {
  dom_set_flag(id, "details", true)
}

///|
fn close_details(id : String) -> Unit {
  dom_set_flag(id, "details", false)
}

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
  #|   card.scrollIntoView({ behavior: "smooth", block: "start" });
  #| }

///|
extern "js" fn hide_evidence_detail_dom(card_id : String) -> Unit =
  #| function(cardId) {
  #|   const card = document.getElementById(cardId);
  #|   if (!(card instanceof HTMLElement)) {
  #|     return;
  #|   }
  #|   card.classList.remove("expanded");
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
  #|     const claimBlock = ref.closest(".claim-block");
  #|     if (claimBlock instanceof HTMLElement) {
  #|       claimBlock.classList.add("is-active");
  #|       claimBlock.scrollIntoView({ behavior: "smooth", block: "center" });
  #|     } else {
  #|       ref.scrollIntoView({ behavior: "smooth", block: "center" });
  #|     }
  #|   }
  #| }

///|
extern "js" fn activate_source_note_dom(
  audit_id : String,
  source_id : String,
) -> Unit =
  #| function(auditId, sourceId) {
  #|   const audit = document.getElementById(auditId);
  #|   if (!(audit instanceof HTMLElement) || !sourceId) {
  #|     return;
  #|   }
  #|   audit.querySelectorAll(".source-note.is-active").forEach((node) => node.classList.remove("is-active"));
  #|   const note = audit.querySelector(`.source-note[data-source-id="${sourceId}"]`);
  #|   if (note instanceof HTMLElement) {
  #|     note.classList.add("is-active");
  #|     const card = note.closest(".audit-item");
  #|     if (card instanceof HTMLElement) {
  #|       card.scrollIntoView({ behavior: "smooth", block: "start" });
  #|     } else {
  #|       note.scrollIntoView({ behavior: "smooth", block: "start" });
  #|     }
  #|   }
  #| }

///|
extern "js" fn organize_seo_rules_dom(audit_id : String) -> Unit =
  #| function(auditId) {
  #|   const audit = document.getElementById(auditId);
  #|   if (!(audit instanceof HTMLElement)) {
  #|     return;
  #|   }
  #|   const section = audit.querySelector("#seoRuleSection");
  #|   if (!(section instanceof HTMLElement) || section.dataset.organized === "true") {
  #|     return;
  #|   }
  #|   const body = section.querySelector(".audit-accordion-body");
  #|   const list = section.querySelector(".audit-list");
  #|   if (!(body instanceof HTMLElement) || !(list instanceof HTMLElement)) {
  #|     return;
  #|   }
  #|   const items = Array.from(list.querySelectorAll(".audit-item"));
  #|   if (items.length === 0) {
  #|     return;
  #|   }
  #|   const zh = document.getElementById("langZhButton") instanceof HTMLElement &&
  #|     document.getElementById("langZhButton").classList.contains("active");
  #|   const groups = zh
  #|     ? [
  #|         { title: "字符类规则", names: ["标题长度", "Slug 规范", "Meta 描述", "正文长度", "关键词分布"] },
  #|         { title: "结构规则", names: ["标题结构"] },
  #|         { title: "可解释性风险", names: ["表述风险"] },
  #|         { title: "证据覆盖", names: ["证据覆盖"] },
  #|       ]
  #|     : [
  #|         { title: "Text metrics", names: ["Title length", "Slug hygiene", "Meta description", "Body length", "Keyword footprint"] },
  #|         { title: "Structure", names: ["Heading structure"] },
  #|         { title: "Risk", names: ["Claim safety"] },
  #|         { title: "Evidence coverage", names: ["Evidence coverage"] },
  #|       ];
  #|   const matched = new Set();
  #|   const readTitle = (item) => {
  #|     const titleNode = item.querySelector(".audit-top strong");
  #|     return String(titleNode ? titleNode.textContent || "" : "").trim();
  #|   };
  #|   const matches = (title, names) => names.some((name) => title === name || title.includes(name));
  #|   const grouped = document.createElement("div");
  #|   grouped.className = "seo-rule-groups";
  #|   groups.forEach((group) => {
  #|     const groupItems = items.filter((item) => matches(readTitle(item), group.names));
  #|     if (groupItems.length === 0) {
  #|       return;
  #|     }
  #|     groupItems.forEach((item) => matched.add(item));
  #|     const wrapper = document.createElement("section");
  #|     wrapper.className = "seo-rule-group";
  #|     const head = document.createElement("div");
  #|     head.className = "seo-rule-group-head";
  #|     const title = document.createElement("h4");
  #|     title.textContent = group.title;
  #|     head.appendChild(title);
  #|     wrapper.appendChild(head);
  #|     const inner = document.createElement("div");
  #|     inner.className = "audit-list audit-list-compact";
  #|     groupItems.forEach((item) => inner.appendChild(item));
  #|     wrapper.appendChild(inner);
  #|     grouped.appendChild(wrapper);
  #|   });
  #|   const remainder = items.filter((item) => !matched.has(item));
  #|   if (remainder.length > 0) {
  #|     const wrapper = document.createElement("section");
  #|     wrapper.className = "seo-rule-group";
  #|     const head = document.createElement("div");
  #|     head.className = "seo-rule-group-head";
  #|     const title = document.createElement("h4");
  #|     title.textContent = zh ? "其他检查" : "Other checks";
  #|     head.appendChild(title);
  #|     wrapper.appendChild(head);
  #|     const inner = document.createElement("div");
  #|     inner.className = "audit-list audit-list-compact";
  #|     remainder.forEach((item) => inner.appendChild(item));
  #|     wrapper.appendChild(inner);
  #|     grouped.appendChild(wrapper);
  #|   }
  #|   list.replaceWith(grouped);
  #|   section.dataset.organized = "true";
  #| }

///|
extern "js" fn sync_claim_evidence_refs_dom(
  preview_id : String,
  payload : String,
  lang : String,
) -> Unit =
  #| function(previewId, payload, lang) {
  #|   const preview = document.getElementById(previewId);
  #|   if (!preview) {
  #|     return;
  #|   }
  #|   preview.querySelectorAll(".claim-inline-evidence").forEach((node) => node.remove());
  #|   if (typeof payload !== "string" || payload.trim() === "") {
  #|     return;
  #|   }
  #|   const lastBlocks = new Map();
  #|   preview.querySelectorAll(".claim-block[data-claim-id]").forEach((node) => {
  #|     if (node instanceof HTMLElement) {
  #|       lastBlocks.set(node.dataset.claimId || "", node);
  #|     }
  #|   });
  #|   const labelPrefix = lang === "zh" ? "正文证据标记" : "Body evidence marker";
  #|   const sourceHint =
  #|     lang === "zh"
  #|       ? "用于标记正文对应的来源摘录"
  #|       : "Marks the source excerpt used beside the body";
  #|   payload.split("\u001E").forEach((record) => {
  #|     const current = String(record || "").trim();
  #|     if (!current) {
  #|       return;
  #|     }
  #|     const fields = current.split("\u001F").map((field) => String(field || "").trim());
  #|     const claimId = fields[0] || "";
  #|     const sourceIds =
  #|       (fields[3] || "")
  #|         .split(",")
  #|         .map((part) => String(part || "").trim())
  #|         .filter(Boolean);
  #|     if (!claimId || sourceIds.length === 0) {
  #|       return;
  #|     }
  #|     const block = lastBlocks.get(claimId);
  #|     if (!(block instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     const shell = document.createElement("span");
  #|     shell.className = "claim-inline-evidence";
  #|     sourceIds.forEach((sourceId, index) => {
  #|       if (index > 0) {
  #|         shell.appendChild(document.createTextNode(" "));
  #|       }
  #|       const button = document.createElement("button");
  #|       button.type = "button";
  #|       button.className = "evidence-ref";
  #|       button.dataset.evidenceLabel = `${labelPrefix} [S${sourceId}]`;
  #|       button.dataset.evidenceText = "";
  #|       button.dataset.sourceId = sourceId;
  #|       button.dataset.evidenceSource = sourceHint;
  #|       button.textContent = `[S${sourceId}]`;
  #|       shell.appendChild(button);
  #|     });
  #|     block.appendChild(document.createTextNode(" "));
  #|     block.appendChild(shell);
  #|   });
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
  #|   articleClone.querySelectorAll(".editable-remove-button").forEach((node) => node.remove());
  #|   articleClone.querySelectorAll("[contenteditable]").forEach((node) => node.removeAttribute("contenteditable"));
  #|   articleClone.querySelectorAll("[spellcheck]").forEach((node) => node.removeAttribute("spellcheck"));
  #|   articleClone.querySelectorAll(".editable-field").forEach((node) => node.classList.remove("editable-field"));
  #|   articleClone.querySelectorAll(".editable-block").forEach((node) => node.classList.remove("editable-block"));
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
  #|   const order = [];
  #|   const grouped = new Map();
  #|   blocks.forEach((block) => {
  #|     if (!(block instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     const claimId = block.dataset.claimId || "";
  #|     const claimCopy = block.querySelector(".claim-copy");
  #|     const text = claimCopy instanceof HTMLElement ? (claimCopy.innerText || "").trim() : "";
  #|     if (!claimId || !text) {
  #|       return;
  #|     }
  #|     if (!grouped.has(claimId)) {
  #|       order.push(claimId);
  #|       grouped.set(claimId, []);
  #|     }
  #|     grouped.get(claimId).push(text);
  #|   });
  #|   return order.map((claimId) => {
  #|     const parts = grouped.get(claimId) || [];
  #|     const claimText = parts.join("\n\n").trim();
  #|     return claimText ? `${claimId}\u001F${claimText}` : "";
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
  #|   let editableCounter = 0;
  #|   preview.querySelectorAll(".editable-field").forEach((field) => {
  #|     if (!(field instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     if (!field.dataset.editableId) {
  #|       editableCounter += 1;
  #|       field.dataset.editableId = `editable-${editableCounter}`;
  #|     }
  #|   });
  #|   const clearActiveBlocks = () => {
  #|     preview.querySelectorAll(".editable-block.is-active-block").forEach((node) => {
  #|       node.classList.remove("is-active-block");
  #|       if (node instanceof HTMLElement) {
  #|         const button = node.querySelector(".editable-remove-button");
  #|         if (button instanceof HTMLElement) {
  #|           button.dataset.targetEditableId = "";
  #|           button.style.top = "";
  #|           button.style.right = "";
  #|         }
  #|       }
  #|     });
  #|   };
  #|   const clearActiveFields = () => {
  #|     preview.querySelectorAll(".editable-field.is-active-field").forEach((node) => {
  #|       node.classList.remove("is-active-field");
  #|     });
  #|   };
  #|   const setActiveField = (field) => {
  #|     clearActiveBlocks();
  #|     clearActiveFields();
  #|     if (!(field instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     field.classList.add("is-active-field");
  #|     const block = field.closest(".editable-block");
  #|     if (block instanceof HTMLElement) {
  #|       block.classList.add("is-active-block");
  #|       const button = block.querySelector(".editable-remove-button");
  #|       if (button instanceof HTMLElement) {
  #|         button.dataset.targetEditableId = field.dataset.editableId || "";
  #|         button.style.top = "";
  #|         button.style.right = "";
  #|       }
  #|     }
  #|   };
  #|   const removeEditableTarget = (field) => {
  #|     if (!(field instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     const block = field.closest(".editable-block");
  #|     if (!(block instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     const listItem = field.closest("li.editable-field");
  #|     const claimBlock = field.closest(".claim-block");
  #|     const tableWrap = field.closest(".article-table-wrap");
  #|     if (tableWrap instanceof HTMLElement) {
  #|       tableWrap.remove();
  #|     } else if (claimBlock instanceof HTMLElement) {
  #|       claimBlock.remove();
  #|     } else if (listItem instanceof HTMLElement) {
  #|       const list = listItem.parentElement;
  #|       listItem.remove();
  #|       if (list instanceof HTMLElement && list.querySelectorAll("li.editable-field").length === 0) {
  #|         list.remove();
  #|       }
  #|     } else {
  #|       field.remove();
  #|     }
  #|     if (block.querySelectorAll(".editable-field").length === 0) {
  #|       block.remove();
  #|       return;
  #|     }
  #|     const fallback = block.querySelector(".editable-field");
  #|     setActiveField(fallback);
  #|   };
  #|   preview.addEventListener("input", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (target instanceof HTMLElement) {
  #|       setActiveField(target);
  #|       cb();
  #|     }
  #|   });
  #|   preview.addEventListener("blur", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (target instanceof HTMLElement) {
  #|       cb();
  #|     }
  #|   }, true);
  #|   preview.addEventListener("focusin", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (!(target instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     setActiveField(target);
  #|   });
  #|   preview.addEventListener("click", (event) => {
  #|     const removeTarget = event.target instanceof Element ? event.target.closest(".editable-remove-button") : null;
  #|     if (removeTarget instanceof HTMLElement) {
  #|       const block = removeTarget.closest(".editable-block");
  #|       if (block instanceof HTMLElement) {
  #|         const targetId = removeTarget.dataset.targetEditableId || "";
  #|         let field = null;
  #|         if (targetId) {
  #|           field = block.querySelector(`.editable-field[data-editable-id="${targetId}"]`);
  #|         }
  #|         if (!(field instanceof HTMLElement)) {
  #|           field = block.querySelector(".editable-field.is-active-field");
  #|         }
  #|         if (!(field instanceof HTMLElement)) {
  #|           field = block.querySelector(".editable-field");
  #|         }
  #|         if (field instanceof HTMLElement) {
  #|           removeEditableTarget(field);
  #|           cb();
  #|           return;
  #|         }
  #|       }
  #|       return;
  #|     }
  #|     const editable = event.target instanceof Element ? event.target.closest(".editable-field") : null;
  #|     if (editable instanceof HTMLElement) {
  #|       setActiveField(editable);
  #|       return;
  #|     }
  #|     clearActiveBlocks();
  #|     clearActiveFields();
  #|   });
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
  on_retry : () -> Unit,
) -> Unit =
  #| function(auditId, onSelect, onApply, onRetry) {
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
  #|     const retryButton = target.closest(".claim-review-retry");
  #|     if (retryButton instanceof HTMLElement) {
  #|       onRetry();
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
extern "js" fn toggle_audit_section_dom(target_id : String) -> Unit =
  #| function(targetId) {
  #|   if (!targetId) {
  #|     return;
  #|   }
  #|   const target = document.getElementById(targetId);
  #|   if (!(target instanceof HTMLElement)) {
  #|     return;
  #|   }
  #|   const willExpand = !target.classList.contains("is-expanded");
  #|   document.querySelectorAll(".audit-section-shell").forEach((section) => {
  #|     if (section instanceof HTMLElement) {
  #|       section.classList.remove("is-expanded");
  #|     }
  #|   });
  #|   document.querySelectorAll(".audit-summary-button[data-audit-target]").forEach((button) => {
  #|     if (button instanceof HTMLElement) {
  #|       const active = button.getAttribute("data-audit-target") === targetId && willExpand;
  #|       button.classList.toggle("is-active", active);
  #|       button.setAttribute("aria-pressed", active ? "true" : "false");
  #|     }
  #|   });
  #|   if (willExpand) {
  #|     target.classList.add("is-expanded");
  #|     target.scrollIntoView({ behavior: "smooth", block: "start" });
  #|   }
  #| }

///|
extern "js" fn show_audit_section_dom(target_id : String) -> Unit =
  #| function(targetId) {
  #|   if (!targetId) {
  #|     return;
  #|   }
  #|   const target = document.getElementById(targetId);
  #|   if (!(target instanceof HTMLElement)) {
  #|     return;
  #|   }
  #|   document.querySelectorAll(".audit-section-shell").forEach((section) => {
  #|     if (section instanceof HTMLElement) {
  #|       section.classList.toggle("is-expanded", section === target);
  #|     }
  #|   });
  #|   document.querySelectorAll(".audit-summary-button[data-audit-target]").forEach((button) => {
  #|     if (button instanceof HTMLElement) {
  #|       const active = button.getAttribute("data-audit-target") === targetId;
  #|       button.classList.toggle("is-active", active);
  #|       button.setAttribute("aria-pressed", active ? "true" : "false");
  #|     }
  #|   });
  #|   target.scrollIntoView({ behavior: "smooth", block: "start" });
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
  #|   if (card instanceof HTMLElement) {
  #|     card.classList.remove("warn");
  #|     card.classList.add("stale");
  #|     const status = card.querySelector(".claim-status");
  #|     if (status instanceof HTMLElement) {
  #|       status.textContent = card.dataset.staleStatus || "Re-review needed";
  #|     }
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
extern "js" fn start_generation_status_sequence(
  lang : String,
  keep_current_draft : Bool,
) -> Unit =
  #| function(lang, keepCurrentDraft) {
  #|   const el = document.getElementById("statusBanner");
  #|   const cache = document.getElementById("generationStageCache");
  #|   if (!el) {
  #|     return;
  #|   }
  #|   const previous = Array.isArray(el.__moonseoStatusTimers) ? el.__moonseoStatusTimers : [];
  #|   previous.forEach((timer) => {
  #|     clearTimeout(timer);
  #|     clearInterval(timer);
  #|   });
  #|   if (Number.isInteger(el.__moonseoStage4Ticker)) {
  #|     clearInterval(el.__moonseoStage4Ticker);
  #|   }
  #|   const stepsZh = keepCurrentDraft
  #|     ? [
  #|         "正在整理当前 brief，并保留你已经生成好的正文。",
  #|         "正在向 AI 请求新版草稿；当前正文会保留，直到新结果真正返回。",
  #|         "AI 正在返回完整框架；会先对齐标题、结构和关键段落布局。",
  #|       ]
  #|     : [
  #|         "正在先搭建草稿骨架预览，方便你先看到结构。",
  #|         "正在向 AI 请求正式正文；先返回完整框架，再补齐完整内容。",
  #|         "AI 正在返回完整框架；骨架预览会继续保留在页面上。",
  #|       ];
  #|   const stepsEn = keepCurrentDraft
  #|     ? [
  #|         "Preparing the current brief while keeping your existing draft in place.",
  #|         "Requesting a refreshed AI draft; the current copy will stay visible until the new result arrives.",
  #|         "AI is returning the full outline first, including structure and key section framing.",
  #|       ]
  #|     : [
  #|         "Preparing the inputs and source material for a new draft.",
  #|         "Requesting the full AI draft. The outline usually arrives before full detail.",
  #|         "AI is returning the full outline now while the preview stays visible.",
  #|       ];
  #|   const steps = lang === "zh" ? stepsZh : stepsEn;
  #|   const stageStatesZh = [
  #|     ["进行中", "待开始", "待开始", "待开始"],
  #|     ["已完成", "进行中", "待开始", "待开始"],
  #|     ["已完成", "已完成", "进行中", "待开始"],
  #|     ["已完成", "已完成", "已完成", "进行中"],
  #|   ];
  #|   const stageStatesEn = [
  #|     ["In progress", "Queued", "Queued", "Queued"],
  #|     ["Done", "In progress", "Queued", "Queued"],
  #|     ["Done", "Done", "In progress", "Queued"],
  #|     ["Done", "Done", "Done", "In progress"],
  #|   ];
  #|   const stageClasses = [
  #|     ["is-active", "is-waiting", "is-waiting", "is-waiting"],
  #|     ["is-done", "is-active", "is-waiting", "is-waiting"],
  #|     ["is-done", "is-done", "is-active", "is-waiting"],
  #|     ["is-done", "is-done", "is-done", "is-active"],
  #|   ];
  #|   const stageTexts = lang === "zh" ? stageStatesZh : stageStatesEn;
  #|   const transitionDelays = [3800, 5200, 6500];
  #|   const stage4Tickers = lang === "zh"
  #|     ? [
  #|         "正在等待 AI 返回完整内容；当前内容会先保留，不会被清空。",
  #|         "正在补齐段落细节与表达一致性，请稍候…",
  #|         "正在完成后半段内容与收尾段落，请稍候…",
  #|       ]
  #|     : [
  #|         "Waiting for the full content pass from AI. Current content stays visible.",
  #|         "Filling in detailed section copy and consistency checks…",
  #|         "Finishing later sections and final paragraph pass…",
  #|       ];
  #|   const startStage4Ticker = () => {
  #|     if (Number.isInteger(el.__moonseoStage4Ticker)) {
  #|       clearInterval(el.__moonseoStage4Ticker);
  #|     }
  #|     let tickerIndex = 0;
  #|     el.textContent = stage4Tickers[tickerIndex];
  #|     el.__moonseoStage4Ticker = setInterval(() => {
  #|       if (el.hidden) {
  #|         return;
  #|       }
  #|       tickerIndex = (tickerIndex + 1) % stage4Tickers.length;
  #|       el.textContent = stage4Tickers[tickerIndex];
  #|     }, 3200);
  #|   };
  #|   const cachedStage = cache ? Number.parseInt(String(cache.value || "0"), 10) : NaN;
  #|   const savedStage = Number.isInteger(cachedStage)
  #|     ? cachedStage
  #|     : (Number.isInteger(el.__moonseoGenerationStage) ? el.__moonseoGenerationStage : 0);
  #|   const startStage = Math.max(0, Math.min(3, savedStage));
  #|   const applyStage = (index) => {
  #|     el.__moonseoGenerationStage = index;
  #|     if (cache) {
  #|       cache.value = String(index);
  #|     }
  #|     for (let i = 0; i < 4; i += 1) {
  #|       const card = document.getElementById(`generationStageCard${i + 1}`);
  #|       const badge = document.getElementById(`generationStageState${i + 1}`);
  #|       if (card) {
  #|         card.classList.remove("is-active", "is-done", "is-waiting");
  #|         card.classList.add(stageClasses[index][i]);
  #|       }
  #|       if (badge) {
  #|         badge.textContent = stageTexts[index][i];
  #|       }
  #|     }
  #|   };
  #|   const scheduleFrom = (index) => {
  #|     const timers = [];
  #|     for (let next = index + 1; next < 4; next += 1) {
  #|       const delay = transitionDelays.slice(index, next).reduce((sum, value) => sum + value, 0);
  #|       timers.push(setTimeout(() => {
  #|         if (!el.hidden) {
  #|           if (next === 3) {
  #|             startStage4Ticker();
  #|           } else {
  #|             el.textContent = steps[next];
  #|           }
  #|           applyStage(next);
  #|         }
  #|       }, delay));
  #|     }
  #|     el.__moonseoStatusTimers = timers;
  #|   };
  #|   el.hidden = false;
  #|   el.setAttribute("data-tone", "loading");
  #|   el.textContent = startStage === 3
  #|     ? stage4Tickers[0]
  #|     : steps[startStage];
  #|   applyStage(startStage);
  #|   if (startStage === 3) {
  #|     startStage4Ticker();
  #|   }
  #|   scheduleFrom(startStage);
  #| }

///|
extern "js" fn stop_generation_status_sequence() -> Unit =
  #| function() {
  #|   const el = document.getElementById("statusBanner");
  #|   const cache = document.getElementById("generationStageCache");
  #|   if (!el) {
  #|     return;
  #|   }
  #|   const timers = Array.isArray(el.__moonseoStatusTimers) ? el.__moonseoStatusTimers : [];
  #|   timers.forEach((timer) => {
  #|     clearTimeout(timer);
  #|     clearInterval(timer);
  #|   });
  #|   el.__moonseoStatusTimers = [];
  #|   if (Number.isInteger(el.__moonseoStage4Ticker)) {
  #|     clearInterval(el.__moonseoStage4Ticker);
  #|   }
  #|   el.__moonseoStage4Ticker = 0;
  #|   el.__moonseoGenerationStage = 0;
  #|   if (cache) {
  #|     cache.value = "0";
  #|   }
  #| }

///|
/// Browser State Bridges
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
extern "js" fn start_generation_watchdog(
  timeout_ms : Int,
  on_timeout : () -> Unit,
) -> Unit =
  #| function(timeoutMs, onTimeout) {
  #|   if (Number.isInteger(window.__moonseoGenerationWatchdog)) {
  #|     clearTimeout(window.__moonseoGenerationWatchdog);
  #|   }
  #|   window.__moonseoGenerationWatchdog = window.setTimeout(() => {
  #|     onTimeout();
  #|   }, Math.max(1000, Number(timeoutMs) || 90000));
  #| }

///|
extern "js" fn stop_generation_watchdog() -> Unit =
  #| function() {
  #|   if (Number.isInteger(window.__moonseoGenerationWatchdog)) {
  #|     clearTimeout(window.__moonseoGenerationWatchdog);
  #|   }
  #|   window.__moonseoGenerationWatchdog = 0;
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
extern "js" fn request_ai_payload(
  endpoint : String,
  prompt : String,
  on_success : (String) -> Unit,
  on_error : (String) -> Unit,
) -> Unit =
  #| async function(endpoint, prompt, onSuccess, onError) {
  #|   const timeoutMs = String(endpoint || "").includes("/api/draft") ? 150000 : 60000;
  #|   const controller = typeof AbortController !== "undefined" ? new AbortController() : null;
  #|   const timeoutToken = "__MOONSEO_LOCAL_TIMEOUT__";
  #|   let timeoutId = 0;
  #|   const timeoutPromise = new Promise((_, reject) => {
  #|     timeoutId = setTimeout(() => {
  #|       if (controller) {
  #|         controller.abort();
  #|       }
  #|       reject(new Error(timeoutToken));
  #|     }, timeoutMs);
  #|   });
  #|   try {
  #|     const response = await Promise.race([
  #|       fetch(endpoint, {
  #|         method: "POST",
  #|         headers: {
  #|           "Content-Type": "application/json",
  #|         },
  #|         body: JSON.stringify({ prompt }),
  #|         ...(controller ? { signal: controller.signal } : {}),
  #|       }),
  #|       timeoutPromise,
  #|     ]);
  #|     clearTimeout(timeoutId);
  #|     const bodyTimeoutMs = 12000;
  #|     const data = await Promise.race([
  #|       response.json(),
  #|       new Promise((_, reject) => {
  #|         setTimeout(() => {
  #|           reject(new Error("__MOONSEO_BODY_TIMEOUT__"));
  #|         }, bodyTimeoutMs);
  #|       }),
  #|     ]);
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
  #|     try {
  #|       onSuccess(payload);
  #|     } catch (error) {
  #|       onError(
  #|         error instanceof Error
  #|           ? `Client render failed after draft response: ${error.message}`
  #|           : "Client render failed after draft response.",
  #|       );
  #|     }
  #|   } catch (error) {
  #|     clearTimeout(timeoutId);
  #|     const messageText = error instanceof Error ? error.message : String(error || "");
  #|     if (
  #|       (error && typeof error === "object" && error.name === "AbortError") ||
  #|       messageText === timeoutToken
  #|     ) {
  #|       onError(
  #|         "The local request timed out while waiting for /api/draft. Please retry; this is usually upstream network latency.",
  #|       );
  #|       return;
  #|     }
  #|     if (messageText === "__MOONSEO_BODY_TIMEOUT__") {
  #|       onError(
  #|         "The draft response arrived but the browser could not finish parsing it in time. Please retry.",
  #|       );
  #|       return;
  #|     }
  #|     onError(error instanceof Error ? error.message : "Unknown request error");
  #|   }
  #| }

///|
extern "js" fn request_ai_payload_batches(
  endpoint : String,
  prompts_payload : String,
  on_success : (String) -> Unit,
  on_error : (String) -> Unit,
) -> Unit =
  #| async function(endpoint, promptsPayload, onSuccess, onError) {
  #|   const prompts = String(promptsPayload || "")
  #|     .split("\u001D")
  #|     .map((part) => String(part || "").trim())
  #|     .filter(Boolean);
  #|   if (prompts.length === 0) {
  #|     onError("No claim-review batches were prepared.");
  #|     return;
  #|   }
  #|   try {
  #|     const payloads = await Promise.all(
  #|       prompts.map(async (prompt) => {
  #|         const response = await fetch(endpoint, {
  #|           method: "POST",
  #|           headers: {
  #|             "Content-Type": "application/json",
  #|           },
  #|           body: JSON.stringify({ prompt }),
  #|         });
  #|         const data = await response.json();
  #|         if (!response.ok) {
  #|           const message =
  #|             data && typeof data.error === "string"
  #|               ? data.error
  #|               : data && data.error && data.error.message
  #|                 ? data.error.message
  #|                 : `Request failed with status ${response.status}`;
  #|           throw new Error(message);
  #|         }
  #|         const payload = String((data && data.payload) || "").trim();
  #|         if (!payload) {
  #|           throw new Error("The local draft service returned an empty payload.");
  #|         }
  #|         return payload;
  #|       }),
  #|     );
  #|     onSuccess(payloads.join("\u001E"));
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
extern "js" fn localize_remove_button_copy(lang : String) -> Unit =
  #| function(lang) {
  #|   const label = lang === "zh" ? "删除这部分" : "Remove this section";
  #|   document.querySelectorAll(".editable-remove-button").forEach((button) => {
  #|     if (!(button instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     button.textContent = "x";
  #|     button.setAttribute("aria-label", label);
  #|     button.setAttribute("title", label);
  #|   });
  #| }

///|
extern "js" fn bind_demo_preset_events(
  root_id : String,
  cb : (String) -> Unit,
) -> Unit =
  #| function(rootId, cb) {
  #|   const root = document.getElementById(rootId);
  #|   if (!root || root.dataset.demoPresetBound === "true") {
  #|     return;
  #|   }
  #|   root.dataset.demoPresetBound = "true";
  #|   root.addEventListener("click", (event) => {
  #|     const target = event.target instanceof Element ? event.target.closest("[data-demo-preset]") : null;
  #|     if (!(target instanceof HTMLElement)) {
  #|       return;
  #|     }
  #|     cb(String(target.dataset.demoPreset || ""));
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
  stop_generation_status_sequence()
  set_status_banner("statusBanner", "loading", message, false)
}

///|
fn set_status_success(message : String) -> Unit {
  stop_generation_status_sequence()
  set_status_banner("statusBanner", "success", message, false)
}

///|
fn set_status_error(message : String) -> Unit {
  stop_generation_status_sequence()
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
fn upload_remove_label(lang : String) -> String {
  if lang == "zh" {
    "移除来源"
  } else {
    "Remove source"
  }
}

///|
fn render_upload_source_chip_html(
  kind : String,
  label : String,
  name : String,
  detail : String,
  record_index : Int,
  lang : String,
) -> String {
  let builder = StringBuilder::new()
  builder.write_string(
    "<div class=\"source-chip\" data-source-kind=\"upload\" data-upload-state=\"\{escape_html_fragment(kind)}\" data-record-index=\"\{record_index}\">",
  )
  builder.write_string("<strong>")
  builder.write_string(escape_html_fragment(label))
  builder.write_string("</strong><span>")
  builder.write_string(escape_html_fragment(name))
  builder.write_string(
    "</span><button type=\"button\" class=\"source-chip-remove\" aria-label=\"",
  )
  builder.write_string(escape_html_fragment(upload_remove_label(lang)))
  builder.write_string("\" title=\"")
  builder.write_string(escape_html_fragment(upload_remove_label(lang)))
  builder.write_string("\"")
  if detail.trim().to_string() != "" {
    builder.write_string(" title=\"")
    builder.write_string(escape_html_fragment(detail))
    builder.write_string("\"")
  }
  builder.write_string(">×</button></div>")
  builder.to_string()
}

///|
fn render_website_source_chip_html(label : String, text : String) -> String {
  "<div id=\"website-source-chip\" class=\"source-chip\" data-source-kind=\"website\"><strong>\{escape_html_fragment(label)}</strong><span>\{escape_html_fragment(text)}</span></div>"
}

///|
fn render_source_list_html(
  upload_payload : String,
  website_state : String,
  website_url : String,
  website_chip_text : String,
  lang : String,
) -> String {
  let builder = StringBuilder::new()
  let mut index = 0
  for record in upload_payload.split("\u001E") {
    let current = record.trim().to_string()
    if current == "" {
      continue
    }
    let fields = []
    for field in current.split("\u001F") {
      fields.push(field.to_string())
    }
    if fields.length() < 4 {
      continue
    }
    builder.write_string(
      render_upload_source_chip_html(
        fields[0].trim().to_string(),
        fields[1].trim().to_string(),
        fields[2].trim().to_string(),
        fields[3].trim().to_string(),
        index,
        lang,
      ),
    )
    index += 1
  }
  if website_url.trim().to_string() != "" {
    builder.write_string(
      render_website_source_chip_html(
        website_chip_label(website_state, lang),
        website_chip_text,
      ),
    )
  }
  builder.to_string()
}

///|
fn render_source_list(
  upload_payload : String,
  website_state : String,
  website_url : String,
  website_chip_text : String,
) -> Unit {
  set_html(
    "sourceList",
    render_source_list_html(
      upload_payload,
      website_state,
      website_url,
      website_chip_text,
      get_lang_state(),
    ),
  )
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
  render_source_list(
    get_input_value("uploadSourceCache"),
    state,
    source_url,
    chip_text,
  )
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
  let website_state = get_data_attr("websiteFacts", "sourceState")
  let website_url = get_data_attr("websiteFacts", "sourceUrl")
    .trim()
    .to_string()
  let website_text = get_input_value("websiteFacts")
  let website_chip_text = if website_url == "" {
    ""
  } else if website_state == "error" || website_state == "loading" {
    website_url
  } else if website_url != "" {
    website_url
  } else {
    website_text
  }
  render_source_list(
    chip_parts.join("\u001E"),
    website_state,
    website_url,
    website_chip_text,
  )
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
fn refresh_website_source_in_background(raw_url : String) -> Unit {
  let url = raw_url.trim().to_string()
  if url == "" {
    return
  }
  request_website_text(
    url,
    text => {
      if get_input_value("websiteUrl").trim().to_string() != url {
        return
      }
      if text.trim().to_string() != "" {
        set_website_source_state("ready", url, text, url)
      }
    },
    _message => (),
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
fn demo_preset_button(
  preset_id : String,
  title_primary : String,
  title_secondary : String,
  detail : String,
) -> String {
  "<button type=\"button\" class=\"demo-preset-card\" data-demo-preset=\"\{preset_id}\"><strong><span class=\"demo-preset-title-main\">\{escape_html_fragment(title_primary)}</span><span class=\"demo-preset-title-sub\">\{escape_html_fragment(title_secondary)}</span></strong><span>\{escape_html_fragment(detail)}</span></button>"
}

///|
fn demo_presets_html(lang : String) -> String {
  let builder = StringBuilder::new()
  builder.write_string("<div class=\"demo-preset-group\">")
  builder.write_string("<div class=\"demo-preset-grid\">")
  if lang == "zh" {
    builder.write_string(
      demo_preset_button("snaplii", "Snaplii /", "Canada gift card app", "抓取官网内容，聚焦消费场景，生成落地页初稿。"),
    )
    builder.write_string(
      demo_preset_button("notion", "Notion /", "AI meeting notes", "采用 B2B SaaS 语气，突出效率场景与功能价值。"),
    )
    builder.write_string(
      demo_preset_button("wise", "Wise /", "cross-border payments", "强调可信表达、费用透明和关键表述审查。"),
    )
  } else {
    builder.write_string(
      demo_preset_button("snaplii", "Snaplii", "Canada gift card app", "Website ingestion, buyer intent, and SEO landing-page output."),
    )
    builder.write_string(
      demo_preset_button("notion", "Notion", "AI meeting notes", "B2B SaaS voice, workflow framing, and product positioning."),
    )
    builder.write_string(
      demo_preset_button("wise", "Wise", "cross-border payments", "Trust-sensitive copy, practical claims, and review flow."),
    )
  }
  builder.write_string("</div></div>")
  builder.to_string()
}

///|
fn idle_preview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>今天想写些什么？</h2><p>用下列案例快速开始，或直接输入你的写作需求及自定义信息。</p>\{demo_presets_html(lang)}</div>"
  } else {
    "<div class=\"draft-empty\"><p class=\"draft-empty-kicker\">MoonSEO</p><h2>What would you like to write today?</h2><p>Use the options below, or enter your brief and custom details.</p>\{demo_presets_html(lang)}</div>"
  }
}

///|
fn idle_audit_overview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>准备中</strong></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>准备中</strong></button></div>"
  } else {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Preparing</strong></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Preparing</strong></button></div>"
  }
}

///|
fn idle_audit_panel_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO 审计面板</p><h3>等待生成</h3><div class=\"audit-empty-pills\"><span>正文</span><span>事实支撑</span><span>SEO 规则</span></div></div>"
  } else {
    "<div class=\"audit-empty-state\"><p class=\"audit-empty-kicker\">MoonSEO audit rail</p><h3>Waiting for a draft</h3><div class=\"audit-empty-pills\"><span>Copy</span><span>Evidence</span><span>Rules</span></div></div>"
  }
}

///|
fn generating_audit_overview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">事实支撑</span><strong>生成中…</strong></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO 规则</span><strong>生成中…</strong></button></div>"
  } else {
    "<div class=\"audit-overview-grid\"><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">Fact grounding</span><strong>Generating…</strong></button><button type=\"button\" class=\"audit-summary-button is-empty\" disabled><span class=\"audit-summary-label\">SEO rules</span><strong>Generating…</strong></button></div>"
  }
}

///|
fn generating_audit_panel_html(lang : String) -> String {
  let _ = lang
  ""
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
fn render_generating_preview(ui_lang : String) -> Unit {
  set_html("previewPanel", generating_preview_html(ui_lang))
  set_html("scorePanel", generating_audit_overview_html(ui_lang))
  set_html("auditPanel", generating_audit_panel_html(ui_lang))
  set_export_enabled(false)
}

///|
fn generating_preview_html(lang : String) -> String {
  if lang == "zh" {
    "<div class=\"draft-generating\"><h2>MoonSEO 正在整理正文结构</h2><div class=\"draft-generating-outline\"><article id=\"generationStageCard1\" class=\"draft-generating-card is-active\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">步骤 1</span><span id=\"generationStageState1\" class=\"draft-generating-state\">进行中</span></div><h3>整理标题与开场</h3><p>先对齐首段与主线。</p></article><article id=\"generationStageCard2\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">步骤 2</span><span id=\"generationStageState2\" class=\"draft-generating-state\">待开始</span></div><h3>展开主要段落</h3><p>继续补齐核心内容。</p></article><article id=\"generationStageCard3\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">步骤 3</span><span id=\"generationStageState3\" class=\"draft-generating-state\">待开始</span></div><h3>整理结构层次</h3><p>让文章脉络更清晰。</p></article><article id=\"generationStageCard4\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">步骤 4</span><span id=\"generationStageState4\" class=\"draft-generating-state\">待开始</span></div><h3>完成内容整理</h3><p>补足后半部分内容。</p></article></div></div>"
  } else {
    "<div class=\"draft-generating\"><h2>MoonSEO is shaping the article structure</h2><div class=\"draft-generating-outline\"><article id=\"generationStageCard1\" class=\"draft-generating-card is-active\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">Step 1</span><span id=\"generationStageState1\" class=\"draft-generating-state\">In progress</span></div><h3>Align title and opening</h3><p>Set the main angle and first answer.</p></article><article id=\"generationStageCard2\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">Step 2</span><span id=\"generationStageState2\" class=\"draft-generating-state\">Queued</span></div><h3>Expand the main sections</h3><p>Fill in the core content.</p></article><article id=\"generationStageCard3\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">Step 3</span><span id=\"generationStageState3\" class=\"draft-generating-state\">Queued</span></div><h3>Organize the structure</h3><p>Keep the flow clear.</p></article><article id=\"generationStageCard4\" class=\"draft-generating-card is-waiting\"><div class=\"draft-generating-top\"><span class=\"draft-generating-label\">Step 4</span><span id=\"generationStageState4\" class=\"draft-generating-state\">Queued</span></div><h3>Finish the draft</h3><p>Complete the remaining copy.</p></article></div></div>"
  }
}

///|
fn apply_demo_preset(preset : String) -> Unit {
  let lang = get_lang_state()
  let (brand_name, website_url, article_title, primary_keyword, audience, notes) = demo_preset_values(
    preset, lang,
  )
  let website_facts = demo_preset_website_facts(preset, lang)
  set_input_value("brandName", brand_name)
  set_input_value("websiteUrl", website_url)
  set_input_value("articleTitle", article_title)
  set_input_value("primaryKeyword", primary_keyword)
  set_input_value("audience", audience)
  set_input_value("notesInput", notes)
  set_website_source_state("ready", website_url, website_facts, website_url)
  persist_input_value("moonseo.brand_name", brand_name)
  persist_input_value("moonseo.website_url", website_url)
  persist_input_value("moonseo.article_title", article_title)
  persist_input_value("moonseo.primary_keyword", primary_keyword)
  persist_input_value("moonseo.notes_input", notes)
  cache_demo_preset_state(preset, false)
  open_details("briefDrawer")
  refresh_website_source_in_background(website_url)
  set_status_success(
    if lang == "zh" {
      "已填入演示案例，并优先载入内置官网摘要。你可以直接生成，后台会继续刷新官网正文。"
    } else {
      "Loaded a demo case with a built-in website summary. You can generate immediately while MoonSEO refreshes the live website copy in the background."
    },
  )
}

///|
fn demo_preset_values(
  preset : String,
  lang : String,
) -> (String, String, String, String, String, String) {
  if preset == "snaplii" {
    (
      "Snaplii",
      "https://www.snaplii.com/",
      "Best Gift Card App in Canada",
      "gift card app in Canada",
      "Canadian consumers comparing gift card apps and rewards tools",
      if lang == "zh" {
        "请写成一篇像真实增长团队会交付的英文 SEO 落地页草稿。重点突出加拿大 gift card 使用场景、购买便利性、支付和奖励体验；避免空泛 AI 套话。"
      } else {
        "Write an English SEO landing-page draft that feels like a real growth-team deliverable. Emphasize Canadian gift card use cases, purchase convenience, payment flow, and reward experience. Avoid generic AI phrasing."
      },
    )
  } else if preset == "notion" {
    (
      "Notion",
      "https://www.notion.so/",
      "Best AI Meeting Notes App for Product Teams",
      "AI meeting notes app",
      "Product managers and startup teams evaluating AI note-taking tools",
      if lang == "zh" {
        "请写成英文 B2B SaaS 落地页，强调会议记录整理、行动项提炼和团队协作，不要写成泛泛的 AI 工具介绍。"
      } else {
        "Write an English B2B SaaS landing page focused on meeting-note capture, action-item extraction, and team collaboration. Do not drift into a generic AI-tool article."
      },
    )
  } else {
    (
      "Wise",
      "https://wise.com/",
      "Best Cross-Border Payment App for Freelancers",
      "cross-border payment app",
      "Freelancers and remote workers comparing international payment tools",
      if lang == "zh" {
        "请写成英文转化型落地页，强调跨境收款速度、费用透明度和多币种体验。保持克制、可信，不要写夸张承诺。"
      } else {
        "Write an English conversion-focused landing page that emphasizes payout speed, fee transparency, and multi-currency usability. Keep the tone credible and restrained."
      },
    )
  }
}

///|
fn demo_preset_website_facts(preset : String, lang : String) -> String {
  if preset == "snaplii" {
    if lang == "zh" {
      "1. Snaplii 的官网围绕加拿大礼品卡购物、账单支付与奖励返现体验展开。\n2. 页面强调可以在线购买礼品卡、完成日常支付，并在消费过程中积累奖励。\n3. 官网信息主要服务于寻找更方便 gift card 与支付工具的加拿大消费者。"
    } else {
      "1. Snaplii positions itself around Canadian gift card shopping, bill payment, and rewards-based spending.\n2. The website emphasizes buying gift cards online, handling everyday payments, and earning rewards through regular usage.\n3. The core audience appears to be Canadian consumers looking for a more convenient gift card and payment experience."
    }
  } else if preset == "notion" {
    if lang == "zh" {
      "1. Notion 官网将 AI 会议记录、知识整理和团队协作放在统一工作空间的叙事里。\n2. 页面强调 AI 可以帮助记录会议、整理笔记、提炼行动项，并与团队文档流程衔接。\n3. 官网语气偏向产品团队、初创团队和需要跨职能协作的知识工作者。"
    } else {
      "1. Notion frames AI meeting notes, knowledge capture, and team collaboration inside one shared workspace.\n2. The website highlights recording meetings, organizing notes, extracting action items, and connecting that work to broader team documentation.\n3. The messaging is aimed at product teams, startups, and knowledge workers managing cross-functional collaboration."
    }
  } else if lang == "zh" {
    "1. Wise 官网围绕跨境收款、国际汇款与多币种账户体验组织信息。\n2. 页面强调覆盖多个国家和货币、费用透明，以及更快更直接的跨境资金流转。\n3. 官网语气主要面向自由职业者、远程工作者和有国际收付需求的小团队。"
  } else {
    "1. Wise organizes its website around cross-border payments, international transfers, and multi-currency account usage.\n2. The messaging emphasizes broad country and currency coverage, transparent fees, and a faster, more direct international money flow.\n3. The core audience appears to be freelancers, remote workers, and small teams handling international payments."
  }
}

///|
fn current_demo_preset() -> String {
  get_input_value("demoPresetCache").trim().to_string()
}

///|
fn is_demo_preset_dirty() -> Bool {
  get_input_value("demoPresetDirtyCache").trim().to_string() == "true"
}

///|
fn cache_demo_preset_state(preset : String, dirty : Bool) -> Unit {
  set_input_value("demoPresetCache", preset)
  set_input_value("demoPresetDirtyCache", if dirty { "true" } else { "false" })
}

///|
fn mark_demo_preset_dirty() -> Unit {
  if current_demo_preset() != "" {
    cache_demo_preset_state(current_demo_preset(), true)
  }
}

///|
fn refresh_demo_preset_for_language(lang : String) -> Unit {
  let preset = current_demo_preset()
  if preset == "" || is_demo_preset_dirty() {
    return
  }
  let (brand_name, website_url, article_title, primary_keyword, audience, notes) = demo_preset_values(
    preset, lang,
  )
  set_input_value("brandName", brand_name)
  set_input_value("websiteUrl", website_url)
  set_input_value("articleTitle", article_title)
  set_input_value("primaryKeyword", primary_keyword)
  set_input_value("audience", audience)
  set_input_value("notesInput", notes)
  persist_input_value("moonseo.brand_name", brand_name)
  persist_input_value("moonseo.website_url", website_url)
  persist_input_value("moonseo.article_title", article_title)
  persist_input_value("moonseo.primary_keyword", primary_keyword)
  persist_input_value("moonseo.notes_input", notes)
}

///|
fn rerender_source_chips_for_current_language() -> Unit {
  let upload_payload = get_input_value("uploadSourceCache")
  apply_upload_source_payload(upload_payload)
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
  let claim_loading = get_input_value("claimReviewStateCache")
    .trim()
    .to_string() ==
    "loading"
  let rerun_loading = get_input_value("rerunAuditStateCache").trim().to_string() ==
    "loading"
  set_status_banner(
    "auditStaleBanner",
    "loading",
    if lang == "zh" {
      "你修改过正文，当前审计结果可能已过期。"
    } else {
      "You edited the draft, so the current audit results may be outdated."
    },
    !stale || claim_loading || rerun_loading,
  )
}

///|
fn sync_rerun_audit_button() -> Unit {
  let lang = get_lang_state()
  let stale = get_input_value("draftEditedStateCache").trim().to_string() ==
    "dirty"
  let loading = get_input_value("rerunAuditStateCache").trim().to_string() ==
    "loading"
  let claim_loading = get_input_value("claimReviewStateCache")
    .trim()
    .to_string() ==
    "loading"
  let claim_failed = get_input_value("claimReviewStateCache").trim().to_string() ==
    "failed"
  let label = if loading && lang == "zh" {
    "审计中..."
  } else if loading {
    "Reviewing..."
  } else if claim_loading && lang == "zh" {
    "审计中..."
  } else if claim_loading {
    "Reviewing..."
  } else if lang == "zh" {
    "重新审计"
  } else {
    "Re-run audit"
  }
  set_text("rerunAuditButton", label)
  set_attr("rerunAuditButton", "aria-label", label)
  set_attr("rerunAuditButton", "title", label)
  set_disabled(
    "rerunAuditButton",
    loading || claim_loading || (!stale && !claim_failed),
  )
  set_attr(
    "rerunAuditButton",
    "style",
    if stale || loading || claim_failed || claim_loading {
      ""
    } else {
      "display:none"
    },
  )
}

///|
fn current_preview_seo_report(ui_lang : String) -> @moonseo.AuditReport {
  @moonseo.audit_report_for_rendered(
    get_data_attr("exportButton", "exportTitle"),
    get_data_attr("exportButton", "exportMeta"),
    get_data_attr("exportButton", "exportSlug"),
    snapshot_export_article_html("previewPanel").trim().to_string(),
    snapshot_preview_plain_text("previewPanel").trim().to_string(),
    get_input_value("draftKeywordCache"),
    parse_cached_int("draftEvidenceCountCache"),
    ui_lang,
  )
}

///|
fn render_claim_review_with_seo(
  claim_report : @moonseo.ClaimReviewReport,
  seo_report : @moonseo.AuditReport,
  ui_lang : String,
) -> Unit {
  cache_claim_review_html(claim_report.findings_html)
  cache_claim_review_counts(
    claim_report.supported_count,
    claim_report.needs_review_count,
    claim_report.unsupported_count,
    claim_report.total_count,
  )
  set_html(
    "scorePanel",
    @moonseo.render_audit_overview(claim_report, seo_report, ui_lang),
  )
  set_html(
    "auditPanel",
    "\{claim_report.findings_html}\{@moonseo.render_seo_rule_section(seo_report, ui_lang)}",
  )
  organize_seo_rules_dom("auditPanel")
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
  organize_seo_rules_dom("auditPanel")
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
  let seo_report = current_preview_seo_report(ui_lang)
  let loading_claim_report = @moonseo.loading_claim_review_report(
    claims.length(),
    ui_lang,
  )
  cache_claim_review_state("loading", "")
  cache_claim_review_html(loading_claim_report.findings_html)
  cache_claim_review_counts(0, 0, 0, claims.length())
  cache_rerun_audit_state("loading")
  render_claim_review_with_seo(loading_claim_report, seo_report, ui_lang)
  sync_claim_evidence_refs_dom("previewPanel", "", ui_lang)
  show_audit_section_dom("seoRuleSection")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  set_status_loading(
    if ui_lang == "zh" {
      "正在按当前正文重新审阅关键表述。"
    } else {
      "Reviewing key claims against the current draft."
    },
  )
  let prompts_payload = @moonseo.build_claim_review_prompt_batches(
    get_data_attr("exportButton", "exportTitle"),
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
    claims,
    ui_lang,
    8,
  )
  request_ai_payload_batches(
    "/api/claim-review",
    prompts_payload,
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
      render_claim_review_with_seo(claim_report, seo_report, ui_lang)
      sync_claim_evidence_refs_dom("previewPanel", payload, ui_lang)
      cache_draft_edit_state("clean")
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_success(
        if ui_lang == "zh" {
          "SEO 和关键表述审计已按当前正文重新计算。"
        } else {
          "SEO and claim audits refreshed from the current draft."
        },
      )
    },
    message => {
      cache_claim_review_state("failed", message)
      cache_rerun_audit_state("")
      cache_draft_edit_state("dirty")
      render_claim_review_with_seo(
        @moonseo.failed_claim_review_report(message, claims.length(), ui_lang),
        seo_report,
        ui_lang,
      )
      sync_claim_evidence_refs_dom("previewPanel", "", ui_lang)
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_error(
        if ui_lang == "zh" {
          "SEO 审计已刷新，但 claim review 重跑失败：\{@moonseo.localized_ai_error(message, ui_lang)}"
        } else {
          "SEO audit refreshed, but claim review rerun failed: \{message}"
        },
      )
    },
  )
  true
}

///|
fn retry_failed_claim_review_from_preview() -> Bool {
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
  let seo_report = current_preview_seo_report(ui_lang)
  let loading_claim_report = @moonseo.loading_claim_review_report(
    claims.length(),
    ui_lang,
  )
  cache_claim_review_state("loading", "")
  cache_claim_review_counts(0, 0, 0, claims.length())
  cache_rerun_audit_state("loading")
  render_claim_review_with_seo(loading_claim_report, seo_report, ui_lang)
  sync_claim_evidence_refs_dom("previewPanel", "", ui_lang)
  show_audit_section_dom("seoRuleSection")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  set_status_loading(
    if ui_lang == "zh" {
      "正在重新尝试逐条事实审计。"
    } else {
      "Retrying the claim-by-claim review."
    },
  )
  let prompts_payload = @moonseo.build_claim_review_prompt_batches(
    get_data_attr("exportButton", "exportTitle"),
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    notes_raw,
    claims,
    ui_lang,
    8,
  )
  request_ai_payload_batches(
    "/api/claim-review",
    prompts_payload,
    payload => {
      let claim_report = @moonseo.claim_review_report_from_payload(
        payload, claims, source_materials_raw, ui_lang,
      )
      cache_claim_review_state("success", payload)
      cache_rerun_audit_state("")
      render_claim_review_with_seo(claim_report, seo_report, ui_lang)
      sync_claim_evidence_refs_dom("previewPanel", payload, ui_lang)
      cache_draft_edit_state("clean")
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_success(
        if ui_lang == "zh" {
          "逐条事实审计已恢复，你可以继续查看事实支撑。"
        } else {
          "Claim review is available again. You can inspect the fact grounding now."
        },
      )
    },
    message => {
      cache_claim_review_state("failed", message)
      cache_rerun_audit_state("")
      render_claim_review_with_seo(
        @moonseo.failed_claim_review_report(message, claims.length(), ui_lang),
        seo_report,
        ui_lang,
      )
      sync_claim_evidence_refs_dom("previewPanel", "", ui_lang)
      sync_audit_stale_banner()
      sync_rerun_audit_button()
      set_status_error(
        if ui_lang == "zh" {
          "逐条事实审计重试失败：\{@moonseo.localized_ai_error(message, ui_lang)}"
        } else {
          "Retrying the claim review failed: \{message}"
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
    render_generating_preview(ui_lang)
  } else {
    set_export_enabled(true)
  }
  start_generation_status_sequence(ui_lang, base_mode == "ready")
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
  stop_generation_watchdog()
  stop_generation_status_sequence()
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
    "",
    ui_lang,
  )
  if @moonseo.has_real_sources(source_materials_raw) {
    cache_claim_review_state("loading", "")
    show_audit_section_dom("seoRuleSection")
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
fn render_fallback_demo_content(reason : String) -> Unit {
  stop_generation_watchdog()
  stop_generation_status_sequence()
  let ui_lang = get_lang_state()
  let (
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    _notes_raw,
  ) = read_inputs()
  let (draft, _) = @moonseo.generate_demo_localized(
    article_title,
    brand_name,
    primary_keyword,
    audience,
    source_materials_raw,
    content_lang(),
  )
  cache_render_mode("fallback")
  cache_draft_payload("")
  let seo_report = @moonseo.audit_report_for_ui(draft, ui_lang)
  apply_rendered(
    draft,
    seo_report,
    if @moonseo.has_real_sources(source_materials_raw) {
      @moonseo.empty_claim_review_report(draft.claims.length(), ui_lang)
    } else {
      @moonseo.insufficient_claim_review_report(ui_lang)
    },
    "",
    ui_lang,
  )
  set_status_success(
    if ui_lang == "zh" {
      "AI 暂时不可用，已自动切换到 MoonBit 稳定草稿模式。你仍可继续编辑、查看 SEO 检查并导出 HTML。原始错误：\{@moonseo.localized_ai_error(reason, ui_lang)}"
    } else {
      "AI was temporarily unavailable, so MoonSEO switched to its stable MoonBit draft mode. You can still edit, inspect the SEO checks, and export HTML. Original error: \{reason}"
    },
  )
}

///|
fn current_preview_has_content() -> Bool {
  snapshot_preview_plain_text("previewPanel").trim().to_string() != ""
}

///|
fn preserve_current_draft_after_failed_regeneration(reason : String) -> Unit {
  stop_generation_watchdog()
  let ui_lang = get_lang_state()
  set_page_mode("ready")
  sync_generate_button_copy()
  set_status_error(
    if ui_lang == "zh" {
      "AI 这次没有在超时窗口内返回新草稿，所以 MoonSEO 保留了你当前的正文。你可以继续编辑或稍后重试。原始错误：\{@moonseo.localized_ai_error(reason, ui_lang)}"
    } else {
      "AI did not return a refreshed draft within the timeout window, so MoonSEO kept your current draft on screen. You can keep editing or try again later. Original error: \{reason}"
    },
  )
}

///|
fn apply_rendered(
  draft : @moonseo.Draft,
  report : @moonseo.AuditReport,
  claim_report : @moonseo.ClaimReviewReport,
  claim_payload : String,
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
  organize_seo_rules_dom("auditPanel")
  set_html("previewPanel", draft.preview_html)
  localize_remove_button_copy(ui_lang)
  sync_claim_evidence_refs_dom("previewPanel", claim_payload, ui_lang)
  cache_claim_snapshot_from_preview()
  cache_draft_edit_state("clean")
  sync_audit_stale_banner()
  sync_rerun_audit_button()
  set_data_attr("previewPanel", "selectedClaim", "")
  sync_export_from_preview("previewPanel", "exportButton")
}

///|
fn prioritized_claims_for_review(
  claims : Array[@moonseo.ClaimAnchor],
) -> Array[@moonseo.ClaimAnchor] {
  let limited = []
  let max_claims = 6
  let mut index = 0
  while index < claims.length() && limited.length() < max_claims {
    limited.push(claims[index])
    index = index + 1
  }
  limited
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
  let review_claims = prioritized_claims_for_review(draft.claims)
  let prompts_payload = @moonseo.build_claim_review_prompt_batches(
    draft.title,
    brand_name,
    primary_keyword,
    audience,
    facts_raw,
    notes_raw,
    review_claims,
    ui_lang,
    3,
  )
  set_status_loading(
    if ui_lang == "zh" {
      "正文已生成。事实支撑审查正在后台并行运行，优先返回最关键表述的结果。"
    } else {
      "The draft is ready. Fact grounding is now running in the background in parallel, with the highest-priority claims reviewed first."
    },
  )
  request_ai_payload_batches(
    "/api/claim-review",
    prompts_payload,
    payload => {
      cache_claim_review_state("success", payload)
      apply_rendered(
        draft,
        seo_report,
        @moonseo.claim_review_report_from_payload(
          payload, review_claims, facts_raw, ui_lang,
        ),
        payload,
        ui_lang,
      )
      set_status_success(
        if ui_lang == "zh" {
          "事实支撑审计已更新。当前优先展示最关键表述的审阅结果，以保证速度和稳定性。"
        } else {
          "The fact-grounding audit is ready. It currently prioritizes the most important claims first for speed and reliability."
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
          review_claims.length(),
          ui_lang,
        ),
        "",
        ui_lang,
      )
      set_status_error(
        if ui_lang == "zh" {
          "草稿已生成，但逐条关键表述审阅暂时失败：\{@moonseo.localized_ai_error(message, ui_lang)}"
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
    "",
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
        "官网正文仍在后台抓取，MoonSEO 先用当前已准备好的材料生成草稿。"
      } else {
        "Website copy is still being fetched in the background, so MoonSEO will draft with the material already available."
      },
    )
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
  start_generation_watchdog(170000, () => {
    if is_page_mode("generating") {
      let had_preview = current_preview_has_content()
      if previous_mode == "ready" && had_preview {
        preserve_current_draft_after_failed_regeneration(
          "Generation watchdog timed out before the client finished applying the draft response.",
        )
      } else {
        render_fallback_demo_content(
          "Generation watchdog timed out before the client finished applying the draft response.",
        )
        restore_generate_button()
      }
    }
  })
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
      let had_preview = current_preview_has_content()
      if previous_mode == "ready" && had_preview {
        preserve_current_draft_after_failed_regeneration(message)
      } else {
        render_fallback_demo_content(message)
        restore_generate_button()
      }
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
  set_text("langZhButton", "中文")
  set_text("langEnButton", "EN")
  set_attr(
    "langZhButton",
    "class",
    if lang == "zh" { "lang-text active" } else { "lang-text" },
  )
  set_attr(
    "langEnButton",
    "class",
    if lang == "en" { "lang-text active" } else { "lang-text" },
  )
  set_attr("langZhButton", "aria-pressed", if lang == "zh" { "true" } else { "false" })
  set_attr("langEnButton", "aria-pressed", if lang == "en" { "true" } else { "false" })
  set_attr(
    "brandName",
    "placeholder",
    if lang == "zh" {
      "例如 Snaplii"
    } else {
      "For example: Snaplii"
    },
  )
  set_attr(
    "websiteUrl",
    "placeholder",
    if lang == "zh" {
      "https://"
    } else {
      "https://"
    },
  )
  set_attr(
    "articleTitle",
    "placeholder",
    if lang == "zh" {
      "例如 Best Gift Card App in Canada"
    } else {
      "For example: Best Gift Card App in Canada"
    },
  )
  set_attr(
    "primaryKeyword",
    "placeholder",
    if lang == "zh" {
      "例如 gift card app in Canada"
    } else {
      "For example: gift card app in Canada"
    },
  )
  set_attr(
    "notesInput",
    "placeholder",
    if lang == "zh" {
      "说明这篇文章要强调什么"
    } else {
      "Add a short note on what this draft should emphasize"
    },
  )
  refresh_demo_preset_for_language(lang)
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
      "支持 TXT、MD、PDF、DOC、DOCX"
    } else {
      "Supports TXT, MD, PDF, DOC, DOCX"
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
  localize_remove_button_copy(lang)
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
  builder.write_string(
    "<textarea id=\"generationStageCache\" hidden></textarea>",
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
  builder.write_string("<textarea id=\"demoPresetCache\" hidden></textarea>")
  builder.write_string(
    "<textarea id=\"demoPresetDirtyCache\" hidden></textarea>",
  )
  builder.write_string("<div id=\"sourceList\" class=\"source-list\"></div>")
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
    "<div class=\"audit-actions\"><div class=\"audit-toolbar\"><div class=\"audit-toolbar-actions\">",
  )
  builder.write_string(
    "<button id=\"exportButton\" type=\"button\">Export HTML</button>",
  )
  builder.write_string(
    "<button id=\"rerunAuditButton\" type=\"button\" class=\"secondary\" style=\"display:none\">Re-run audit</button>",
  )
  builder.write_string("</div>")
  builder.write_string(
    "<div class=\"lang-switch topbar-lang-switch\" aria-label=\"language switch\">",
  )
  builder.write_string(
    "<button id=\"langZhButton\" type=\"button\" data-lang-switch=\"zh\" class=\"lang-text\">中文</button>",
  )
  builder.write_string("<span class=\"lang-switch-separator\" aria-hidden=\"true\">/</span>")
  builder.write_string(
    "<button id=\"langEnButton\" type=\"button\" data-lang-switch=\"en\" class=\"lang-text active\">EN</button>",
  )
  builder.write_string("</div></div></div>")
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
  cache_demo_preset_state("", false)
  reset_persistent_brief_inputs()
  bind_persistent_input_events("brandName", value => {
    persist_input_value("moonseo.brand_name", value)
    mark_demo_preset_dirty()
  })
  bind_persistent_input_events("websiteUrl", value => {
    persist_input_value("moonseo.website_url", value)
    mark_demo_preset_dirty()
  })
  bind_persistent_input_events("articleTitle", value => {
    persist_input_value("moonseo.article_title", value)
    mark_demo_preset_dirty()
  })
  bind_persistent_input_events("primaryKeyword", value => {
    persist_input_value("moonseo.primary_keyword", value)
    mark_demo_preset_dirty()
  })
  bind_persistent_input_events("notesInput", value => {
    persist_input_value("moonseo.notes_input", value)
    mark_demo_preset_dirty()
  })
  bind_click_stopper("uploadMenu")
  bind_click_stopper("briefDrawer")
  bind_document_click(() => close_all_floating_menus())
  bind_menu_trigger("uploadButton", () => handle_upload_menu_toggle())
  bind_menu_trigger("briefSummaryTitle", () => handle_brief_menu_toggle())
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
  bind_demo_preset_events("previewPanel", preset => apply_demo_preset(preset))
  bind_claim_review_events(
    "auditPanel",
    claim_id => handle_claim_selection(claim_id),
    payload => handle_claim_apply(payload),
    () => {
      cache_rerun_audit_state("loading")
      sync_rerun_audit_button()
      if !retry_failed_claim_review_from_preview() {
        cache_rerun_audit_state("")
        sync_rerun_audit_button()
      }
    },
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
    let ui_lang = get_lang_state()
    cache_rerun_audit_state("loading")
    sync_rerun_audit_button()
    rerun_seo_audit_from_preview()
    if !rerun_claim_review_from_preview() {
      cache_rerun_audit_state("")
      sync_rerun_audit_button()
      set_status_success(
        if ui_lang == "zh" {
          "SEO 审计已按当前正文重新计算；这次没有触发 claim review。"
        } else {
          "SEO audit refreshed from the current draft; claim review did not rerun this time."
        },
      )
    }
  })
}
