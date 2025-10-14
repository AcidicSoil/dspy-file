description = "Update CHANGELOG.md on each merge with concise, user-facing entries under Added, Changed, Deprecated, Removed, Fixed, and Security."
prompt = """

Research authoritative standards and examples for maintaining a project's CHANGELOG.md that is updated on each merge and organized strictly under the headings "$1", "$2", "$3", "$4", "$5", and "$6". Identify best-practice formatting and tone for concise, user-facing entries; clear definitions of what belongs in each category (and what to omit as internal-only changes); norms for grouping entries by release/version when changes land via merge; and conventions for mapping commits/PRs to changelog lines. Prioritize primary standards (e.g., Keep a Changelog, Semantic Versioning), official documentation, and reputable engineering blogs or public project release notes that use this section schema. Extract brief quoted examples with context, include publication dates and direct URLs for every claim, highlight any conflicting guidance between sources, and synthesize a short, actionable rule set aligned to these six sections with required citations.

"""

{
  "args": [
    {
      "id": "$1",
      "name": "Added",
      "hint": "New features or functionality",
      "example": "Added support for OAuth2 authentication",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    },
    {
      "id": "$2",
      "name": "Changed",
      "hint": "Modifications to existing functionality",
      "example": "Changed default timeout from 30s to 60s",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    },
    {
      "id": "$3",
      "name": "Deprecated",
      "hint": "Functionality marked for removal",
      "example": "Deprecated legacy API endpoints",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    },
    {
      "id": "$4",
      "name": "Removed",
      "hint": "Functionality removed entirely",
      "example": "Removed support for legacy browsers",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    },
    {
      "id": "$5",
      "name": "Fixed",
      "hint": "Bug fixes or corrections",
      "example": "Fixed memory leak in data processing pipeline",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    },
    {
      "id": "$6",
      "name": "Security",
      "hint": "Security-related updates",
      "example": "Fixed vulnerability in JWT token handling",
      "required": true,
      "validate": "^[A-Z][a-z]+.*$"
    }
  ]
}
