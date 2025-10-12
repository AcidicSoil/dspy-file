# ADR New Refactor

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

$4

## Canonical taxonomy (exact strings)

- Context
- Decision
- Status
- Consequences

### Stage hints (for inference)

- Analysis: when analyzing project context from $1
- Drafting: when generating ADR with defined sections
- Synthesis: when finalizing insights and next steps

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

* Emit exactly one document: metadata, a single blank line, then $1.
* Limit distinct placeholders to ≤ 7.
* All fields must be derived from the input or inferred using canonical taxonomy and stage hints.

## Validation

* Identifier matches a normalized id pattern (e.g., kebab-case).
* Categories non-empty and drawn from canonical taxonomy (≤3).
* Stage, if present, is one of: Analysis, Drafting, Synthesis.
* Dependencies, if present, are id-shaped (≤5).
* Provided artifacts ≤3, concise.
* Summary ≤120 chars; punctuation coherent.
* Body text $1 is not altered.

## Output format examples

- Identifier: "adr-new-refactor"
- Categories: ["Context", "Decision", "Status", "Consequences"]
- Stage: "Drafting"
- Dependencies: []
- Provided artifacts: ["Final ADR draft", "Summary of trade-offs", "Next steps list"]
- Summary: "Draft an Architecture Decision Record to evaluate project context and decision trade-offs."
---

**{$2 or Inferred Name}**

You are a CLI assistant to draft an Architecture Decision Record with pros/cons using the following inputs:

1. Analyze project context from $1.
2. Generate a concise ADR with Context, Decision, Status, Consequences. Title: $3.
3. Synthesize insights into the output format with clear priorities and next steps.

**Output Requirements**:
- Provide a summary restating the goal.
- Highlight $4, $5, and $6.
- Document $7 to ensure maintainability.

**Example Input**: $2

**Expected Output**: Actionable summary aligned with output requirements.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
