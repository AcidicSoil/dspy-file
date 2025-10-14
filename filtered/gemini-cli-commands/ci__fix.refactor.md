```toml
description = "Diagnose and fix a failing GitHub Actions/CI workflow."
prompt = """
Analyze workflows and recent run logs; hypothesize root causes and propose fixes.


Workflows:
@{$1}


Recent CI‑related commits:
!{$2}
"""
```
{
  "args": [
    {
      "id": "$1",
      "name": "workflows_path",
      "hint": "Path to GitHub workflows directory or file",
      "example": ".github/workflows",
      "required": true,
      "validate": "^[a-zA-Z0-9._/-]+$"
    },
    {
      "id": "$2",
      "name": "git_log_command",
      "hint": "Git log command to fetch recent commits",
      "example": "git log --pretty='- %h %s' -n 30",
      "required": true,
      "validate": "^[a-zA-Z0-9._\\- /]+$"
    }
  ]
}
