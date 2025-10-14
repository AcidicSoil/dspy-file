```toml
description = "Analyze recent test failures and propose fixes."
prompt = """
From the following logs, identify root causes and propose concrete fixes.


Recent test output (if present):
!{ls -1 $1 2>/dev/null || echo 'no $1/ directory'}
!{find . -maxdepth 2 -name '$2' -o -name '$3' -o -name '$4' -print -exec tail -n $5 {} \\; 2>/dev/null}
"""
```
```json
{
  "args": [
    {
      "id": "$1",
      "name": "test_results_dir",
      "hint": "Directory containing test results",
      "example": "test-results",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.]+$"
    },
    {
      "id": "$2",
      "name": "junit_pattern",
      "hint": "Pattern for junit XML files",
      "example": "junit*.xml",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.]+$"
    },
    {
      "id": "$3",
      "name": "test_xml_pattern",
      "hint": "Pattern for TEST XML files",
      "example": "TEST-*.xml",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.]+$"
    },
    {
      "id": "$4",
      "name": "last_test_log",
      "hint": "Name of last test log file",
      "example": "last-test.log",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.]+$"
    },
    {
      "id": "$5",
      "name": "tail_lines",
      "hint": "Number of lines to tail from each log file",
      "example": "200",
      "required": true,
      "validate": "^\\d+$"
    }
  ]
}
```
