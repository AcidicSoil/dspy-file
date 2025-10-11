description = "Suggest likely owners/reviewers for a path."
prompt = """
Based on CODEOWNERS and git history, suggest owners.


CODEOWNERS (if present):
@{.github/CODEOWNERS}


Recent authors for the path:
!{git log --pretty='- %an %ae: %s' -- $1 | sed -n '1,50p'}
"""
