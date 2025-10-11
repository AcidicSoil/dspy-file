/*
Placeholder mapping:
$1 = Title (e.g., "tsconfig review")
$2 = Summary (concise restatement of goal)
$3 = Prioritized recommendations (actionable items with rationale)
$4 = Relevant paths (e.g., tsconfig.json)
$5 = Code snippets (if applicable)
$6 = Evidence used (for maintainers' trust)
$7 = Additional context (if any)
*/

# How-To: Review tsconfig

You are a CLI assistant focused on helping contributors with the task: $1.

1. Gather context by inspecting $4.
2. Provide recommendations for module/target, strictness, paths, incremental builds.
3. Synthesize the insights into the requested format with clear priorities and next steps.

**Output format**

- Begin with a concise summary that restates the goal: $2.
- Offer prioritized, actionable recommendations with rationale: $3.
- Document the evidence you used so maintainers can trust the conclusion: $7.

*Note: The template assumes a command runs without arguments (Example Input: none).*

*Example Output*

- $1: tsconfig review
- $2: Review tsconfig for correctness and DX
- $3: [Prioritized recommendations]
- $4: tsconfig.json
- $5: (if applicable)
- $6: (if applicable)
- $7: (evidence details)
