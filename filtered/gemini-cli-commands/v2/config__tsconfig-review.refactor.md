```
description = "Review tsconfig for correctness and DX."
prompt = """
Provide recommendations for module/target, strictness, paths, incremental builds.


@$1
"""
```

{
  "args": [
    {
      "id": "$1",
      "name": "tsconfig_file",
      "hint": "Path to the tsconfig.json file to review",
      "example": "tsconfig.json",
      "required": true,
      "validate": "^[^\\s]+$"
    }
  ]
}
