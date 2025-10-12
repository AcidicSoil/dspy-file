# Switch Model

Task: Given the following prompt, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- Identifier: switch-model
- Category: model selection
- Category: evaluation
- Category: recommendation
- Lifecycle stage: evaluate
- Dependencies: none
- Provided artifacts: table of task → model → settings → win reason
- Summary: Do evaluate AI backend performance to achieve optimal model selection per task.

## Canonical taxonomy (exact strings)

- model selection
- evaluation
- recommendation

### Stage hints (for inference)

- define task type → input/definition
- select candidate models → selection
- run tests and measure → evaluation
- recommend model → decision/recommendation

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

* Emit exactly one document: metadata, a single blank line, then $1.
* Limit distinct placeholders to ≤ 7.

## Validation

* Identifier matches a normalized id pattern.
* Categories non-empty and drawn from $5 (≤3).
* Stage, if present, is one of the allowed stages implied by $6.
* Dependencies, if present, are id-shaped (≤5).
* Artifacts, if present, are short (≤3) and relevant.
* Summary ≤120 chars; punctuation coherent.
* Body text $1 is not altered.

## Output format examples

- Identifier: switch-model  
- Categories: model selection, evaluation, recommendation  
- Lifecycle stage: evaluate  
- Dependencies: none  
- Provided artifacts: table of task → model → settings → win reason  
- Summary: Do evaluate AI backend performance to achieve optimal model selection per task  

---

# Switch Model

Trigger: /switch-model

Purpose: Decide when to try a different AI backend and how to compare.

## Steps

1. Define task type: frontend codegen, backend reasoning, test writing, refactor.
2. Select candidate models and temperature/tooling options.
3. Run a fixed input suite and measure latency, compile success, and edits needed.
4. Recommend a model per task with rationale.

## Output format

- Table: task → model → settings → win reason.
