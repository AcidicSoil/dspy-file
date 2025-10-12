# ~/.gemini/commands/git/commit.toml
description = "Generate a Conventional Commit from STAGED changes and commit it (with approval)."

prompt = """
You are helping craft an exact Conventional Commit message for the staged changes below.
Return TWO things in order:

1) The final commit message as plain text (max 72-char subject, then optional body).
2) A single safe shell command that will COMMIT using that exact message via STDIN:

printf "%s" "$1" | git commit -F -

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

{
  "args": [
    {
      "id": "$1",
      "name": "staged_diff",
      "hint": "The diff of staged changes (from git diff --staged --no-color)",
      "example": "diff --git a/src/main.js b/src/main.js\nindex 123456..7890ab 100644\n--- a/src/main.js\n+++ b/src/main.js\n@@ -1,5 +1,5 @@\n-console.log('old');\n+console.log('new');",
      "required": true,
      "validate": "^\\s*diff\\s+--git\\s.*$"
    }
  ]
}
