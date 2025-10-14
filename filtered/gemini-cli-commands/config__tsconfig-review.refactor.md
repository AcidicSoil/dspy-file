```toml
description = "Review tsconfig for correctness and DX."
prompt = """
Provide recommendations for module/target, strictness, paths, incremental builds.


@{$1}
"""
```
{
  "args": [
    {
      "id": "$1",
      "name": "tsconfig_path",
      "hint": "Path to the tsconfig.json file",
      "example": "tsconfig.json",
      "required": true,
      "validate": "^[^\\s]+$"
    }
  ]
}
