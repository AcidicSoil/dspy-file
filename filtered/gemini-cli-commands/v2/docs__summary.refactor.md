```toml
description = "Produce a README‑level summary of the repo."
prompt = """
Generate a high‑level summary (What, Why, How, Getting Started).

Repo map (first $2 files):
!{git ls-files | sed -n '1,$2p'}

Key docs if present:
@$3
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
{
  "args": [
    {
      "id": "$1",
      "name": "repo_path",
      "hint": "Path to the repository root",
      "example": "./my-repo",
      "required": true,
      "validate": "^[a-zA-Z0-9._/-]+$"
    },
    {
      "id": "$2",
      "name": "file_count",
      "hint": "Number of files to include in the repo map",
      "example": "400",
      "required": false,
      "validate": "^\\d+$"
    },
    {
      "id": "$3",
      "name": "key_docs",
      "hint": "Key documentation paths (README.md and docs directory)",
      "example": "@{README.md} @{docs}",
      "required": true,
      "validate": "^@[a-zA-Z0-9._/\\-]+$"
    }
  ]
}
