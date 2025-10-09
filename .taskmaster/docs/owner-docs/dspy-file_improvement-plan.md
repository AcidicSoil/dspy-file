# **propose**

propose the notion of implementing a prompt style to dirs/files as a config flag.

example...

prompts directory getting refactored with the (WIP) prompt template w/ placeholder usage.

Evaluate **every** solution the user lists. For each solution `Si`, produce exactly one detailed paragraph that steelmans `Si` (4–7 sentences). After all paragraphs, write:
    - **Cross-cutting trade-offs:** 3 bullets comparing the leading contenders on `{criteria}` (default: feasibility, impact, cost, risk, time, scalability).
    - **Verdict:** “Obvious winner: `S*` — {≤20 words why}.” If two are neck-and-neck, break the tie explicitly on `{primary_tiebreaker: impact}` then `{secondary_tiebreaker: risk}`.
    Constraints: No new options; no early conclusions; equal rigor per solution; handle n>2 without summarizing away any item.

Solutions shown below in md block

---

* 1     [Directive]     You are given {chat_export_md} that shows a previously generated structured response. Derive its canonical **output template** and make it reusable.          Deliverables:     1) **Template (Markdown)** — same section order and headings as in {chat_export_md}, replace specifics with `{placeholders}` and add one-line hints under each field.     2) **Fill Guide (bullets)** — who should use it, inputs required, step-by-step fill order, length limits per field.     3) **Validation Checklist** — 5–10 yes/no items to confirm the filled output matches the template.          Constraints:     - Preserve the original intent and structure; remove fluff.     - Keep headings and bullet styles consistent.     - No example content unless labeled “Example (optional).”          Acceptance criteria:     - All fields have clear placeholders and hints.     - Checklist items are testable and map 1:1 to template sections.     - Output contains only the three deliverables

* 2     [Spec]     Goal: Turn {chat_export_md} into a **repeatable, copy-paste template** for future analyses.          Inputs:     - {chat_export_md}     - {template_name}     - {audience} (e.g., engineers, PMs)          Output (in this order):     1) **{template_name} — Canonical Template** (fenced Markdown block) with `{placeholders}` for: title, tasks, output format, open questions, etc.     2) **Field Dictionary**: table with columns = Field | Purpose | Required? | Length cap | Allowed format (text/code/list).     3) **Acceptance Tests**: list of concrete checks (e.g., “Contains ‘Tasks’ with numbered steps 1..N”).          Non-goals: changing semantics, adding new sections not present in {chat_export_md}.          Formatting rules:     - Use imperative verbs.     - Numbered lists for procedures, dashes for bullets.     - ≤ 150 words per hint section

* 3     [QA-Ready]     From {chat_export_md}, synthesize a **Template Duo**: a human-readable Markdown template and a machine-readable JSON schema for automated checks.          Produce:     A) **Markdown Template** — identical section order; replace values with `{placeholders}` and include short “What to include” under each.     B) **JSON Schema** — keys mirror sections; include type, required, min/max items, and regex for headings.     C) **Validator Steps** — instructions to verify a filled document against the schema.          Constraints:     - Do not invent new sections.     - Keep schema concise; only include constraints observable in {chat_export_md}.     - No runtime code; plain text only.          Acceptance criteria:     - Each Markdown section has a matching schema key.     - Placeholders are descriptive and unique.     - Validator steps reference schema property names exactly

* 4     [Polite]     Please convert {chat_export_md} into a reusable **output template pack**.          Include:     1) **Boilerplate Prompt** — a single prompt users can paste to generate this structure later. Use `{placeholders}` for inputs and specify the required headings and bullet styles.     2) **Template (Markdown)** — empty scaffold ready to fill.     3) **Filling Rules** — 7–10 concise rules (tone, length caps, “don’t code yet,” ordering).     4) **Review Checklist** — binary checks to ensure consistency across repeats.          Constraints: preserve original structure; tighten language; avoid jargon; keep the entire pack under {max_tokens} tokens.          Acceptance criteria: the prompt reliably elicits the same section order; placeholders cover every variable element; checklist maps to headings 1:1

---
