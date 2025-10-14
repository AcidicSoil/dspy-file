# Reference Implementation

## Metadata

- **Identifier**: reference-implementation
- **Categories**: code-generation, api-mapping, diff-generation
- **Lifecycle Stage**: implementation
- **Dependencies**: target-module-path, example-url
- **Provided Artifacts**: side-by-side API table, patch suggestions
- **Summary**: Do map target module's API to reference to achieve consistent structure and naming.

## Steps

1. Accept a path or URL to an example. Extract its public API and patterns.
2. Map target module’s API to the reference.
3. Generate diffs that adopt the same structure and naming.

## Output format

- Side-by-side API table and patch suggestions.
