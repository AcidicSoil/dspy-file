# Compare Outputs

Task: Given the following prompt content, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the input text.

## Inputs

- Trigger path: `/compare-outputs`
- Purpose: Evaluate multiple models or tools on identical prompts to summarize best output.
- Steps:
  1. Define evaluation prompts and expected properties.
  2. Record outputs from each model/tool with metadata.
  3. Score using a rubric (correctness, compile/run success, edits required).
  4. Recommend a winner and suggested settings.
- Output format: Matrix comparison and one-paragraph decision.

## Canonical taxonomy (exact strings)
evaluation, analysis, recommendation

### Stage hints (for inference)
evaluation → analysis → recommendation

## Algorithm

1. Extract signals from the input:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.
   
2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   → Identifier: `compare-outputs`

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   → Categories: evaluation, analysis, recommendation

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map via stage hints.
   - Omit if uncertain.
   → Stage: analysis

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependencies: none

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.
   → Artifacts: matrix comparison, one-paragraph decision

7. Compose summary:
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   → Summary: "Evaluate multiple models on a prompt to recommend the best output with justification."

8. Produce metadata in the requested format:
   - Default to human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
  
## Validation
- Identifier matches normalized id pattern (kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Metadata:
  - identifier: compare-outputs
  - categories: evaluation, analysis, recommendation
  - stage: analysis
  - dependencies: []
  - artifacts: ["matrix comparison", "one-paragraph decision"]
  - summary: "Evaluate multiple models on a prompt to recommend the best output with justification"

# Compare Outputs

Trigger: /compare-outputs

Purpose: Run multiple models or tools on the same prompt and summarize best output.

## Steps

1. Define evaluation prompts and expected properties.
2. Record outputs from each model/tool with metadata.
3. Score using a rubric: correctness, compile/run success, edits required.
4. Recommend a winner and suggested settings.

## Output format

- Matrix comparison and a one-paragraph decision.
