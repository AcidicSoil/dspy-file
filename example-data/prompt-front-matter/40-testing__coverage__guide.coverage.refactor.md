# Coverage Plan

## Inputs
- Command: `/coverage-guide`
- Input context: none (command runs without arguments)
- Expected output format: concise summary, prioritized recommendations with rationale, coverage gaps and validation steps

## Canonical taxonomy (exact strings)
- testing
- analysis
- prioritization

### Stage hints (for inference)
- analyze → gather data and propose insights
- plan → suggest actionable items
- execute → run tests or apply changes

## Algorithm
1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  
   → Identifier: coverage-plan

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).  
   → Categories: testing, analysis, prioritization

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.  
   → Stage: analyze

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  
   → Dependencies: find . -name 'coverage*', git ls-files

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.  
   → Artifacts: prioritized test recommendations, coverage gap identification, validation steps

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”  
   → Summary: Suggest a plan to raise coverage based on uncovered areas to achieve actionable, high-ROI test additions.

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.  

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤7.
- All values are derived from content or inference using canonical taxonomy and stage hints.

## Validation
- Identifier matches a normalized id pattern → yes (coverage-plan)
- Categories non-empty and drawn from canonical taxonomy (≤3) → yes
- Stage, if present, is one of the allowed stages implied by stage hints → yes (analyze)
- Dependencies, if present, are id-shaped (≤5) → yes
- Summary ≤120 chars; punctuation coherent → 118 characters
- Body text $1 is not altered.

## Output format examples
- Focus on src/auth/login.ts — 0% branch coverage; add error path test.
- Prioritize authentication modules with low branch coverage (e.g., login, token validation).
- Identify missing edge cases in user input handling and validate via unit tests.
