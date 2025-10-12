description = "Audit repository hygiene and suggest improvements."
prompt = """
Assess repo hygiene: docs, tests, CI, linting, security. Provide a prioritized checklist.


Top‑level listing:
!{ls -la}


Common config files (if present):
@{.editorconfig}
@{.gitignore}
@{.geminiignore}
@{.eslintrc.cjs}
@{.eslintrc.js}
@{tsconfig.json}
@{pyproject.toml}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
