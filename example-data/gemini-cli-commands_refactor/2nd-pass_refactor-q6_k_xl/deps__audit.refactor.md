description = "Summarize dependency risks and remediation steps."
prompt = """
Review the audit outputs (if available) and propose prioritized fixes. Prefer minimal upgrades.


npm/pnpm/yarn audit (if present):
!{(audit_output || true) 2>/dev/null}


Manifests:
@{$1}
@{$1}
@{$1}
@{$1}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
