# Migration Plan

## Metadata

- **Identifier**: migration-plan  
- **Categories**: Migration, Database, Schema Change  
- **Lifecycle Stage**: Preparation → Execution → Failure Recovery  
- **Dependencies**: none  
- **Provided Artifacts**: Plan, SQL, Rollback, Checks  
- **Summary**: Do migrate schema safely with rollback to achieve data integrity.

## Inputs

- Trigger: `/migration-plan "<change summary>"`  
- Purpose: Produce safe up/down migration steps with checks and rollback notes.  
- Steps: Describe current vs target schema, include data volume and lock risk; deploy empty columns, backfill, dual-write, cutover, cleanup.  
- Output format: `Plan`, `SQL`, `Rollback`, `Checks` sections.  
- Examples: `/migration-plan "orders add status enum"`  
- Notes: Include online migration strategies for large tables.

## Canonical taxonomy (exact strings)

- Migration
- Database
- Schema Change
- Rollback

### Stage hints (for inference)

- Plan → Preparation  
- Deploy → Execution  
- Rollback → Failure Recovery  

## Algorithm

1. Extract signals from the input text:  
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:  
   - Prefer explicit input; otherwise infer from main action + object.  
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   - De-duplicate.

3. Determine categories:  
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   - Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional):  
   - Prefer explicit input; otherwise map categories via stage hints.  
   - Omit if uncertain.

5. Determine dependencies (optional):  
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  

6. Determine provided artifacts (optional):  
   - Short list (≤3) of unlocked outputs.

7. Compose summary:  
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format:  
   - Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:  
   - Merge: explicit inputs > existing > inferred.  
   - Validate lists; move unknowns to an extension field if needed.  
   - Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤ 7.
- Output format must match canonical taxonomy and stage mapping.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).  
- Categories non-empty and drawn from canonical taxonomy (≤3).  
- Stage, if present, is one of the allowed stages implied by stage hints.  
- Dependencies, if present, are id-shaped (≤5).  
- Provided artifacts ≤ 4 (within limit).  
- Summary ≤120 chars; punctuation coherent.  
- Body text is not altered.

## Output format examples

- Input: `/migration-plan "orders add status enum"`  
  → Output: Plan, SQL, Rollback, Checks sections with rollback flag and data volume analysis.  

- Input: `/migration-plan "users add timezone field"`  
  → Output: Similar structure, with schema comparison and online strategy note.

# Migration Plan

Trigger: /migration-plan "<change summary>"

Purpose: Produce safe up/down migration steps with checks and rollback notes.

**Steps:**

1. Describe current vs target schema, include data volume and lock risk.
2. Plan: deploy empty columns, backfill, dual-write, cutover, cleanup.
3. Provide SQL snippets and PR checklist. Add `can_rollback: true|false` flag.

**Output format:** `Plan`, `SQL`, `Rollback`, `Checks` sections.

**Examples:** `/migration-plan "orders add status enum"`.

**Notes:** Include online migration strategies for large tables.
