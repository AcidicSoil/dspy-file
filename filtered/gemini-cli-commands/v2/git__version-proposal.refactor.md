# Propose next SemVer based on Conventional Commits since last tag
description = "Propose next version (major/minor/patch) from commit history."
prompt = """
Given the Conventional Commit history since the last tag, propose the next SemVer and justify why.


Last tag:
!{git describe --tags --abbrev=0}


Commits since last tag (no merges):
!{git log --pretty='%s' --no-merges $(git describe --tags --abbrev=0)..HEAD}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
{
  "args": [
    {
      "id": "$1",
      "name": "last_tag",
      "hint": "The last Git tag to compare against",
      "example": "v1.2.3",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+$"
    },
    {
      "id": "$2",
      "name": "commit_history",
      "hint": "The commit history since the last tag",
      "example": "feat: add new feature\nfix: fix bug",
      "required": true,
      "validate": ".+"
    }
  ]
}
