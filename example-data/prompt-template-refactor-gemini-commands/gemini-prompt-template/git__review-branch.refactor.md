description = "Provide a high‑level review of the current branch vs origin/main."
prompt = """
Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.


Diff stats:
!{git diff --stat origin/main...HEAD}


Top 200 lines of patch for context:
```diff
!{git diff origin/main...HEAD | sed -n '1,200p'}
```
"""
