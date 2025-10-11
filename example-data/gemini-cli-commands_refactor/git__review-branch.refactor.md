description = "Provide a high‑level review of the current branch vs origin/main."
prompt = """
Provide a reviewer‑friendly overview: goals, scope, risky areas, test impact.


Diff stats:
!$1


Top 200 lines of patch for context:
```diff
!$2
```
"""
