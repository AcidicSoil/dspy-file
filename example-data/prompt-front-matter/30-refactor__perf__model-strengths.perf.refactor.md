# Model Strengths

Task: Given a task description, classify it into one of six types (UI, API, data, testing, docs, refactor), map historical model performance, and recommend routing rules with appropriate temperatures.

## Inputs

- Task type to classify
- Historical success data per model per task type (optional)

## Canonical taxonomy (exact strings)

- UI
- API
- data
- testing
- docs
- refactor

### Stage hints (for inference)

- classification → infer category
- mapping → analyze performance
- recommendation → output routing rules and temperatures

## Algorithm

1. Extract signals from input text  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
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

- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
- All categories must be from the canonical taxonomy.
- Stage must map directly via hints or be omitted.

## Validation

- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical list (≤3).
- Stage, if present, is one of: classification, mapping, recommendation.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3; must be explicit or inferred from output format.
- Summary ≤120 chars; punctuation coherent.
- Original body text is not altered.

## Output format examples

- Identifier: model-strengths  
- Categories: UI, API, data, testing, docs, refactor  
- Stage: recommendation  
- Dependencies: none  
- Artifacts: routing guide with examples  
- Summary: Classify task type and recommend model routing based on historical performance.  

---

# Model Strengths

Trigger: /model-strengths

Purpose: Choose model per task type.

## Steps

1. Classify task: UI, API, data, testing, docs, refactor.
2. Map historical success by model.
3. Recommend routing rules and temperatures.

## Output format

- Routing guide with examples.
