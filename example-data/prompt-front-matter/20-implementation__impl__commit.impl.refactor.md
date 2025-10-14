# Commit Message Assistant

## Metadata

- **identifier**: commit
- **categories**: fix, feat, chore, docs, refactor
- **lifecycle_stage**: draft
- **dependencies**: git status --short, git diff --staged
- **provided_artifacts**: conventional commit message (subject + body)
- **summary**: Generate a conventional, review-ready commit message from staged changes.

## Inputs

- Requires staged changes to be present.
- Must parse staged diff for change type and scope.
- Needs access to current repository state via git commands.

## Canonical taxonomy (exact strings)

feat, fix, chore, docs, refactor

### Stage hints (for inference)

draft → generation of output based on input state  
review → post-generation feedback or approval  
finalize → final commit execution  

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
- All categories must be from the canonical taxonomy.
- Summary must be concise and coherent.

## Validation

- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: draft, review, finalize.
- Dependencies are id-shaped (e.g., git commands), ≤5 items.
- Provided artifacts are short and relevant (≤3).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

```
fix(auth): prevent session expiration loop

- guard refresh flow against repeated 401 responses
- add regression coverage for expired refresh tokens

Tests: npm test -- auth/session.test.ts
```
