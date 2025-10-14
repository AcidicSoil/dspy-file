```md
# Prettier Adoption Migration Plan

Task: Given a `package.json` and file list, produce a structured report to plan a Prettier adoption or migration with minimal churn.

## Inputs
- Input files: `package.json`, filtered file list via `git ls-files '*.*' | sed -n '1,400p'`
- No explicit user input (command runs without arguments)

## Canonical taxonomy (exact strings)
- adoption
- migration
- planning

### Stage hints (for inference)
- analysis → when gathering context and proposing plans
- synthesis → when generating structured output

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings: "Plan a Prettier adoption or migration"
   - Imperative verbs: gather, propose, synthesize, document
   - Explicit tags: "minimal churn", "rollout plan", "ignore patterns"

2. Determine the primary identifier:
   - From action and object → `{identifier}`
   - Normalized to kebab-case, lowercase, length-capped (≤30), starts with letter.

3. Determine categories:
   - Explicit: adoption, migration, planning
   - Inferred from verbs: planning, proposing → mapped to canonical taxonomy
   - Final list: [{categories}] — validated and de-duplicated

4. Determine lifecycle/stage (optional):
   - From stage hints: "{stage}" → inferred as primary stage
   - Omitted if uncertain; here it is clear.

5. Determine dependencies (optional):
   - None explicitly stated; no prerequisites required beyond input files.
   - Empty list.

6. Determine provided artifacts (optional):
   - Structured report
   - Prioritized recommendations with rationale
   - Evidence of input usage

7. Compose summary:
   - One sentence: "{summary}"

8. Produce metadata in the requested format:
   - Identifier: {identifier}
   - Categories: [{categories}]
   - Stage: {stage}
   - Dependencies: []
   - Artifacts: ["structured report", "prioritized recommendations", "evidence of input usage"]
   - Summary: "{summary}"

9. Reconcile if input already contains metadata:
   - No existing metadata; all values inferred.
   - All lists validated and within constraints.

## Assumptions & Constraints
- Emit exactly one document: metadata block, blank line, then original body unchanged.
- Limit distinct placeholders to ≤7.
- Output format must preserve the original prompt text.

## Validation
- Identifier matches normalized pattern → ✅
- Categories non-empty, drawn from canonical taxonomy (≤3) → ✅
- Stage is in allowed set: "{stage}" → ✅
- Dependencies are id-shaped and empty → ✅
- Artifacts ≤3 → ✅
- Summary ≤120 chars → ✅

## Output format examples
- Identifier: {identifier}  
- Categories: [{categories}]  
- Stage: {stage}  
- Dependencies: []  
- Artifacts: ["structured report", "prioritized recommendations", "evidence of input usage"]  
- Summary: "{summary}"
```
