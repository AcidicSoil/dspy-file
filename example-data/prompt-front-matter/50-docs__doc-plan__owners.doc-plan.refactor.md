# Owners

## Inputs
- Path to analyze (e.g., `src/components/Button.tsx`)
- Access to `.github/CODEOWNERS` file
- Git repository with recent commit logs (`git log --pretty='- %an %ae: %s'`)

## Canonical taxonomy (exact strings)
- CLI
- ownership
- review

### Stage hints (for inference)
- discovery
- analysis
- suggestion

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
- Limit distinct placeholders to ≤7.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: owners  
- Categories: CLI, ownership, review  
- Stage: discovery  
- Dependencies: CODEOWNERS file, git log access  
- Artifacts: @frontend-team (CODEOWNERS), @jane (last 5 commits)  
- Summary: Suggest owners/reviewers for a path using CODEOWNERS and commit history.

---

Trigger: /owners <path>

Purpose: Suggest likely owners or reviewers for the specified path.

You are a CLI assistant focused on helping contributors with the task: Suggest likely owners/reviewers for a path.

1. Gather context by inspecting `.github/CODEOWNERS` for the codeowners (if present); running `git log --pretty='- %an %ae: %s' -- {{args}} | sed -n '1,50p'` for the recent authors for the path.
2. Based on CODEOWNERS and git history, suggest owners.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Suggest likely owners/reviewers for a path.
- Reference evidence from CODEOWNERS or git history for each owner suggestion.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
src/components/Button.tsx

Expected Output:

- Likely reviewers: @frontend-team (CODEOWNERS), @jane (last 5 commits).
