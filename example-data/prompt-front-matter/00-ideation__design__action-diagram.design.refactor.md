# Action Diagram Metadata

## Inputs
- Source file path: C:\Users\user\projects\prompts\temp-prompts\00-ideation\design\action-diagram.design.md
- Maximum placeholders allowed: 7

## Canonical taxonomy (exact strings)
- devops
- pipeline
- workflow

### Stage hints (for inference)
- build → development stage
- deploy → production stage
- push → trigger stage

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
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: build  
- Categories: devops, pipeline, workflow  
- Lifecycle stage: none  
- Dependencies: push  
- Provided artifacts: deployment artifact  
- Summary: Do build to achieve deployment after push

## Metadata
- identifier: build
- categories: ["devops", "pipeline", "workflow"]
- lifecycle_stage: null
- dependencies: ["push"]
- provided_artifacts: ["deployment artifact"]
- summary: Do build to achieve deployment after push

## Nodes
- build
- deploy

## Edges
- push -> build
- build -> deploy
