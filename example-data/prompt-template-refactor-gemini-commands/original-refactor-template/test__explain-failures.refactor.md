```
description = "Analyze recent test failures and propose fixes."
prompt = """
From the following logs, identify root causes and propose concrete fixes.


Recent test output (if present):
!{ls -1 test-results 2>/dev/null || echo 'no test-results/ directory'}
!{find . -maxdepth 2 -name 'junit*.xml' -o -name 'TEST-*.xml' -o -name 'last-test.log' -print -exec tail -n 200 {} \\; 2>/dev/null}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
