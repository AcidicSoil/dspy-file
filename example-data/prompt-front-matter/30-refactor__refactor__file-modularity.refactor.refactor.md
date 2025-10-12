# File Modularity

## Metadata

- **Identifier**: file-modularity
- **Categories**: refactoring, modularity, code-splitting
- **Lifecycle Stage**: analysis
- **Dependencies**: []
- **Provided Artifacts**: refactor plan with patches for file splits
- **Summary**: Do refactor large files into smaller modular components to achieve improved maintainability and readability.

## Steps

1. Find files over thresholds (e.g., >500 lines).
2. Suggest extraction targets: components, hooks, utilities, schemas.
3. Provide before/after examples and import updates.

## Output format

- Refactor plan with patches for file splits.
