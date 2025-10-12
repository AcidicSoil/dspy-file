# Evidence Logger

## Metadata

- **Identifier**: evidence-capture
- **Categories**: Logging, Metadata Capture, Evidence Validation
- **Stage**: Capture
- **Dependencies**: []
- **Provided Artifacts**: Evidence Log Table
- **Summary**: Do capture sources for a claim to achieve a structured, verifiable evidence log.

## Inputs

- Claim text (required)
- Optional URLs (preferred from official sources)

## Canonical taxonomy (exact strings)

- Logging
- Metadata Capture
- Evidence Validation

### Stage hints (for inference)

- Capture → Initial gathering of evidence from sources
- Validate → Post-collection review and confidence scoring
- Output → Final structured delivery

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

- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
- No alteration of the original content after metadata block.

## Validation

- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts are short-listed and meaningful.
- Summary ≤120 chars; punctuation coherent.
- Body text remains unchanged.

## Output format examples

- Input: `/evidence-capture "Next.js 15 requires React 19 RC"` with official links.  
  Output: Evidence table entries with dates.

- Input: Claim about climate policy with no URLs.  
  Output: Evidence log with missing URL marked as n/a, and confidence scored based on relevance.
