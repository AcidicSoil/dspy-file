# {{args}} optional: brief PR context or ticket ID
description = "Draft a PR description from the branch diff."
prompt = """
Create a crisp PR description following this structure: Summary, Context, Changes, Screenshots (if applicable), Risk, Test Plan, Rollback, Release Notes (if user‑facing).


Base branch: $2
User context: {{args}}


Changed files (name + status):
!{git diff --name-status $2...HEAD}


High‑level stats:
!{git diff --shortstat $2...HEAD}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "pr_context_or_ticket_id",
      "hint": "Optional PR context or ticket ID",
      "example": "PROJ-1234",
      "required": false,
      "validate": "^[A-Z0-9]+(-\\d+)?$"
    },
    {
      "id": "$2",
      "name": "base_branch",
      "hint": "Base branch for comparison",
      "example": "origin/main",
      "required": true,
      "validate": "^.+$"
    }
  ]
}
