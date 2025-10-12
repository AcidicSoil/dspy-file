# Refactor Task Template

Task: Given the following prompt, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original text.

## Inputs
- Input file path: `C:\Users\user\projects\prompts\temp-prompts\30-refactor\refactor\refactor-file.refactor.md`
- Source prompt content:
  You are a CLI assistant focused on helping contributors with the task: Suggest targeted refactors for a single file.

1. Gather context by running `sed -n '1,400p' {{args}}` for the first 400 lines of the file.
2. Suggest refactors that reduce complexity and improve readability without changing behavior. Provide before/after snippets.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Suggest targeted refactors for a single file.
- Include before/after snippets or diffs with commentary.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
src/components/Button.tsx

Expected Output:

- Refactor proposal extracting shared styling hook with before/after snippet.

## Canonical taxonomy (exact strings)
- refactoring
- code analysis
- suggestion

### Stage hints (for inference)
- analysis → synthesis → output
- pre-processing → insight generation → proposal delivery

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   → Identifier: "refactor"

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   → Categories: ["refactoring", "code analysis", "suggestion"]

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map categories via stage hints.
   - Omit if uncertain.
   → Stage: "analysis"

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependencies: ["file content path"]

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.
   → Artifacts: ["before/after snippets", "summary", "evidence documentation"]

7. Compose summary:
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   → Summary: "Suggest targeted refactors for a single file to reduce complexity and improve readability without changing behavior."

8. Produce metadata in the requested format:
   - Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original text.
- Limit distinct placeholders to ≤ 7.
- Do not alter the body content after metadata.

## Validation
- Identifier matches a normalized id pattern. ✅ (refactor)
- Categories non-empty and drawn from canonical taxonomy (≤3). ✅
- Stage, if present, is one of the allowed stages implied by stage hints. ✅ ("analysis")
- Dependencies, if present, are id-shaped (≤5). ✅
- Artifacts short and relevant. ✅
- Summary ≤120 chars; punctuation coherent. ✅
- Body text unchanged. ✅

## Output format examples
- Identifier: refactor  
- Categories: refactoring, code analysis, suggestion  
- Stage: analysis  
- Dependencies: file content path  
- Artifacts: before/after snippets, summary, evidence documentation  
- Summary: "Suggest targeted refactors for a single file to reduce complexity and improve readability without changing behavior."

---

You are a CLI assistant focused on helping contributors with the task: Suggest targeted refactors for a single file.

1. Gather context by running `sed -n '1,400p' {{args}}` for the first 400 lines of the file.
2. Suggest refactors that reduce complexity and improve readability without changing behavior. Provide before/after snippets.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Suggest targeted refactors for a single file.
- Include before/after snippets or diffs with commentary.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
src/components/Button.tsx

Expected Output:

- Refactor proposal extracting shared styling hook with before/after snippet.
