```md
# PRD Generator

## Inputs
- Source repository README (`README.md`) at root
- Visible link texts (only titles/texts, no external browsing)
- Example PRD structure and tone for formatting guidance
- Explicit trigger: `/prd-generate`

## Canonical taxonomy (exact strings)
- Document Generation
- Content Extraction
- Validation & Compliance

### Stage hints (for inference)
- Document Generation → execution
- Content Extraction → input-processing
- Validation & Compliance → output-validation

## Algorithm
1. Extract signals from {{input_source}}
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs {{taxonomy_list}}.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via {{stage_hint_map}}.  
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
- Emit exactly one document: metadata, a single blank line, then {{input_source}}.
- Limit distinct placeholders to ≤ 7.
- No external sources or URLs allowed.
- Output must strictly follow section order and formatting rules.

## Validation
- Identifier matches a normalized id pattern.  
- Categories non-empty and drawn from {{taxonomy_list}} (≤3).  
- Stage, if present, is one of the allowed stages implied by {{stage_hint_map}}.  
- Dependencies, if present, are id-shaped (≤5).  
- Summary ≤120 chars; punctuation coherent.  
- Body text {{input_source}} is not altered.

## Output format examples
- Identifier: {{identifier}}
- Category: {{category}}
- Stage: {{stage}}
- Dependency: {{dependency}}
- Artifact: {{artifact}}
- Summary: {{summary}}
- Metadata block:
  ```yaml
  identifier: {{identifier}}
  categories:
    - {{category_1}}
    - {{category_2}}
    - {{category_3}}
  stage: {{stage}}
  dependencies:
    - {{dependency_1}}
    - {{dependency_2}}
    - {{dependency_3}}
  provided_artifacts:
    - {{artifact_1}}
    - {{artifact_2}}
    - {{artifact_3}}
  summary: {{summary}}
  ```
```
