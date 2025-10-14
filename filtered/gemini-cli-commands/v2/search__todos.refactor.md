description = "Find and group TODO/FIXME annotations."
prompt = """
!{rg -n "$1" -g '$2' $3 || grep -RInE '$1' $3}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "search_pattern",
      "hint": "Pattern to search for (e.g., 'TODO|FIXME')",
      "example": "TODO|FIXME",
      "required": true,
      "validate": "^[A-Za-z0-9_\\|]+$"
    },
    {
      "id": "$2",
      "name": "exclude_pattern",
      "hint": "Exclude pattern (e.g., '!node_modules')",
      "example": "!node_modules",
      "required": true,
      "validate": "^!.*$"
    },
    {
      "id": "$3",
      "name": "root_directory",
      "hint": "Root directory to search in",
      "example": ".",
      "required": true,
      "validate": "^[A-Za-z0-9_\\-\\/\\.]+$"
    }
  ]
}
