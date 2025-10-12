# Explain Code

Task: Given the following specification, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original content.

## Inputs

- File path: C:\Users\user\projects\prompts\temp-prompts\20-implementation\spec-orient\explain-code.spec-orient.md
- Trigger: /explain-code
- Action: explain code
- Object: file or diff
- Output format: annotated markdown with code fences and callouts

## Canonical taxonomy (exact strings)

- code explanation
- analysis
- risk assessment
- documentation
- debugging
- implementation
- review

### Stage hints (for inference)

- explain → implementation
- analyze → analysis
- highlight risks → review or risk assessment
- provide output → execution or delivery

## Algorithm

1. Extract signals from the specification:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   → Identifier: explain-code

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   → Categories: code explanation, analysis, risk assessment

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map categories via stage hints.
   - Omit if uncertain.
   → Stage: implementation

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependencies: none

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.
   → Artifacts: annotated markdown, code fences, callouts

7. Compose summary:
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   → Summary: Explain code files or diffs to achieve detailed insights into purpose, inputs, outputs, and risks.

8. Produce metadata in the requested format:
   - Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original content.
- Limit distinct placeholders to ≤ 7.
- All values must be valid and conform to constraints.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- {
  "identifier": "explain-code",
  "categories": ["code explanation", "analysis", "risk assessment"],
  "stage": "implementation",
  "dependencies": [],
  "provided_artifacts": [
    "annotated markdown",
    "code fences",
    "callouts"
  ],
  "summary": "Explain code files or diffs to achieve detailed insights into purpose, inputs, outputs, and risks"
}
