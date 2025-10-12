# Verify CHANGELOG Completeness

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- Trigger: $2  
- Purpose: $3  
- Steps: $4  
- Output format: $5  
- Examples: $6  
- Notes: $7  

## Canonical taxonomy (exact strings)
- verification
- compliance
- change validation
- formatting
- static analysis

### Stage hints (for inference)
- validation
- pre-release check
- policy enforcement

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
- All content in $1 remains unchanged after the metadata block.

## Validation
- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: validation, pre-release check, policy enforcement.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: `changelog-verify`  
- Categories: ["verification", "compliance"]  
- Stage: "validation"  
- Dependencies: []  
- Artifacts: ["diagnostic report", "suggested patch", "unified diff"]  
- Summary: "Verify CHANGELOG completeness and structure to ensure compliance with six-section policy and formatting rules."
