description = "Provide a high‑level review of the current branch vs origin/main."
prompt = """
Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.


Diff stats:
!$1


Top 200 lines of patch for context:
```diff
$2
```
"""

{
  "args": [
    {
      "id": "$1",
      "name": "diff_stats",
      "hint": "Git diff statistics between current branch and origin/main",
      "example": "  5 files changed, 30 insertions(+), 15 deletions(-)",
      "required": true,
      "validate": "^[ \\t\\S]*$"
    },
    {
      "id": "$2",
      "name": "patch_context",
      "hint": "Top 200 lines of the patch diff for code review context",
      "example": "--- a/src/utils.js\n+++ b/src/utils.js\n@@ -10,6 +10,7 @@\n  const log = (msg) => console.log(msg);\n  const warn = (msg) => console.warn(msg);\n+  const error = (msg) => console.error(msg);",
      "required": true,
      "validate": "^[ \\t\\S]*$"
    }
  ]
}
