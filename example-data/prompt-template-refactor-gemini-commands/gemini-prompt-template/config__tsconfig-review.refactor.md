description = "Review tsconfig for correctness and DX."
prompt = """
Provide recommendations for module/target, strictness, paths, incremental builds.


@{$1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "tsconfig_json_path",
      "hint": "Path to the tsconfig.json file to be reviewed",
      "example": "./src/tsconfig.json",
      "required": true,
      "validate": "^\\S+\\.json$"
    }
  ]
}
