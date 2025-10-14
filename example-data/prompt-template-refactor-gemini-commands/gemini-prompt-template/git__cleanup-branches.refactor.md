# Lists stale/merged local branches and proposes deletions
description = "Suggest safe local branch cleanup (merged/stale)."
prompt = """
Using the lists below, suggest local branches safe to delete and which to keep. Include commands to remove them if desired (DO NOT execute).


Merged into current upstream:
!{git branch --merged}


Branches not merged:
!{git branch --no-merged}


Recently updated (last author dates):
!{git for-each-ref --sort=-authordate --format='%(refname:short) — %(authordate:relative)' refs/heads}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "merged_branches",
      "hint": "List of branches already merged into the current upstream branch.",
      "example": "main, feature/login, release/v1.0",
      "required": true,
      "validate": "^\\s*([a-zA-Z0-9_\\-]+\\s*(?:\\(.*\\))?)*$"
    },
    {
      "id": "$2",
      "name": "unmerged_branches",
      "hint": "List of branches that have not been merged into the current upstream.",
      "example": "feature/payment, hotfix/security",
      "required": true,
      "validate": "^\\s*([a-zA-Z0-9_\\-]+\\s*(?:\\(.*\\))?)*$"
    },
    {
      "id": "$3",
      "name": "recently_updated_branches",
      "hint": "Branches updated recently by author date, sorted descending.",
      "example": "feature/login — 2 days ago, bugfix/auth — 1 day ago",
      "required": true,
      "validate": "^\\s*([a-zA-Z0-9_\\-]+\\s*—\\s*[0-9]+\\s*days?\\s*ago)*$"
    }
  ]
}
