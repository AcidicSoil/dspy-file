# $1 optional: brief PR context or ticket ID
description = "Draft a PR description from the branch diff."
prompt = """
Create a crisp PR description following this structure: Summary, Context, Changes, Screenshots (if applicable), Risk, Test Plan, Rollback, Release Notes (if user‑facing).


Base branch: origin/main
User context: $1


Changed files (name + status):
!{git diff --name-status origin/main...HEAD}


High‑level stats:
!{git diff --shortstat origin/main...HEAD}
"""
