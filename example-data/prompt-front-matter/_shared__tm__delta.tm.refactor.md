# PRD → Tasks Delta

## Metadata

- **identifier**: prd-delta
- **categories**: 
  - delta
  - task comparison
  - prds
- **lifecycle_stage**: analyze
- **dependencies**: 
  - prd_content
  - tasks_json
- **provided_artifacts**: 
  - delta_summary_table
  - json_patch_operations
  - assumptions_open_questions
- **summary**: Compare a PRD to tasks.json and propose add/update/remove operations.

## Inputs

- PRD content (text or path like ./prd.txt)
- Existing tasks.json file path

## Canonical taxonomy (exact strings)

- delta
- task comparison
- prds
- analysis
- automation
- update
- generate

### Stage hints (for inference)

- analyze → input parsing, objective extraction, mapping
- compare → fuzzy matching, gap detection
- propose → output generation: adds/updates/removals

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
- Output must be minimal and reversible; destructive changes flagged explicitly.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: analyze, compare, propose.
- Dependencies, if present, are id-shaped (e.g., prd_content, tasks_json) — ≤5.
- Provided artifacts ≤3 and match known outputs.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- Input: /tm-delta ./prd.txt  
  Output:
    # Delta Summary
    | Type     | Task Title               |
    |----------|--------------------------|
    | Add      | Implement user onboarding flow |
    | Update   | Rename milestone to v1.0 |
    | Remove   | Deprecated legacy feature |

    ## JSON Patch
    - add: { "id": "task-456", "title": "Implement user onboarding flow" }
    - replace: { "id": "task-789", "priority": "high" }
    - remove: { "id": "task-012" }

    ## Assumptions
    - PRD is up-to-date and reflects current priorities.
    
    ## Open Questions
    - How should ambiguous deliverables be resolved?

---

# PRD → Tasks Delta

Trigger: /tm-delta

Purpose: Compare a PRD text against tasks.json and propose add/update/remove operations.

Steps:

1. Accept PRD content pasted by the user or a path like ./prd.txt. If absent, output a short template asking for PRD input.
2. Extract objectives, constraints, deliverables, and milestones from the PRD.
3. Map them to existing tasks by fuzzy match on title and keywords; detect gaps.
4. Propose: new tasks, updates to titles/descriptions/priority, and deprecations.

Output format:

- "# Delta Summary"
- Tables: adds | updates | removals.
- "## JSON Patch" with an ordered list of operations: add/replace/remove.
- "## Assumptions" and "## Open Questions".

Examples:

- Input: /tm-delta ./prd.txt
- Output: tables with a small JSON Patch block.

Notes:

- Keep patches minimal and reversible. Flag any destructive changes explicitly.
