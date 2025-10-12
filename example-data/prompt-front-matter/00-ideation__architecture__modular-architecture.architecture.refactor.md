# Modular Architecture

## Metadata

- **identifier**: modular-architecture  
- **categories**: architecture  
- **stage**: design  
- **dependencies**: [module-boundaries-identification]  
- **provided-artifacts**: [module-graph, dependency-diff, contract-test-plan]  
- **summary**: Do modularize services to achieve clear boundaries and testable interfaces.

## Steps

1. Identify services/modules and their public contracts.
2. Flag cross-module imports and circular deps.
3. Propose boundaries, facades, and internal folders.
4. Add "contract tests" for public APIs.

## Output format

- Diagram-ready list of modules and edges, plus diffs.
