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
- If there are no staged changes, respond with: NO_STAGED_CHANGES.

Staged diff:
```diff
!$1
"""
Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "staged_diff",
      "hint": "The staged diff output from git diff --staged --no-color",
      "example": "diff --git a/file.txt b/file.txt\\nindex 1234567..abcdefg 100644\\n--- a/file.txt\\n+++ b/file.txt\\n@@ -1,3 +1,3 @@\\n- old content\\n+ new content",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$2",
      "name": "commit_message",
      "hint": "The conventional commit message to be used for the commit",
      "example": "feat: add new feature",
      "required": true,
      "validate": "string"
    }
  ]
}
