description = "Provide a high‑level review of the current branch vs $1."
prompt = """
Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.


Diff stats:
!{git diff --stat $1...HEAD}


Top 200 lines of patch for context:
```diff
!{git diff $1...HEAD | sed -n '1,200p'}
"""
{
  "args": [
    {
      "id": "$1",
      "name": "base_branch",
      "hint": "The base branch to compare against",
      "example": "origin/main",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\/]+(?:\\/[a-zA-Z0-9_\\-\\/]+)?$"
    }
  ]
}
