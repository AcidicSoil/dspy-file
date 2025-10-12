# Rank Root Prompts Command

## Metadata

- **identifier**: rank-root-prompts
- **categories**:
  - prompt-ranking
  - project-context-analysis
  - relevance-scoring
- **lifecycle_stage**: execution
- **dependencies**:
  - {{query}}
  - {{project_path}}
  - {{prompt_path}}
  - {{threshold}}
- **provided_artifacts**:
  - markdown table with columns: filename | description | match_score (sorted by score desc, filtered by threshold)
  - fallback message when no prompts meet threshold
- **summary**: Do rank prompt files based on query and project context to achieve a filtered, scored list of relevant prompts.

## Inputs

- {{query}}: User inquiry to evaluate against available prompts.
- {{project_path}}: Path to the software project (defaults to current directory if missing).
- {{prompt_path}}: Directory containing candidate prompt files (defaults to ~/.codex/prompts if missing).
- {{threshold}}: Minimum relevance score required for inclusion in output.

## Canonical taxonomy (exact strings)

- prompt-ranking
- project-context-analysis
- relevance-scoring

### Stage hints (for inference)

- execution → workflow-driven, ends with output generation
- analysis → involves scanning and summarizing context or content
- evaluation → scoring based on alignment metrics

## Algorithm

1. Extract signals from the input text:
   - Titles/headings: "Command", "Usage", "Args", "Task", "Rules"
   - Imperative verbs: "Analyze", "Scan", "Evaluate", "Rank", "Generate"
   - Explicit tags: `{{query}}`, `{{project_path}}`, etc.
   - Dependency phrasing: "If missing, use...", "Only include if..."

2. Determine the primary identifier:
   - Inferred from command name and context → "rank-root-prompts"
   - Normalized to lowercase kebab-case → "rank-root-prompts"

3. Determine categories:
   - Explicitly listed in workflow: prompt-ranking, project-context-analysis, relevance-scoring
   - Validated against canonical taxonomy

4. Determine lifecycle/stage:
   - Workflow is sequential and ends with output → "execution"
   - Matches stage hint from execution context

5. Determine dependencies:
   - Extracted directly from input placeholders and default rules
   - All are id-shaped (strings) and ≤ 5

6. Determine provided artifacts:
   - Primary: markdown table with filename, description, match_score
   - Secondary: fallback message when no matches exceed threshold

7. Compose summary:
   - One sentence capturing action, object, outcome → "Do rank prompt files based on query and project context to achieve a filtered, scored list of relevant prompts."

8. Produce metadata in structured format:
   - Uses human-readable key-value pairs with consistent naming
   - All fields are derived from explicit or inferable signals

9. Reconcile if input already contains metadata:
   - No existing metadata found; all values inferred from content and structure
   - Final metadata is fully validated against constraints

## Assumptions & Constraints

- Only one document output: metadata block, blank line, then original prompt body.
- Maximum of 7 placeholders used (only 4 distinct input variables are active).
- All categories drawn exactly from canonical taxonomy.
- Stage inferred and matches known stage hints.

## Validation

- Identifier: "rank-root-prompts" → normalized kebab-case, starts with letter → valid
- Categories: non-empty, ≤3, all in canonical list → valid
- Lifecycle stage: "execution" → allowed by stage hints → valid
- Dependencies: 4 items, all id-shaped (strings), ≤5 → valid
- Provided artifacts: exactly two, both defined and referenced → valid
- Summary: ≤120 characters, coherent punctuation → valid
- Body unchanged → preserved as-is

## Output format examples

* **Preferred**: 
```
| filename | description | match_score |
|----------|-------------|-------------|
| debug-prompt.md | This prompt helps debug runtime errors in Python apps. | 0.92 |
| refactor-suggestions.md | Suggests code refactoring for performance issues. | 0.85 |
```

* **Fallback**:
" No prompt exceeds threshold 0.7 — recommend creating a new prompt."
```
