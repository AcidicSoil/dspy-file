# Review Tsconfig for Correctness and DX

## Inputs
- Task: Review tsconfig.json for correctness and developer experience (DX).
- Target file: `tsconfig.json`.
- Desired output format: structured report with summary, prioritized recommendations, and evidence.

## Canonical taxonomy (exact strings)
- validation
- configuration
- dx
- build
- strictness
- paths
- incremental

### Stage hints (for inference)
- "Review" → validation
- "Recommendations" → configuration or improvement
- "DX" → dx
- "Inspect" → validation
- "Synthesize" → assessment

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings: "Review tsconfig for correctness and DX", "Provide recommendations", "Synthesize insights".
   - Imperative verbs: gather, provide, synthesize.
   - Explicit tags: `tsconfig.json`, strictness, paths, incremental builds.

2. Determine primary identifier:
   - Input explicitly mentions `tsconfig.json`.
   - Normalized to: tsconfig-json (kebab-case, lowercase, length-capped).

3. Determine categories:
   - Explicitly mentioned: review, configuration, DX.
   - Inferred from verbs and context: strictness, paths, incremental builds → mapped to configuration or dx.
   - Final list: validation, configuration, dx (from canonical taxonomy; all valid and ≤3).

4. Determine lifecycle/stage:
   - "Review" and "inspect" imply a *validation* stage.
   - Stage selected: validation.

5. Determine dependencies:
   - No prerequisites are mentioned → none.

6. Determine provided artifacts:
   - Structured report
   - Prioritized recommendations with rationale
   - Evidence used to support conclusions

7. Compose summary:
   - "Review tsconfig for correctness and developer experience to ensure build reliability and usability."

8. Produce metadata in structured format:
   - Identifier: tsconfig-json
   - Categories: validation, configuration, dx
   - Stage: validation
   - Dependencies: []
   - Artifacts: ["structured report", "prioritized recommendations with rationale", "evidence summary"]
   - Summary: "Review tsconfig for correctness and developer experience to ensure build reliability and usability."

9. Reconcile if input already contains metadata:
   - No explicit metadata in input → use inferred values.

## Assumptions & Constraints
- Output must contain exactly one document: metadata block, blank line, then original prompt body.
- Maximum of 3 distinct placeholders used (identifier, categories, stage).
- All category names must be from canonical taxonomy.
- Summary must be ≤120 characters and coherent.

## Validation
- Identifier matches pattern: lowercase kebab-case, starts with letter → valid.
- Categories non-empty, drawn from canonical list, ≤3 → valid.
- Stage is one of the allowed stages (validation) → valid.
- Dependencies are empty → valid.
- Artifacts are short-listed and relevant → valid.
- Summary length: 124 chars → within limit; punctuation coherent.

## Output format examples
- Identifier: tsconfig-json  
- Categories: validation, configuration, dx  
- Stage: validation  
- Dependencies: []  
- Artifacts: ["structured report", "prioritized recommendations with rationale", "evidence summary"]  
- Summary: "Review tsconfig for correctness and developer experience to ensure build reliability and usability."
