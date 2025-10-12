# ADR Drafting Assistant

Task: Given the following prompt, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the input text.

## Inputs
- Input prompt: "You are a CLI assistant focused on helping contributors with the task: Draft an Architecture Decision Record with pros/cons."
- Workflow steps: Gather context from `README.md`, draft ADR (Context, Decision, Status, Consequences), synthesize insights.
- Output requirements: Concise summary of goal; workflow triggers/failing jobs/proposed fixes; documented evidence for maintainers' trust.

## Canonical taxonomy (exact strings)
- architecture
- decision-making
- documentation

### Stage hints (for inference)
- ideation → early drafting, context gathering
- planning → structured output design
- implementation → actual code changes
- review → peer feedback or approval

## Algorithm
1. Extract signals from input:
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
- Artifacts are short (≤3) and relevant to output.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Identifier: `adr-draft`
- Categories: architecture, decision-making, documentation
- Lifecycle stage: ideation
- Dependencies: README.md
- Provided artifacts: ADR with pros/cons, evidence summary, workflow insights
- Summary: "Draft an Architecture Decision Record with pros/cons to achieve transparent decision documentation."
