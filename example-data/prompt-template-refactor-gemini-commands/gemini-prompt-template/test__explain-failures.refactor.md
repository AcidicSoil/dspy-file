description = "Analyze recent test failures and propose fixes."
prompt = """
From the following logs, identify root causes and propose concrete fixes.


Recent test output (if present):
!$1
!$2

"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "test_results_directory_output",
      "hint": "Output of 'ls -1 test-results' or 'no test-results/ directory' if not found",
      "example": "test-001.txt\ntest-002.txt",
      "required": true,
      "validate": "^\\s*\\n?$"
    },
    {
      "id": "$2",
      "name": "recent_test_logs",
      "hint": "Output of 'find' command with tail -n 200 on relevant log files (junit.xml, TEST-*.xml, last-test.log)",
      "example": "ERROR: Failed to connect to DB\nCaused by: Connection timeout\n... (last 200 lines)",
      "required": true,
      "validate": "^\\s*\\n?$"
    }
  ]
}
