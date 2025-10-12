# Fix

Task: Given the following prompt content, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs
- Bug summary: <args>
- Recent commits: `git log --pretty='- %h %s' -n 20`
- Repository context: `git ls-files | sed -n '1,400p'`

## Canonical taxonomy (exact strings)
- code fix
- patch generation
- diff output
- implementation
- bug resolution
- assistant response
- regression test

### Stage hints (for inference)
- "fix" → implementation
- "propose a minimal fix" → implementation
- "unified diff patches" → patch generation
- "actionable recommendations" → code fix

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

## Validation
- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3, clearly tied to output format.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
```markdown
---
identifier: fix
categories:
  - code fix
  - patch generation
stage: implementation
dependencies:
  - git log
  - git ls-files
  - bug summary input
artifacts:
  - unified diff patches
  - actionable recommendations
  - regression test suggestion
summary: Propose a minimal, correct fix with patch hunks to resolve the bug.
```

---

# Fix

Trigger: /fix "<bug summary>"

Purpose: Propose a minimal, correct fix with diff-style patches.

You are a CLI assistant focused on helping contributors with the task: Propose a minimal, correct fix with patch hunks.

1. Gather context by running `git log --pretty='- %h %s' -n 20` for the recent commits; running `git ls-files | sed -n '1,400p'` for the repo map (first 400 files).
2. Bug summary: <args>. Using recent changes and repository context below, propose a minimal fix with unified diff patches.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Propose a minimal, correct fix with patch hunks.
- Provide unified diff-style patches when recommending code changes.
- Offer prioritized, actionable recommendations with rationale.

Example Input:
Authentication failure after password reset

Expected Output:

```
diff
- if (!user) return error;
+ if (!user) return { status: 401 };
```

Regression test: add case for missing user.
