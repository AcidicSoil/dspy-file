# Command: /user:generate-prompt-sequence

# Usage: /user:generate-prompt-sequence "Create and document a pull request for the currently staged changes." "['pr-desc.md','commit-msg.md','changed-files.md','review.md','release-notes.md']" "The user has already staged files using `git add`."

# Args:

# - $1: high-level outcome to achieve

# - $2: list of candidate prompt names

# - $3: optional extra details

# Source:

prompt = """
Given:

* High-Level Goal: $1
* Available Prompts: $2
* Context (optional): $3

Do the following:

1. Analyze the goal. Break $1 into logical steps from start to desired outcome.

2. Map prompts to steps. For each step, select the best prompt from $2 whose output satisfies the step and whose inputs are available (from context or from prior steps’ outputs). Note explicit input/output dependencies.

3. Establish order. Arrange the chosen prompts into a numbered sequence that honors dependencies and forms a complete workflow.

4. Identify gaps. If any required step lacks a suitable prompt from $2, clearly describe what’s missing.

Output exactly in this format:

Execution Sequence:

1. `[prompt_name_1.md]`: Brief justification for why this prompt is first and what it accomplishes.
2. `[prompt_name_2.md]`: Brief justification for why this prompt is second and how it uses the previous output.
3. …

Identified Gaps (if any):

* Describe any missing action or prompt needed to complete the workflow.

Acceptance:

* Sequence is dependency-ordered, covers all steps toward $1, and references only items from $2.
* If there are no gaps, write “None” under Identified Gaps.
  """

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "goal",
      "hint": "high-level outcome to achieve",
      "example": "Create and document a pull request for the currently staged changes",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "prompts",
      "hint": "list of candidate prompt names",
      "example": "[\"pr-desc.md\",\"commit-msg.md\",\"changed-files.md\",\"review.md\",\"release-notes.md\"]",
      "required": true,
      "validate": "\\[.*\\]"
    },
    {
      "id": "$3",
      "name": "context",
      "hint": "optional extra details",
      "example": "The user has already staged files using `git add`",
      "required": false,
      "validate": ".*"
    }
  ]
}
