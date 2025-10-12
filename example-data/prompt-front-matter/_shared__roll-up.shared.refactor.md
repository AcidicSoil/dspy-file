# Research Roll-up Summary

Task: Given the following prompt, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original body.

## Inputs
- Trigger phrase: `/roll-up`
- Purpose: Summarize per-item statuses, enabled decisions, unresolved risks, and count sources by domain type.
- Steps:
  1. Aggregate Conversation State Updates from prior items.
  2. Produce per-item status lines and decisions.
  3. Tally sources by domain type: gov, org, docs, blog, news, academic.
- Output format:
  ```
  ## Roll-up Summary
  - Item {n}: {status} — decision enabled: {…}; risks: {…}
  - Sources by domain type: {gov:X, org:Y, docs:Z, blog:A, news:B, academic:C}
  ```
- Examples:
  - Input: `/roll-up from items 1–3`
  - Output: Summary block as above.
- Notes:
  - Use counts derived from the Evidence Logs.

## Canonical taxonomy (exact strings)
gov, org, docs, blog, news, academic

### Stage hints (for inference)
processing → aggregation and summarization phase  
generation → output creation stage  

## Algorithm
1. Extract signals from input text:
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   * Prefer explicit input; otherwise infer from main action + object.
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   * De-duplicate.

3. Determine categories:
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional):
   * Prefer explicit input; otherwise map categories via stage hints.
   * Omit if uncertain.

5. Determine dependencies (optional):
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

6. Determine provided artifacts (optional):
   * Short list (≤3) of unlocked outputs.

7. Compose summary:
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format:
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   * Merge: explicit inputs > existing > inferred.
   * Validate lists; move unknowns to an extension field if needed.
   * Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤ 7.

## Validation
- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints (processing or generation).
- Dependencies, if present, are id-shaped (e.g., prior-items, evidence-logs) and ≤5.
- Artifacts, if present, are short lists (≤3) of output types.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Identifier: roll-up  
- Categories: gov, org, docs, blog, news, academic  
- Stage: processing  
- Dependencies: prior-items, evidence-logs  
- Artifacts: roll-up-summary  
- Summary: Summarize per-item statuses, enabled decisions, unresolved risks, and count sources by domain type.
