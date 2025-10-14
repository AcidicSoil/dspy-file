```md
# API Usage Analysis

## Metadata

- **identifier**: {{1}}
- **category**: {{2}}
- **lifecycle_stage**: {{3}}
- **dependencies**: [{{4}}, {{5}}]
- **provided_artifacts**: 
  - Definition: {{6}}
  - Key usages: {{7}}, {{8}}
- **summary**: Do analyze how an internal API is used to achieve clear documentation and visibility into its real-world applications.

## Inputs

- Input symbol: {{9}}
- Tool commands: `rg -n {{args}} . || grep -RIn {{args}} .`

## Canonical taxonomy (exact strings)

- API Usage Analysis
- Code Inspection
- Dependency Mapping
- Documentation Generation

### Stage hints (for inference)

- analysis
- inspection
- gathering
- review
- synthesis

## Algorithm

1. Extract signals from $1  
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

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.
- All fields must be derived from content or logical inference.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- identifier: {{10}}  
- category: {{11}}  
- lifecycle_stage: {{12}}  
- dependencies: [{{13}}, {{14}}]  
- provided_artifacts: 
  - Definition: {{15}}
  - Key usages: {{16}}, {{17}}
- summary: Do analyze how an internal API is used to achieve clear documentation and visibility into its real-world applications.
```
