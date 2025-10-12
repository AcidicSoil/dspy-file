# Generate Release Notes

## Metadata

- **Identifier**: generate-release-notes-from-commits
- **Categories**: feat, fix, perf
- **Stage**: production
- **Dependencies**: git-log, {{args}}
- **Provided Artifacts**: Highlights section, grouped changelog by type, evidence summary
- **Summary**: Generate human-readable release notes from recent commits to achieve transparency in changes.

## Inputs

- Git commit range (e.g., `main..v1.0`)
- Access to git repository and CLI tools

## Canonical taxonomy (exact strings)

- feat
- fix
- perf
- docs
- refactor
- chore

### Stage hints (for inference)

- production: one-time task executed during release cycle
- generation: output produced from input data via structured process
- analysis: involves parsing logs and categorizing changes

## Algorithm

1. Extract signals from the prompt:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.
   
2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   → Identifier: generate-release-notes-from-commits

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   → Categories: feat, fix, perf (top three most relevant in changelog)

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map categories via stage hints.
   - Omit if uncertain.
   → Stage: production (inferred from release context)

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependencies: git-log, {{args}}

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.
   → Artifacts: Highlights section, grouped changelog by type, evidence summary

7. Compose summary:
   - One sentence (≤120 chars): “Generate human-readable release notes from recent commits to achieve transparency in changes.”

8. Produce metadata in the requested format:
   - Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤7.
- All categories must be drawn from canonical taxonomy (exact strings).
- Summary must be under 120 characters and grammatically coherent.

## Validation

- Identifier matches normalized id pattern (lowercase kebab-case, starts with letter).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text remains unaltered.

## Output format examples

- Input: src/example.ts
- Expected Output:
  ## Features
  - Add SSO login flow (PR #42)
  
  ## Fixes
  - Resolve logout crash (PR #57)

---

# Release Notes

Trigger: /release-notes <git-range>

Purpose: Generate human-readable release notes from recent commits.

You are a CLI assistant focused on helping contributors with the task: Generate human‑readable release notes from recent commits.

1. Gather context by running `git log --pretty='* %s (%h) — %an' --no-merges {{args}}` for the commit log (no merges).
2. Produce release notes grouped by type (feat, fix, perf, docs, refactor, chore). Include a Highlights section and a full changelog list.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Generate human‑readable release notes from recent commits.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
src/example.ts

Expected Output:
## Features

- Add SSO login flow (PR #42)

## Fixes

- Resolve logout crash (PR #57)
