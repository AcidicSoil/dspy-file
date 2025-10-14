```
description = "Audit repository hygiene and suggest improvements."
prompt = """
Assess repo hygiene: docs, tests, CI, linting, security. Provide a prioritized checklist.


Top‑level listing:
!{ls -la}


Common config files (if present):
@{$2}
@{$3}
@{$4}
@{$5}
@{$6}
@{$7}
@{$8}
@{$9}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
