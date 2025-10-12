# Review Branch

## Inputs
- Trigger: `/review-branch`
- Purpose: Provide a high-level review of the current branch versus origin/main.
- Input format: None (command runs without arguments)
- Output format: Structured report with goals, scope, risky areas, test impact, and coverage gaps.

## Canonical taxonomy (exact strings)
- code-review
- analysis
- assessment

### Stage hints (for inference)
- review
- assess
- analyze

## Algorithm
1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.  

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  
   → Identifier: `review-branch`  

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).  
   → Categories: `code-review`, `analysis`, `assessment`  

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.  
   → Stage: `review`  

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  
   → Dependencies: none explicitly stated; inferred as git environment required.  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.  
   → Artifacts: structured report, goals overview, risk assessment, test coverage gaps  

7. Compose summary  
   * One sentence (≤120 chars): “Do review current branch vs origin/main to achieve a high-level assessment of changes.”  

8. Produce metadata in the requested format  
   * Default to human-readable serialization; honor any requested alternative.  

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.  

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation
- Identifier matches a normalized id pattern → ✅ `review-branch`
- Categories non-empty and drawn from canonical taxonomy (≤3) → ✅
- Stage, if present, is one of the allowed stages implied by stage hints → ✅ (`review`)
- Dependencies, if present, are id-shaped (≤5) → ✅ (none)
- Summary ≤120 chars; punctuation coherent → ✅
- Body text $1 is not altered.

## Output format examples
- Identifier: review-branch  
- Category: code-review  
- Stage: review  
- Dependencies: []  
- Artifacts: ["structured report", "goals overview", "risk assessment"]  
- Summary: "Do review current branch vs origin/main to achieve a high-level assessment of changes."

---

# Review Branch

Trigger: /review-branch

Purpose: Provide a high-level review of the current branch versus origin/main.

You are a CLI assistant focused on helping contributors with the task: Provide a high‑level review of the current branch vs origin/main.

1. Gather context by running `git diff --stat origin/main...HEAD` for the diff stats; running `git diff origin/main...HEAD | sed -n '1,200p'` for the ```diff.
2. Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Provide a high‑level review of the current branch vs origin/main.
- Organize details under clear subheadings so contributors can scan quickly.
- Call out test coverage gaps and validation steps.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
