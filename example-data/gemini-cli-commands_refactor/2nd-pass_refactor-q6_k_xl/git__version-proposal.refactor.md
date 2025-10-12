# Propose next SemVer based on Conventional Commits since last tag
description = "Propose next version (major/minor/patch) from commit history."
prompt = """
Given the Conventional Commit history since the last tag, propose the next SemVer and justify why.


Last tag:
!$1


Commits since last tag (no merges):
!$2
"""

{
  "args": [
    {
      "id": "$1",
      "name": "last_tag",
      "hint": "The name of the last tagged version (e.g., v1.2.3)",
      "example": "v1.2.3",
      "required": true,
      "validate": "^v\\d+\\.\\d+\\.\\d+$"
    },
    {
      "id": "$2",
      "name": "commits_since_last_tag",
      "hint": "List of commit messages since the last tag, without merges (e.g., 'feat: add login', 'fix: resolve crash')",
      "example": "feat: add authentication\nfix: resolve timeout",
      "required": true,
      "validate": "^(\\S+\\s*\\(\\w+\\)\\s*\\n?)*$"
    }
  ]
}
