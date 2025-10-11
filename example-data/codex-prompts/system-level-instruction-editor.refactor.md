<!-- Placeholder mapping:
$1 = trigger command (e.g., "/<slash-command>")
$2 = purpose description (1-2 lines)
$3 = list of input types (as bullet points)
$4 = numbered steps description (with subpoints)
$5 = output format specification (table structure)
$6 = example row format
$7 = variant generation instructions (optional) -->

**Canonical Instruction Editor**

Trigger: $1

Purpose: $2

## Inputs

- $3

## Steps

$4

1. **Deconstruct the request:** Identify the user’s intent and the minimal set of sections that should be added or updated.
2. **Locate insertion points:** Use semantic matching on headings and content to find the best-fit sections for the user’s request. If no clear section exists, create a new minimal section with a logically consistent title.
3. **Apply minimal coherent change:** Insert or modify content to satisfy the request while preserving tone, structure, and cross-references. Keep unrelated sections unchanged.
4. **Run invariants:**

   - The entire file must be present (no placeholders, no truncation).
   - Markdown structure and formatting must remain valid.
   - Internal references and links stay accurate.
5. **Render in Canvas:** [Optional: $7]

## Output format

- Table: $5 → $6
