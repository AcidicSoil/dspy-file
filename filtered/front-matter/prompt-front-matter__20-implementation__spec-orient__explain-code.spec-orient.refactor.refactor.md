```md
# Explain Code

## Task Overview
Given the following specification, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original content.

## Inputs
- File path: {{file_path}}
- Trigger: /explain-code
- Action: explain code
- Object: file or diff
- Output format: annotated markdown with code fences and callouts

## Canonical Taxonomy
{{taxonomy}}

### Stage Hints
{{stage_hints}}

## Algorithm Steps

1. **Extract Signals**
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. **Determine Primary Identifier**
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   → Identifier: {{identifier}}

3. **Determine Categories**
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   → Categories: {{categories}}

4. **Determine Lifecycle/Stage**
   - Prefer explicit input; otherwise map categories via stage hints.
   - Omit if uncertain.
   → Stage: {{stage}}

5. **Determine Dependencies**
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependencies: {{dependencies}}

6. **Determine Provided Artifacts**
   - Short list (≤3) of unlocked outputs.
   → Artifacts: {{artifacts}}

7. **Compose Summary**
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   → Summary: {{summary}}

8. **Produce Metadata**
   - Default to a human-readable serialization; honor any requested alternative.

9. **Reconcile if Input Already Contains Metadata**
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original content.
- Limit distinct placeholders to ≤ 7.
- All values must be valid and conform to constraints.

## Validation Rules
- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output Format Example
```json
{
  "identifier": "{{identifier}}",
  "categories": [{{categories}}],
  "stage": "{{stage}}",
  "dependencies": [],
  "provided_artifacts": [
    {{artifacts}}
  ],
  "summary": "{{summary}}"
}
```

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
