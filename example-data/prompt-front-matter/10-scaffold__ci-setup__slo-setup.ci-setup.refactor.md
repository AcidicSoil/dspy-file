# SLO Setup

Task: Given the following prompt text, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original body.

## Inputs

- Identifier (trigger): `/slo-setup`
- Purpose: Define Service Level Objectives, burn alerts, and runbooks.
- Steps:
  1. Choose SLI/metrics per user journey. Define SLO targets and error budgets.
  2. Create burn alerts (fast/slow) and link to runbooks.
  3. Add `SLO.md` with rationale and review cadence.
- Output format: SLO table and alert rules snippet.
- Examples: `/slo-setup`.
- Notes: Tie SLOs to deploy gates and incident severity.

## Canonical taxonomy (exact strings)

- slo
- alerts
- runbooks

### Stage hints (for inference)

- setup → setup phase of service configuration
- define → initial creation or definition
- create → action for establishing new components

## Algorithm

1. Extract signals from the prompt text:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map categories via stage hints.
   - Omit if uncertain.

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.

7. Compose summary:
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format:
   - Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.

## Validation

- Identifier matches a normalized id pattern (e.g., kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3 and directly tied to output format.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- {
  "identifier": "slo-setup",
  "categories": ["slo", "alerts", "runbooks"],
  "stage": "setup",
  "dependencies": [],
  "provided_artifacts": ["SLO table", "alert rules snippet"],
  "summary": "Define SLOs, alerts, and runbooks to achieve measurable service reliability."
}
