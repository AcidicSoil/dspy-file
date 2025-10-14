# Prototype Feature

Trigger: $1

Purpose: $2

## Steps

$3

## Output format

- $4

{
  "args": [
    {
      "id": "$1",
      "name": "trigger",
      "hint": "The trigger for the feature",
      "example": "on new commit",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "purpose",
      "hint": "The purpose of the feature",
      "example": "automate deployment",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$3",
      "name": "steps",
      "hint": "The steps to execute the feature",
      "example": "build, test, deploy",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$4",
      "name": "output_format",
      "hint": "The format of the output",
      "example": "JSON or YAML",
      "required": true,
      "validate": ".*"
    }
  ]
}
