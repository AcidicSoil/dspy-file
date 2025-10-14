# Command: /user:generate-prompt-sequence

# Usage: /user:generate-prompt-sequence "Create and document a pull request for the currently staged changes." "['pr-desc.md','commit-msg.md','changed-files.md','review.md','release-notes.md']" "The user has already staged files using `git add`."

# Args:

# - {{goal}}: high-level outcome to achieve

# - {{prompts}}: list of candidate prompt names

# - {{context}}: optional extra details

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

1. `[${4}.md]`: Brief justification for why this prompt is first and what it accomplishes.
2. `[${4}.md]`: Brief justification for why this prompt is second and how it uses the previous output.
3. …

Identified Gaps (if any):

* $5

Acceptance:

* Sequence is dependency-ordered, covers all steps toward $1, and references only items from $2.
* If there are no gaps, write “None” under Identified Gaps.
  """

{
  "args": [
    {
      "id": "$1",
      "name": "goal",
      "hint": "High-level outcome to achieve",
      "example": "Create and document a pull request for the currently staged changes.",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "prompts",
      "hint": "List of candidate prompt names",
      "example": "[\"pr-desc.md\",\"commit-msg.md\",\"changed-files.md\",\"review.md\",\"release-notes.md\"]",
      "required": true,
      "validate": "\\[.*\\]"
    },
    {
      "id": "$3",
      "name": "context",
      "hint": "Optional extra details",
      "example": "The user has already staged files using `git add`.",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$4",
      "name": "prompt_name",
      "hint": "Generic prompt name in sequence",
      "example": "prompt_name",
      "required": true,
      "validate": "[a-zA-Z0-9_-]+"
    },
    {
      "id": "$5",
      "name": "identified_gaps",
      "hint": "Description of any missing action or prompt needed to complete the workflow",
      "example": "None",
      "required": false,
      "validate": ".*"
    }
  ]
}
