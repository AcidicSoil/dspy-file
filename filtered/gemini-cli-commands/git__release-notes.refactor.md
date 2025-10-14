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
      "name": "commit_range_or_tag",
      "hint": "Git commit range or tag (e.g., v1.2.0..HEAD)",
      "example": "v1.2.0..HEAD",
      "required": false,
      "validate": "^[a-zA-Z0-9._\\-]+(?:\\.\\.\\.[a-zA-Z0-9._\\-]+)?$"
    }
  ]
}
