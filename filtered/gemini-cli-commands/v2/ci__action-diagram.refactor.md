description = "Explain workflow triggers and dependencies as a diagram‑ready outline."
prompt = """
From these workflow files, produce a step‑by‑step outline suitable for a diagram (nodes and edges):


@{$1}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "workflow_directory",
      "hint": "Path to the GitHub workflows directory",
      "example": ".github/workflows",
      "required": true,
      "validate": "^[a-zA-Z0-9._/-]+$"
    }
  ]
}
