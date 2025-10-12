# Lists stale/merged local branches and proposes deletions
description = "Suggest safe local branch cleanup (merged/stale)."
prompt = """
Using the lists below, suggest local branches safe to delete and which to keep. Include commands to remove them if desired (DO NOT execute).


Merged into current upstream:
!$1


Branches not merged:
!$2


Recently updated (last author dates):
!$3
"""

{
  "args": [
    {
      "id": "$1",
      "name": "merged_branches",
      "hint": "List of branches merged into current upstream",
      "example": "main, feature/login, bugfix/auth",
      "required": true,
      "validate": "^[\\s\\S]*$"
    },
    {
      "id": "$2",
      "name": "unmerged_branches",
      "hint": "List of branches not merged into current upstream",
      "example": "feature/payment, dev-ui",
      "required": true,
      "validate": "^[\\s\\S]*$"
    },
    {
      "id": "$3",
      "name": "recently_updated_branches",
      "hint": "List of branches sorted by author date, showing recent activity",
      "example": "feature/user-profile — 2 days ago, bugfix/login — 1 day ago",
      "required": true,
      "validate": "^[\\s\\S]*$"
    }
  ]
}
