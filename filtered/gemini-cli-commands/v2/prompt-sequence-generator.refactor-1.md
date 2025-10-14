# Command: /prompts:sequence-from-goal

# Usage: /prompts:sequence-from-goal "Create and document a pull request for the currently staged changes."

# Args:

# - $1: the one-sentence high-level goal to achieve

# - $2: path or glob to available prompt files (optional)

# - $3: extra context to consider (optional)

prompt = """
Generate a logical execution sequence to accomplish $1 using the available prompts (from $2 if provided) and any $3.

Do this:

1. Analyze the goal: deconstruct $1 into the minimal logical steps from start to desired outcome.
2. Map prompts to steps: for each step, choose the most suitable prompt from the available set; prefer prompts whose outputs satisfy later inputs. Note dependencies explicitly.
3. Establish order: produce a numbered list of prompts arranged to satisfy all dependencies end-to-end.
4. Identify gaps: if any required step lacks a matching prompt, state the missing action/prompt.

Available prompts:

* Treat each file matched by $2 as a candidate prompt (use its filename as the prompt name).
* If multiple prompts could satisfy a step, pick the best one and briefly justify why.

Output format (exactly):

Execution Sequence:

1. **`[prompt_name_1.md]`**: Why it is first and what it accomplishes.
2. **`[prompt_name_2.md]`**: Why it is second and how it uses prior output.
3. ...

Identified Gaps (if any):

* Describe any missing step or prompt needed to complete the workflow.

Acceptance:

* Sequence is complete, dependency-aware, and ends at the stated goal.
* Every listed item references an available prompt name (or appears under “Identified Gaps”).
  """

{
  "args": [
    {
      "id": "$1",
      "name": "query",
      "hint": "the one-sentence high-level goal to achieve",
      "example": "Create and document a pull request for the currently staged changes",
      "required": true,
      "validate": ""
    },
    {
      "id": "$2",
      "name": "path",
      "hint": "path or glob to available prompt files (optional)",
      "example": "prompts/*.md",
      "required": false,
      "validate": ""
    },
    {
      "id": "$3",
      "name": "context",
      "hint": "extra context to consider (optional)",
      "example": "Review the code changes before generating the sequence",
      "required": false,
      "validate": ""
    }
  ]
}
