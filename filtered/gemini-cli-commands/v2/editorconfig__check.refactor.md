description = "Check adherence to .editorconfig across the repo."
prompt = """
From the listing and config, point out inconsistencies and propose fixes.


@{$1}
!{git ls-files | sed -n '1,$2p'}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "editorconfig_file",
      "hint": "Path to the .editorconfig file",
      "example": ".editorconfig",
      "required": true,
      "validate": "^[^\\s]+$"
    },
    {
      "id": "$2",
      "name": "max_files",
      "hint": "Maximum number of files to process",
      "example": "400",
      "required": true,
      "validate": "^\\d+$"
    }
  ]
}
