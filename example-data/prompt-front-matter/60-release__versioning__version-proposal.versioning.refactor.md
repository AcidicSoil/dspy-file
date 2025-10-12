# Version Proposal

## Metadata

- **identifier**: version-proposal
- **categories**: 
  - semantic-versioning
  - commit-history-analysis
- **lifecycle-stage**: proposal
- **dependencies**: 
  - git describe --tags --abbrev=0
  - git log --pretty='%s' --no-merges <tag>..HEAD
- **provided-artifacts**: 
  - structured-report
  - version-suggestion (major/minor/patch)
  - rationale-for-version-choice
- **summary**: Propose next version (major/minor/patch) from commit history.

## Inputs

- Trigger: `/version-proposal`
- Purpose: Propose the next semantic version based on commit history.
- User context: Contributor requesting version suggestion via CLI.

## Canonical taxonomy (exact strings)

- semantic-versioning
- commit-history-analysis
- git-operation
- version-suggestion
- rationale-generation
- report-synthesis

### Stage hints (for inference)

- proposal → initial analysis and output generation
- validation → after user feedback or review
- deployment → post-approval integration

## Algorithm

1. Extract signals from the prompt:
   - Titles/headings: "Version Proposal", "Purpose", "Output"
   - Imperative verbs: "Propose", "Gather", "Synthesize", "Document"
   - Explicit tags: `/version-proposal`, "semantic version", "commit history"

2. Determine primary identifier:
   - Prefer explicit input → "/version-proposal"
   - Normalize to kebab-case → `version-proposal`

3. Determine categories:
   - Prefer explicit input → "semantic versioning", "commit history analysis"
   - Validate against canonical taxonomy → match exact strings
   - De-duplicate and limit to ≤3

4. Determine lifecycle stage:
   - Map from category: "proposal" (from intent of initiating a suggestion)
   - Use stage hint mapping: proposal → initial analysis

5. Determine dependencies:
   - Parse command phrases: git describe, git log — extract as id-shaped strings
   - Keep only relevant and id-shaped entries

6. Determine provided artifacts:
   - From output structure: structured report, version suggestion, rationale

7. Compose summary:
   - One sentence: "Propose next version (major/minor/patch) from commit history."

8. Produce metadata in human-readable format.

9. Reconcile if input already contains metadata:
   - No explicit metadata present; all inferred and derived from prompt structure.
   - Final metadata reflects clean, validated output.

## Assumptions & Constraints

- Output must contain exactly one document: metadata block, blank line, then original body unchanged.
- All identifiers normalized to lowercase kebab-case.
- Categories strictly drawn from canonical taxonomy (exact strings).
- Lifecycle stage inferred only when explicit input is missing.
- Dependencies limited to ≤5 and in id-shaped form.
- Summary must be ≤120 characters.

## Validation

- Identifier: `version-proposal` → matches kebab-case pattern, starts with letter
- Categories: non-empty, drawn from canonical list (≤3)
- Stage: "proposal" is valid per stage hints
- Dependencies: all are git commands, id-shaped, ≤5
- Artifacts: ≤3 items, relevant to output
- Summary: 94 characters, coherent and concise

## Output format examples

- Example Input:
  - (none – command runs without arguments)

- Expected Output:

  - Structured report following the specified sections.

---

# Version Proposal

Trigger: /version-proposal

Purpose: Propose the next semantic version based on commit history.

You are a CLI assistant focused on helping contributors with the task: Propose next version (major/minor/patch) from commit history.

1. Gather context by running `git describe --tags --abbrev=0` for the last tag; running `git log --pretty='%s' --no-merges $(git describe --tags --abbrev=0)..HEAD` for the commits since last tag (no merges).
2. Given the Conventional Commit history since the last tag, propose the next SemVer and justify why.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Propose next version (major/minor/patch) from commit history.
- Offer prioritized, actionable recommendations with rationale.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
