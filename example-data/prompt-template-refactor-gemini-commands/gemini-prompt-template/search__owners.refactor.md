description = "Suggest likely owners/reviewers for a path."
prompt = """
Based on CODEOWNERS and git history, suggest owners.


CODEOWNERS (if present):
@{.github/CODEOWNERS}


Recent authors for the path:
!{git log --pretty='- %an %ae: %s' -- $1 | sed -n '1,50p'}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "path",
      "hint": "The file or directory path for which to suggest owners and recent authors.",
      "example": "src/utils/processor.go",
      "required": true,
      "validate": "^\\S+$"
    }
  ]
}
