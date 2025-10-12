description = "Review tsconfig for correctness and DX."
prompt = """
Provide recommendations for module/target, strictness, paths, incremental builds.


@{ $1 }
"""

{
  "args": [
    {
      "id": "$1",
      "name": "tsconfig_json",
      "hint": "The content of the tsconfig.json file to be reviewed",
      "example": "{\"compilerOptions\": {\"strict\": true}, \"include\": [\"src/**\"]}",
      "required": true,
      "validate": "^\\{.*\\}$"
    }
  ]
}
