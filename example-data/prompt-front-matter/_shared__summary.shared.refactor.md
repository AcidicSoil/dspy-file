# Produce Readme-Level Summary of Repo

## Inputs
- Task: Generate a README-level summary of the repository.
- Context sources: `git ls-files | sed -n '1,400p'`, `README.md`, and `docs/` directory.
- Output format: structured report with clear sections (What, Why, How, Getting Started) and evidence documentation.

## Canonical taxonomy (exact strings)
- gathering
- generating
- synthesizing
- documenting

### Stage hints (for inference)
- input → analysis → output (generation)

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings: "Produce a README-level summary", "Gather context", "Generate high-level summary"
   - Imperative verbs: produce, gather, generate, synthesize, document
   - Intent sentences: "help contributors with the task", "synthesize insights into requested format"

2. Determine the primary identifier:
   - Explicit input: "Produce a README-level summary of the repo"
   - Normalized to: `produce-readme-summary-of-repo`

3. Determine categories:
   - From verbs and headings: gathering, generating, synthesizing
   - Validated against canonical taxonomy; de-duplicated

4. Determine lifecycle/stage (optional):
   - Inferred as "generation" via stage mapping from "analysis → output"
   - Stage: `generation`

5. Determine dependencies (optional):
   - Implicit: access to Git files and README.md/docs
   - Id-shaped items: `git-ls-files`, `readme-md`, `docs`
   - Count ≤ 3; kept as minimal

6. Determine provided artifacts (optional):
   - Structured report
   - Evidence documentation
   - High-level summary with priorities and next steps

7. Compose summary:
   - "Do produce a README-level summary of the repo to achieve clear, maintainable documentation."

8. Produce metadata in structured format:
   - Identifier: `produce-readme-summary-of-repo`
   - Categories: gathering, generating, synthesizing
   - Stage: generation
   - Dependencies: git-ls-files, readme-md, docs
   - Artifacts: structured report, evidence documentation, high-level summary
   - Summary: Do produce a README-level summary of the repo to achieve clear, maintainable documentation.

9. Reconcile if input already contains metadata:
   - No existing metadata; all values inferred or explicit

## Assumptions & Constraints
- Output is exactly one document: metadata block + blank line + original body.
- Only 7 placeholders used (within limit).
- All fields validated against schema and constraints.

## Validation
- Identifier matches normalized id pattern (`kebab-case`, starts with letter, lowercase)
- Categories non-empty and from canonical taxonomy (≤3)
- Stage is one of: input, analysis, generation → valid via mapping rules
- Dependencies are id-shaped (≤5), relevant to context sources
- Artifacts ≤3 and meaningful
- Summary ≤120 characters; punctuation coherent
- Original body unchanged

## Output format examples
- Identifier: `produce-readme-summary-of-repo`
- Categories: gathering, generating, synthesizing
- Stage: generation
- Dependencies: git-ls-files, readme-md, docs
- Artifacts: structured report, evidence documentation, high-level summary
- Summary: Do produce a README-level summary of the repo to achieve clear, maintainable documentation.

---

You are a CLI assistant focused on helping contributors with the task: Produce a README‑level summary of the repo.

1. Gather context by running `git ls-files | sed -n '1,400p'` for the repo map (first 400 files); inspecting `README.md` for the key docs if present; inspecting `docs` for the key docs if present.
2. Generate a high‑level summary (What, Why, How, Getting Started).
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Produce a README‑level summary of the repo.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
