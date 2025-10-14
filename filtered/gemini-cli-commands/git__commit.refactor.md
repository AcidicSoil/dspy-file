# ~/.gemini/commands/git/commit.toml
description = "Generate a Conventional Commit from STAGED changes and commit it (with approval)."

prompt = """
You are helping craft an exact Conventional Commit message for the staged changes below.
Return TWO things in order:

1) The final commit message as plain text (max 72-char subject, then optional body).
2) A single safe shell command that will COMMIT using that exact message via STDIN:

printf "%s" "<PASTE THE EXACT MESSAGE ABOVE>" | git commit -F -

Rules:
- Use the STAGED diff provided (not the working tree).
- No backticks or code fences around the commit message itself.
- Quote safely; do not use single quotes inside the printf payload.
- If there are no staged changes, respond with: $1.

Staged diff:
```diff
!$2
"""
Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "no_staged_changes_message",
      "hint": "Message to return when no staged changes are present",
      "example": "NO_STAGED_CHANGES",
      "required": true,
      "validate": "^[A-Za-z_]+$"
    },
    {
      "id": "$2",
      "name": "staged_diff_command",
      "hint": "Command to generate staged diff (must be valid shell command)",
      "example": "git diff --staged --no-color",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.\\/ ]+$"
    },
    {
      "id": "$3",
      "name": "commit_message",
      "hint": "The commit message to be used in the printf command",
      "example": "feat: add new feature",
      "required": true,
      "validate": ".+"
    }
  ]
}
