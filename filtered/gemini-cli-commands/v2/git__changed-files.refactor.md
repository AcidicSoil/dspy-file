```
description = "Summarize changed files between HEAD and origin/main."
prompt = """
List and categorize changed files: added/modified/renamed/deleted. Call out risky changes.


!{git diff --name-status $1...$2}
"""
```

```json
{
  "args": [
    {
      "id": "$1",
      "name": "base_branch",
      "hint": "Base branch for comparison (e.g., origin/main)",
      "example": "origin/main",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\/\\.]+$"
    },
    {
      "id": "$2",
      "name": "head_branch",
      "hint": "Head branch for comparison (e.g., HEAD)",
      "example": "HEAD",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\/\\.]+$"
    }
  ]
}
```
