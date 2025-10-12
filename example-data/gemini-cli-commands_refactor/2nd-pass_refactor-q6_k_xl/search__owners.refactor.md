description = "Suggest likely owners/reviewers for a path."
prompt = """
Based on CODEOWNERS and git history, suggest owners.


CODEOWNERS (if present):
@{$2}


Recent authors for the path:
!{git log --pretty='- %an %ae: %s' -- {$1} | sed -n '1,50p'}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "path",
      "hint": "The file or directory path for which to suggest owners",
      "example": "src/components/button.tsx",
      "required": true,
      "validate": "^[a-zA-Z0-9/._-]+$"
    },
    {
      "id": "$2",
      "name": "codeowners_path",
      "hint": "Path to the CODEOWNERS file (e.g., .github/CODEOWNERS)",
      "example": ".github/CODEOWNERS",
      "required": true,
      "validate": "^(\\.github/|\\.github\\/)(CODEOWNERS)$"
    }
  ]
}
