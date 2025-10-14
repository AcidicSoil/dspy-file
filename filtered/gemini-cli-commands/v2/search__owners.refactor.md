description = "Suggest likely owners/reviewers for a path."
prompt = """
Based on CODEOWNERS and git history, suggest owners.


CODEOWNERS (if present):
@{$2}


Recent authors for the path:
!{git log --pretty='- %an %ae: %s' -- $1 | sed -n '1,50p'}
"""

```json
{
  "args": [
    {
      "id": "$1",
      "name": "path",
      "hint": "Path to analyze for owners",
      "example": "src/main.py",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "codeowners_path",
      "hint": "Path to CODEOWNERS file",
      "example": ".github/CODEOWNERS",
      "required": false,
      "validate": ".*"
    }
  ]
}
```
