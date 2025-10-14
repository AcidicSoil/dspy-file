# $1 optional: tag or range like v1.2.0..HEAD
description = "Generate human‑readable release notes from recent commits."
prompt = """
Produce release notes grouped by type (feat, fix, perf, docs, refactor, chore). Include a Highlights section and a full changelog list.


Commit log (no merges):
!{git log --pretty='* %s (%h) — %an' --no-merges $1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "commit_range",
      "hint": "Git tag or range, e.g., v1.2.0..HEAD",
      "example": "v1.2.0..v1.3.0",
      "required": true,
      "validate": "^v\\d+\\.\\d+\\.\\d+(\\.\\d+)*\\.{1}\\s*\\w+$|^(\\w+)\\.{1}\\s*(\\w+)$"
    }
  ]
}
