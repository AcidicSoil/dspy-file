description = "Update CHANGELOG.md on each merge with concise, user-facing entries under Added, Changed, Deprecated, Removed, Fixed, and Security."
prompt = """

Research authoritative standards and examples for maintaining a project's CHANGELOG.md that is updated on each merge and organized strictly under the headings "$1". Identify best-practice formatting and tone for concise, user-facing entries; clear definitions of what belongs in each category (and what to omit as internal-only changes); norms for grouping entries by release/version when changes land via merge; and conventions for mapping commits/PRs to changelog lines. Prioritize primary standards ($2, $3), official documentation, and reputable engineering blogs or public project release notes that use this section schema. Extract brief quoted examples with context, include publication dates and direct URLs for every claim, highlight any conflicting guidance between sources, and synthesize a short, actionable rule set aligned to these six sections with required citations.

"""
