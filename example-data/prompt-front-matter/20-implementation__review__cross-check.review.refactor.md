# Conflict Resolver

Task: Given the following source text, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then source text.

## Inputs
- Source trigger path: `/cross-check`
- Input format: list of SourceIDs or URLs with short findings
- Output format:
  ```
  ### Contradictions
  - {S2 vs S5 → rationale}

  ### Prevails
  - {SourceID} because {reason}
  ```

## Canonical taxonomy (exact strings)
- conflict-resolution
- source-evaluation

### Stage hints (for inference)
- implementation
- decision-making

## Algorithm
1. Extract signals from the source text:
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
- Emit exactly one document: metadata, a single blank line, then the source text.
- Limit distinct placeholders to ≤7.
- No alteration of original body content.

## Validation
- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: implementation, decision-making.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
```yaml
identifier: cross-check
categories:
  - conflict-resolution
  - source-evaluation
stage: implementation
dependencies: []
artifacts:
  - contradiction-list
  - prevailing-source-with-rationale
summary: Compare conflicting sources to decide which prevails with rationale.
```

---

# Conflict Resolver

Trigger: /cross-check

Purpose: Compare conflicting findings and decide which source prevails with rationale.

Steps:

1. Accept a list of SourceIDs or URLs with short findings.
2. Evaluate publisher authority, recency, directness to primary data.
3. Select the prevailing source; note contradictions and rationale.

Output format:

```
### Contradictions
- {S2 vs S5 → rationale}

### Prevails
- {SourceID} because {reason}
```

Examples:

- Input: `/cross-check S2: blog vs S5: RFC`
- Output: RFC prevails due to primary standard.

Notes:

- Always explain why one source prevails.
```
