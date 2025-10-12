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
      "hint": "The latest tagged version (e.g., v1.2.3)",
      "example": "v1.2.3",
      "required": true,
      "validate": "^v\\d+\\.\\d+\\.\\d+$"
    },
    {
      "id": "$2",
      "name": "commits_since_tag",
      "hint": "List of commit messages since the last tag, excluding merges",
      "example": "feat: add user authentication\nfix: resolve login timeout\nchore: update dependencies",
      "required": true,
      "validate": "^\\s*\\S+\\n?\\s*$"
    }
  ]
}
