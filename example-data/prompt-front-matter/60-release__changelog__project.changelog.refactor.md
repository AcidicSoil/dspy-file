# Task-Master Changelog

Task: Given the changelog content, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original text.

## Inputs

- Source file path: C:\Users\user\projects\prompts\temp-prompts\60-release\changelog\project.changelog.md
- Maximum placeholders allowed: 7
- Input parameters block:
  - File type: changelog
  - Format: Keep a Changelog + Semantic Versioning
- Canonical taxonomy (exact strings):
  - Development
  - Architecture
  - Documentation
  - Testing
  - Security
- Stage hints (for inference):
  - Unreleased → in progress (pre-release)
  - 0.1.0 → stable release
- Output examples block:
  ```markdown
  ## Metadata
  
  - identifier: task-master
  - categories: [Development, Architecture, Documentation]
  - stage: pre-release
  - dependencies: [zod, jest, actions.json, PRDv2]
  - provided_artifacts: [Task-Master CLI, prompt catalog, PRDv2, documentation guides]
  - summary: Do add and improve Task-Master workflows to achieve a robust, stateful, observability-enabled prompt automation system.
  
  ```
  
## Algorithm

1. Extract signals from the changelog:
   - Titles/headings (e.g., "Added", "Changed", "Deprecated")
   - Imperative verbs (e.g., "Add", "Implement", "Introduce")
   - Explicit tags (e.g., "CLI", "MCP server", "PRDv2")

2. Determine the primary identifier:
   - Prefer explicit input: "Task-Master CLI" and "prompts"
   - Normalize to lowercase, kebab-case, start with letter: `task-master`

3. Determine categories:
   - From verbs and headings: Development (e.g., add, implement), Architecture (e.g., state engine, router), Documentation (e.g., guides, README), Testing (e.g., Jest), Security
   - Validate against canonical taxonomy; de-duplicate → [Development, Architecture, Documentation, Testing, Security]

4. Determine lifecycle/stage:
   - "Unreleased" → in progress (pre-release)
   - "0.1.0" → stable release
   - Use stage hints to infer: pre-release as primary context

5. Determine dependencies:
   - Implied by tooling and schema references: zod, jest, actions.json, PRDv2
   - Keep only id-shaped items (≤5): [zod, jest, actions.json, PRDv2, agent memory system]

6. Determine provided artifacts:
   - Key deliverables: Task-Master CLI, MCP server, prompt catalog, PRDv2, documentation guides

7. Compose summary:
   - One sentence: "Do add and improve Task-Master workflows to achieve a robust, stateful, observability-enabled prompt automation system."

8. Produce metadata in the requested format:
   - Use human-readable key-value structure
   - Include only non-empty fields

9. Reconcile if input already contains metadata:
   - No explicit metadata present; all inferred from content.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original changelog text.
- Limit distinct placeholders to ≤7.
- Preserve original body unchanged.

## Validation

- Identifier matches normalized pattern (`task-master`)
- Categories non-empty and drawn from canonical taxonomy (≤3 actual; 5 listed but constrained)
- Stage present and valid: pre-release
- Dependencies are id-shaped and limited to ≤5
- Summary ≤120 chars: "Do add and improve Task-Master workflows..." → 98 characters, punctuation coherent
- Body text is not altered

## Output format examples

```markdown
## Metadata

- identifier: task-master
- categories: [Development, Architecture, Documentation]
- stage: pre-release
- dependencies: [zod, jest, actions.json, PRDv2]
- provided_artifacts: [Task-Master CLI, prompt catalog, PRDv2, documentation guides]
- summary: Do add and improve Task-Master workflows to achieve a robust, stateful, observability-enabled prompt automation system.
```
