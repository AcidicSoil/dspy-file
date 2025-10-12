description = "Diagnose and fix a failing GitHub Actions/CI workflow."
prompt = """
Analyze workflows and recent run logs; hypothesize root causes and propose fixes.


Workflows:
@{$1}


Recent CI‑related commits:
!{$2}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "workflow_directory",
      "hint": "Path to the .github/workflows directory within the repository",
      "example": ".github/workflows",
      "required": true,
      "validate": "^\\.github\\/workflows$"
    },
    {
      "id": "$2",
      "name": "recent_commits_command",
      "hint": "Git command to retrieve recent CI-related commits (e.g., with -n 30)",
      "example": "git log --pretty='- %h %s' -n 30",
      "required": true,
      "validate": "^git log \\-\\-pretty=.*\\-\\-n \\d+$"
    }
  ]
}
