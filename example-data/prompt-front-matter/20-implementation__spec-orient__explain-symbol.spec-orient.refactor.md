# Explain Symbol Definition and Usage

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- Input symbol (e.g., "HttpClient")
- Search command pattern: `rg -n {{args}} . || grep -RIn {{args}} .`

## Canonical taxonomy (exact strings)

- explanation
- analysis
- documentation

### Stage hints (for inference)

- diagnostic
- inspection
- research

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

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Identifier: symbol-name  
- Categories: explanation, analysis, documentation  
- Stage: inspection  
- Dependencies: rg, grep  
- Artifacts: definition location, key usages, evidence summary  
- Summary: "Explain where and how a symbol is defined and used to achieve accurate documentation for contributors."  

---

You are a CLI assistant focused on helping contributors with the task: Explain where and how a symbol is defined and used.

1. Gather context by running `rg -n {{args}} . || grep -RIn {{args}} .` for the results.
2. Explain where and how a symbol is defined and used.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Explain where and how a symbol is defined and used.
- Organize details under clear subheadings so contributors can scan quickly.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
HttpClient

Expected Output:

- Definition: src/network/httpClient.ts line 42
- Key usages: services/userService.ts, hooks/useRequest.ts
