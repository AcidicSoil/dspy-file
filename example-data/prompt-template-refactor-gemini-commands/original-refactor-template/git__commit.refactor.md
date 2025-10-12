<!-- $1=staged diff content (raw diff) -->
<!-- $2=final commit message (subject + optional body) -->
<!-- $3=safe shell command to commit using the message -->

**Conventional Commit Generator**

This prompt generates a standardized Git commit message from staged changes and provides a safe shell command to execute it.

### Purpose
Generate a Conventional Commit message based on the staged changes, following standard formatting rules.

### Input
- $1: The raw staged diff (from `git diff --staged --no-color`)

### Output Format
Return exactly two lines in order:
1) A plain text commit message with maximum 72 characters for the subject line, followed by an optional body.
2) A single shell command using `printf` and `git commit -F -`, which will apply the exact message via STDIN.

Example output:
```
fix: resolve memory leak in data loader
This fixes a buffer overflow issue when processing large files.

printf "%s" "fix: resolve memory leak in data loader\nThis fixes a buffer overflow issue when processing large files." | git commit -F -
```

### Rules
- Use only the staged changes (not working tree).
- Do not use backticks or code fences around the message.
- Quote safely; avoid single quotes inside the printf payload.
- If no staged changes exist, respond with: `NO_STAGED_CHANGES`.

### Notes
- The generated commit message must follow Conventional Commit standards (e.g., type:fix, scope:auth).
- The shell command ensures reproducibility and safety when executing.
