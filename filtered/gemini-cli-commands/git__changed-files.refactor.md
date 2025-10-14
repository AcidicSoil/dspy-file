```toml
description = "Summarize changed files between HEAD and origin/main."
prompt = """
List and categorize changed files: added/modified/renamed/deleted. Call out risky changes.

!{$1}
"""
```
{
  "args": [
    {
      "id": "$1",
      "name": "git_diff_command",
      "hint": "Git command to diff files",
      "example": "git diff --name-status origin/main...HEAD",
      "required": true,
      "validate": "^[\\S ]+$"
    }
  ]
}
