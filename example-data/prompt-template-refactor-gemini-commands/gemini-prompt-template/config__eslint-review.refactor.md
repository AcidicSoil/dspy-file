description = "Review ESLint config and suggest rule tweaks."
prompt = """
Explain key rules, missing plugins, and performance considerations.


@{$1}
@{$2}
@{$3}
"""

{
  "args": [
    {
      "id": "$1",
      "name": ".eslintrc.cjs",
      "hint": "Path to the ESLint configuration file in CommonJS format.",
      "example": "./.eslintrc.cjs",
      "required": true,
      "validate": "^\\.\\./?\\w+\\.(cjs|js)$"
    },
    {
      "id": "$2",
      "name": ".eslintrc.js",
      "hint": "Path to the ESLint configuration file in JavaScript format.",
      "example": "./.eslintrc.js",
      "required": true,
      "validate": "^\\.\\./?\\w+\\.(js|cjs)$"
    },
    {
      "id": "$3",
      "name": "package.json",
      "hint": "Path to the project's package.json file containing dependencies and plugins.",
      "example": "./package.json",
      "required": true,
      "validate": "^\\.\\./?\\w+\\.json$"
    }
  ]
}
