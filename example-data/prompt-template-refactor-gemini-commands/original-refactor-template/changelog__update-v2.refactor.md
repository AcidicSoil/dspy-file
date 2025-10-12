<!-- $1=primary standards or frameworks (e.g., Keep a Changelog, Semantic Versioning), $2=specific examples with context and citation details, $3=definitions of what belongs in each changelog category, $4=norms for version grouping when changes land via merge, $5=conventions for mapping commits/PRs to changelog lines, $6=conflicting guidance between sources (if any), $7=actionable rule set synthesized from research -->
**Changelog Best Practices Analysis**

Research authoritative standards and examples for maintaining a project's CHANGELOG.md that is updated on each merge and organized strictly under the headings "Added", "Changed", "Deprecated", "Removed", "Fixed", and "Security". Identify best-practice formatting and tone for concise, user-facing entries; clear definitions of what belongs in each category (and what to omit as internal-only changes); norms for grouping entries by release/version when changes land via merge; and conventions for mapping commits/PRs to changelog lines. Prioritize primary standards ($1), official documentation, and reputable engineering blogs or public project release notes that use this section schema. Extract brief quoted examples with context, include publication dates and direct URLs for every claim, highlight any conflicting guidance between sources ($6), and synthesize a short, actionable rule set aligned to these six sections with required citations ($7).

**Output format**
- List each category (Added, Changed, Deprecated, Removed, Fixed, Security) with one concise entry per change.
- Each entry must be user-facing and avoid internal/implementation details.
- Provide definitions of what qualifies for each section in a brief table or bullet list ($3).
- Include at least one cited example from an authoritative source ($2), including date and URL.
- State how version groupings are determined when changes land via merge ($4).
- Specify the process for linking commits or PRs to changelog lines ($5).
- If conflicting guidance exists between sources, explicitly note it ($6).
- End with a synthesized rule set that developers can follow directly ($7).
