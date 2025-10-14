description = "Provide a high‑level review of the current branch vs origin/main."
prompt = """
Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.


Diff stats:
!{git diff --stat $1...$2}


Top 200 lines of patch for context:
```diff
!{git diff $1...$2 | sed -n '1,$3p'}
"""
