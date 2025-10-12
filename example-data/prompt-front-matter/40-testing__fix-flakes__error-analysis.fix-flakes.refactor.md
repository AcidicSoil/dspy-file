# Error Analysis

## Metadata

- identifier: error-analysis
- categories:
  - analysis
  - debugging
  - diagnostic
- stage: diagnostic
- dependencies: []
- provided_artifacts:
  - table: error → likely causes → next checks → candidate fix
- summary: Analyze error logs to identify root causes and propose fixes.

## Inputs

- trigger: /error-analysis
- purpose: Analyze error logs and enumerate likely root causes with fixes.
- steps:
  1. Collect last test logs or application stack traces if present.
  2. Cluster errors by symptom. For each cluster list 2–3 plausible causes.
  3. Propose instrumentation or inputs to disambiguate.
  4. Provide minimal patch suggestions and validation steps.
- output_format:
  - Table: error → likely causes → next checks → candidate fix
- examples:
  - "TypeError: x is not a function" → wrong import, circular dep, stale build

## Canonical taxonomy (exact strings)

- analysis
- debugging
- diagnostic

### Stage hints (for inference)

- diagnostic: tasks involving root cause identification and troubleshooting
- analysis: focused on data interpretation
- debugging: involves patching or fixing issues

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs $5.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via $6.  
   * Omit if uncertain.

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts are short and relevant.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- identifier: error-analysis
- categories:
  - analysis
  - debugging
  - diagnostic
- stage: diagnostic
- dependencies: []
- provided_artifacts:
  - table: error → likely causes → next checks → candidate fix
- summary: Analyze error logs to identify root causes and propose fixes.

# Error Analysis

Trigger: /error-analysis

Purpose: Analyze error logs and enumerate likely root causes with fixes.

## Steps

1. Collect last test logs or application stack traces if present.
2. Cluster errors by symptom. For each cluster list 2–3 plausible causes.
3. Propose instrumentation or inputs to disambiguate.
4. Provide minimal patch suggestions and validation steps.

## Output format

- Table: error → likely causes → next checks → candidate fix.

## Examples

- "TypeError: x is not a function" → wrong import, circular dep, stale build.
