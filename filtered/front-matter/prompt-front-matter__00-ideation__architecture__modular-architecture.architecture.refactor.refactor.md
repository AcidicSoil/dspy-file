```md
# Modular Architecture

## Metadata

- **identifier**: {{identifier}}  
- **categories**: {{categories}}  
- **stage**: {{stage}}  
- **dependencies**: [{{dependencies}}]  
- **provided-artifacts**: [{{provided_artifacts}}]  
- **summary**: {{summary}}

## Steps

1. Identify services/modules and their public contracts.
2. Flag cross-module imports and circular deps.
3. Propose boundaries, facades, and internal folders.
4. Add "contract tests" for public APIs.

## Output format

- Diagram-ready list of modules and edges, plus diffs.
```
