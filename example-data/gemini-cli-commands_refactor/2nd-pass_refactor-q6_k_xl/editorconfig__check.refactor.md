description = "Check adherence to .editorconfig across the repo."
prompt = """
From the listing and config, point out inconsistencies and propose fixes.


@{$2}
!{$1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "file_list",
      "hint": "List of files to check for .editorconfig compliance, generated via git ls-files",
      "example": "src/, tests/, lib/",
      "required": true,
      "validate": "^\\S+(,\\s*\\S+)*$"
    },
    {
      "id": "$2",
      "name": "editorconfig_content",
      "hint": "The .editorconfig file content to validate against the file list",
      "example": "root = true\n[*] indent_style = space\n[*] end_of_line = lf",
      "required": true,
      "validate": "^\\s*\\[.*\\]\\s*\\n\\s*\\w+\\s*=\\s*\\w+\\s*\\n*\\s*$"
    }
  ]
}
