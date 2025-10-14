```
description = "Review ESLint config and suggest rule tweaks."
prompt = """
Explain key rules, missing plugins, and performance considerations.


@{$1}
@{$2}
@{$3}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
{
  "args": [
    {
      "id": "$1",
      "name": "eslintrc_cjs_path",
      "hint": "Path to ESLint config file (.eslintrc.cjs)",
      "example": ".eslintrc.cjs",
      "required": true,
      "validate": "^[^\\s]+$"
    },
    {
      "id": "$2",
      "name": "eslintrc_js_path",
      "hint": "Path to ESLint config file (.eslintrc.js)",
      "example": ".eslintrc.js",
      "required": true,
      "validate": "^[^\\s]+$"
    },
    {
      "id": "$3",
      "name": "package_json_path",
      "hint": "Path to package.json file",
      "example": "package.json",
      "required": true,
      "validate": "^[^\\s]+$"
    }
  ]
}
