description = "Summarize changed files between HEAD and origin/main."
prompt = """
List and categorize changed files: added/modified/renamed/deleted. Call out risky changes.


!$1
"""

{
  "args": [
    {
      "id": "$1",
      "name": "git_diff_output",
      "hint": "Output of `git diff --name-status origin/main...HEAD`",
      "example": "A/C src/utils/log.js\nD tests/integration/login.test.js\nM config/app.env",
      "required": true,
      "validate": "^\\n?$|^[A-Z]\\s+[a-zA-Z0-9_\\.\\/]+(\\n[A-Z]\\s+[a-zA-Z0-9_\\.\\/]+)*$"
    }
  ]
}
