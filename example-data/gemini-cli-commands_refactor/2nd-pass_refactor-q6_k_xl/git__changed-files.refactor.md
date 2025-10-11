description = "Summarize changed files between HEAD and origin/main."
prompt = """
List and categorize changed files: added/modified/renamed/deleted. Call out risky changes.


!{git diff --name-status origin/main...HEAD}
"""
