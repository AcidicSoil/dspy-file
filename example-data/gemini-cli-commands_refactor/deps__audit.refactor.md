description = "Summarize dependency risks and remediation steps."
prompt = """
Review the audit outputs (if available) and propose prioritized fixes. Prefer minimal upgrades.


npm/pnpm/yarn audit (if present):
!{(npm audit --json || true) 2>/dev/null}
!{(pnpm audit --json || true) 2>/dev/null}
!{(yarn npm audit --json || yarn audit --json || true) 2>/dev/null}


Manifests:
@{package.json}
@{package-lock.json}
@{pnpm-lock.yaml}
@{yarn.lock}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
