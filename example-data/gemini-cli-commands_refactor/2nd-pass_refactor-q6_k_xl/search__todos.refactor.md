description = "Find and group TODO/FIXME annotations."
prompt = """
!{rg -n "TODO|FIXME" -g '!node_modules' $1 || grep -RInE 'TODO|FIXME' $1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "search_root",
      "hint": "Directory path to search for TODO/FIXME annotations (e.g., './src', './docs')",
      "example": "./src",
      "required": true,
      "validate": "^[./\\w\\-\\_\\s\\.]$"
    }
  ]
}
