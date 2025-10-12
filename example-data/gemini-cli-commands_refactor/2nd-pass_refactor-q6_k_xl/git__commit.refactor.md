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
$1
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "staged_diff",
      "hint": "The staged diff content (e.g., from git diff --staged --no-color)",
      "example": "modified:   src/main.rs (created)\n+    println!(\"Hello, world!\");\n-    println!(\"Hello, old world!\");",
      "required": true,
      "validate": "^\\s*\\$\\{\\s*\\}\\s*$"
    }
  ]
}
