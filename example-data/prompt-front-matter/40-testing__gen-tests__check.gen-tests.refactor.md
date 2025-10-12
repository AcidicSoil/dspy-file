# Check Editorconfig Adherence

## Inputs
- CLI assistant role: check adherence to .editorconfig across the repo  
- Input context: inspect `.editorconfig`, run `git ls-files | sed -n '1,400p'`  
- Output format: structured report with summary, prioritized recommendations, workflow triggers, and fixes  

## Canonical taxonomy (exact strings)
- code quality
- configuration validation

### Stage hints (for inference)
- check
- validate
- insight generation
- compliance audit

## Algorithm
1. Extract signals from the prompt  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.  

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  
   → Identifier: `check-editorconfig-adherence`  

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).  
   → Categories: ["code quality", "configuration validation"]  

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.  
   → Stage: `validation`  

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  
   → Dependencies: ["git ls-files", ".editorconfig"]  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.  
   → Artifacts: ["structured report", "prioritized recommendations", "fix proposals"]  

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”  
   → Summary: "Do check adherence to .editorconfig across the repo to achieve consistent code formatting."  

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.  

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.  

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤7.
- No external context beyond prompt provided.

## Validation
- Identifier matches normalized id pattern → ✅
- Categories non-empty and drawn from canonical taxonomy (inferred) → ✅
- Stage present and valid per hints → ✅
- Dependencies are id-shaped and within limit → ✅
- Artifacts ≤3 and meaningful → ✅
- Summary ≤120 chars; punctuation coherent → ✅
- Body text is not altered → ✅

## Output format examples
```
{
  "identifier": "check-editorconfig-adherence",
  "categories": ["code quality", "configuration validation"],
  "stage": "validation",
  "dependencies": ["git ls-files", ".editorconfig"],
  "artifacts": ["structured report", "prioritized recommendations", "fix proposals"],
  "summary": "Do check adherence to .editorconfig across the repo to achieve consistent code formatting."
}
```

---

You are a CLI assistant focused on helping contributors with the task: Check adherence to .editorconfig across the repo.

1. Gather context by inspecting `.editorconfig`; running `git ls-files | sed -n '1,400p'`.
2. From the listing and config, point out inconsistencies and propose fixes.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Check adherence to .editorconfig across the repo.
- Offer prioritized, actionable recommendations with rationale.
- Highlight workflow triggers, failing jobs, and proposed fixes.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
