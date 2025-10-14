# Review

## Metadata

- **Identifier**: review-code
- **Categories**: 
  - code-review
  - quality-assurance
  - security
  - readability
- **Lifecycle Stage**: analysis
- **Dependencies**: 
  - rg
  - grep
- **Provided Artifacts**: 
  - summary
  - patches
  - insights
- **Summary**: Review code matching a pattern to deliver actionable feedback on correctness, complexity, readability, security, and performance.

## Inputs

- `pattern`: A filename or regex pattern to search for in the codebase.
- `context`: Output from `rg` or `grep` to provide context for review.

## Canonical taxonomy (exact strings)

- code-review
- quality-assurance
- security
- readability
- performance
- testing
- deployment

### Stage hints (for inference)

- analysis → code inspection, review, feedback generation
- development → writing new code or modifying existing
- maintenance → fixing bugs, refactoring
- security → vulnerability scanning, secure coding practices
- deployment → releasing to production

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
- All categories must be from the canonical taxonomy list.
- Summary must not exceed 120 characters and use coherent punctuation.

## Validation

- Identifier matches a normalized id pattern (lowercase, kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Identifier: code-review
- Categories: ["code-review", "readability"]
- Lifecycle Stage: analysis
- Dependencies: ["rg", "grep"]
- Provided Artifacts: ["summary", "patches"]
- Summary: "Review code to ensure correctness and readability."

---

# Review

Trigger: /review <pattern>

Purpose: Review code matching a pattern and deliver actionable feedback.

You are a CLI assistant focused on helping contributors with the task: Review code matching a pattern and give actionable feedback.

1. Gather context by running `rg -n {{args}} . || grep -RIn {{args}} .` for the search results for {{args}} (filename or regex).
2. Perform a thorough code review. Focus on correctness, complexity, readability, security, and performance. Provide concrete patch suggestions.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Review code matching a pattern and give actionable feedback.
- Provide unified diff-style patches when recommending code changes.
- Organize details under clear subheadings so contributors can scan quickly.

Example Input:
HttpClient

Expected Output:

- Usage cluster in src/network/* with note on inconsistent error handling.
