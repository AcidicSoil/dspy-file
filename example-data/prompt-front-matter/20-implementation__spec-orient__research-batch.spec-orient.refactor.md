# Research-Batch Workflow

## Metadata

- **Identifier**: research-batch
- **Categories**:
  - Batch Processing
  - Research Workflow
  - Contextual Continuity
- **Lifecycle Stage**: Process
- **Dependencies**: []
- **Provided Artifacts**:
  - Per-item output with status and conversation updates
  - Roll-up summary including per-item status, enabled decisions, unresolved risks, and domain-type source count
- **Summary**: Do batch-process research objectives with carry-forward context to achieve a roll-up summary of statuses, decisions, and risks.

## Inputs

- Trigger: `/research-batch`
- Input format: A numbered list of work-breakdown objectives (e.g., `1) Validate Next.js 15 stability. 2) Compare Bun vs Node for CI.`)
- Context: Carry-forward conversation state across items; pre-load ≤5 bullets before first item.

## Canonical taxonomy (exact strings)

- Batch Processing
- Research Workflow
- Contextual Continuity

### Stage hints (for inference)

- Process → sequential execution with inputs, outputs, and roll-up
- Analyze → for evaluation or decision-making
- Generate → output creation
- Query → data retrieval or micro-interaction

## Algorithm

1. Extract signals from the input:
   - Titles/headings: "Conversation-Aware Research — Batch WBRO"
   - Imperative verbs: "Process", "Parse", "Execute", "Emit"
   - Explicit tags: Trigger `/research-batch`, output format, examples
   - Dependency phrasing: “if blocked by prior gaps”

2. Determine the primary identifier:
   - Prefer explicit input → trigger `/research-batch`
   - Normalize to lowercase kebab-case → `research-batch`

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs and structure
   - Final list: Batch Processing, Research Workflow, Contextual Continuity

4. Determine lifecycle/stage (optional):
   - Map via stage hints: "Process" fits best due to sequential execution with inputs/outputs

5. Determine dependencies (optional):
   - No explicit id-shaped dependencies; context is carried forward but not named
   - Omit as no specific dependency IDs are provided

6. Determine provided artifacts:
   - Per-item output with status and conversation updates
   - Final roll-up summary with per-item status, decisions, risks, domain-type source count

7. Compose summary:
   - One sentence: "Do batch-process research objectives with carry-forward context to achieve a roll-up summary of statuses, decisions, and risks."

8. Produce metadata in the requested format:
   - Human-readable key-value structure; all fields validated.

9. Reconcile if input already contains metadata:
   - No embedded metadata found → use inferred values only

## Assumptions & Constraints

- Emit exactly one document: metadata block, blank line, then original body unchanged.
- Limit distinct placeholders to ≤7 (used: 7).
- All artifacts and categories are derived from content; no external assumptions.

## Validation

- Identifier matches normalized pattern (`research-batch`)
- Categories non-empty and drawn from canonical taxonomy (≤3)
- Stage present and valid per stage hints
- Dependencies empty but logically consistent with context carry-forward
- Provided artifacts ≤3, clearly defined
- Summary ≤120 characters; punctuation coherent
- Original body is preserved exactly

## Output format examples

- Input: `/research-batch 1) Validate Next.js 15 stability. 2) Compare Bun vs Node for CI. 3) Licensing risks for MIT vs Apache-2.0.`
- Output:
  - Per-item sections (each with status, conversation update)
  - Final roll-up summary:
    ```
    ## Roll-up Summary
    - Item 1: Completed — decision enabled: yes; risks: low
    - Item 2: In Progress — decision enabled: no; risks: medium
    - Item 3: Blocked — decision enabled: no; risks: high
    - Sources by domain type: gov, org, docs, blog, news
    ```
