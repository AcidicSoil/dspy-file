# Generate Status Docs

## Inputs
- Trigger: `/tm-docs`
- Source: tasks.json
- Output format: Markdown document for README or STATUS.md
- Required fields: done, in_progress, blocked, ready_next
- Optional: changelog (if timestamps exist)

## Canonical taxonomy (exact strings)
- documentation
- status reporting
- project tracking

### Stage hints (for inference)
- Generation → primary stage
- Composition → sub-stage
- Output → final delivery

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings: "Generate Status Docs", "Purpose", "Steps", "Output format"
   - Imperative verbs: "Parse", "Compose", "Produce", "Emit"
   - Explicit tags: `/tm-docs`, "tasks.json", "STATUS.md"
   - Dependency phrasing: "from tasks.json", "per /tm-next logic"

2. Determine the primary identifier:
   - Preferred input: `/tm-docs`
   - Normalized: `tm-docs`

3. Determine categories:
   - Explicit input: none
   - Inferred from verbs and context: documentation, status reporting, project tracking
   - Validated against taxonomy; de-duplicated → 3 entries

4. Determine lifecycle/stage (optional):
   - Prefer explicit input → not provided
   - Map via stage hints → "Generation" (primary)

5. Determine dependencies (optional):
   - "Parse tasks.json"
   - "/tm-next logic for state classification"
   - Normalized to: `tasks.json`, `/tm-next`

6. Determine provided artifacts (optional):
   - A single Markdown document (STATUS.md)
   - Status boards per status category (Ready Next, In Progress, Blocked, Done)
   - 7-day changelog if timestamps exist; otherwise, recent done items

7. Compose summary:
   - "Generate a project status document from tasks.json to report current focus, progress, and risks."

8. Produce metadata in structured format:
   - Identifier: tm-docs
   - Categories: documentation, status reporting, project tracking
   - Stage: generation
   - Dependencies: tasks.json, /tm-next
   - Artifacts: STATUS.md, status boards, changelog (if available)
   - Summary: Generate a project status document from tasks.json to report current focus, progress, and risks.

9. Reconcile if input already contains metadata:
   - No prior metadata present; all fields inferred and validated.

## Assumptions & Constraints
- Output is exactly one document: metadata block, blank line, then original body.
- All identifiers are normalized (lowercase, kebab-case).
- Categories strictly from canonical taxonomy (≤3).
- Stage is one of the allowed stages in stage hints.
- Dependencies are id-shaped and ≤5.
- Summary ≤120 characters; coherent punctuation.
- Original content ($1) remains unaltered.

## Validation
- Identifier: `tm-docs` → matches normalized pattern
- Categories: non-empty, from taxonomy, ≤3
- Stage: "generation" → valid per stage hints
- Dependencies: `tasks.json`, `/tm-next` → id-shaped, ≤5
- Artifacts: 3 listed (document, boards, changelog)
- Summary: 108 characters; grammatically sound

## Output format examples
- Identifier: tm-docs  
- Categories: documentation, status reporting, project tracking  
- Stage: generation  
- Dependencies: tasks.json, /tm-next  
- Artifacts: STATUS.md, status boards, changelog (if available)  
- Summary: Generate a project status document from tasks.json to report current focus, progress, and risks.  

---

# Generate Status Docs

Trigger: /tm-docs

Purpose: Emit a project status document from tasks.json for README or STATUS.md.

Steps:

1. Parse tasks.json; collect done, in_progress, blocked, and ready_next (per /tm-next logic).
2. Compose a concise narrative: current focus, recent wins, top risks.
3. Produce status boards for each status with id, title, and owner if present.
4. Add a 7-day changelog if timestamps exist; otherwise, summarize recent done items.

Output format:

- "# Project Status — <date>"
- Sections: Summary, Ready Next, In Progress, Blocked, Done, Changelog.

Examples:

- Input: /tm-docs
- Output: a single Markdown document suitable for commit as STATUS.md.

Notes:

- Avoid leaking secrets. Do not invent owners; omit unknown fields.
