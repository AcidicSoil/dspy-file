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
- No external sources or URLs allowed.
- Output must strictly follow section order and formatting rules.

## Validation
- Identifier matches a normalized id pattern.  
- Categories non-empty and drawn from $5 (≤3).  
- Stage, if present, is one of the allowed stages implied by $6.  
- Dependencies, if present, are id-shaped (≤5).  
- Summary ≤120 chars; punctuation coherent.  
- Body text $1 is not altered.

## Output format examples
- Identifier: prd-generate  
- Category: Document Generation  
- Stage: execution  
- Dependency: README.md must exist  
- Artifact: prd.txt (plain text)  
- Summary: Do generate a structured PRD from README content to achieve consistent, complete documentation with defined format.  
- Metadata block:
  ```yaml
  identifier: prd-generate
  categories:
    - Document Generation
    - Content Extraction
    - Validation & Compliance
  stage: execution
  dependencies:
    - README.md exists at root
  provided_artifacts:
    - prd.txt
  summary: Do generate a structured PRD from README content to achieve consistent, complete documentation with defined format.
  ```
