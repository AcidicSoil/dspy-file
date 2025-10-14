description = "Plan safe dependency updates and grouping."
prompt = """
From the manifests and lockfiles, propose grouped upgrade batches, testing strategy, and rollback plan.


@{$1}
@{$2}
@{$3}
@{$4}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "package_json_path",
      "hint": "Path to the package.json file in the project root",
      "example": "package.json",
      "required": true,
      "validate": "^[^/]+\\.json$"
    },
    {
      "id": "$2",
      "name": "package_lock_json_path",
      "hint": "Path to the package-lock.json file in the project root",
      "example": "package-lock.json",
      "required": true,
      "validate": "^[^/]+\\.json$"
    },
    {
      "id": "$3",
      "name": "pnpm_lock_yaml_path",
      "hint": "Path to the pnpm-lock.yaml file in the project root",
      "example": "pnpm-lock.yaml",
      "required": true,
      "validate": "^[^/]+\\.yaml$"
    },
    {
      "id": "$4",
      "name": "yarn_lock_path",
      "hint": "Path to the yarn.lock file in the project root",
      "example": "yarn.lock",
      "required": true,
      "validate": "^[^/]+\\.lock$"
    }
  ]
}
