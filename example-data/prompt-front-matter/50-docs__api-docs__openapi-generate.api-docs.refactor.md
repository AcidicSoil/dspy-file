# OpenAPI Generate

## Metadata

- **Identifier**: generate-api  
- **Categories**: code generation, api scaffolding, build  
- **Stage**: build  
- **Dependencies**: none  
- **Provided Artifacts**: 
  - Summary table of generated paths  
  - Scripts to add (e.g., `make generate-api`, `pnpm sdk:gen`)  
  - TODO list for unimplemented handlers  
- **Summary**: Generate server stubs or typed clients from an OpenAPI spec to achieve code scaffolding with validation and CI checks.

## Inputs

- Command: `/openapi-generate <server|client> <lang> <spec-path>`
- Parameters:
  - `<server>`: Generates controllers, routers, validation, and error middleware into `apps/api`
  - `<client>`: Generates a typed SDK into `packages/sdk` with fetch wrapper and retry/backoff
  - `<spec-path>`: Path to OpenAPI spec (e.g., `apis/auth/openapi.yaml`)
- Output format: Summary table of generated paths, scripts to add, and next actions

## Canonical taxonomy (exact strings)

- code generation  
- api scaffolding  
- build  

### Stage hints (for inference)

- generate → build  
- scaffold → build  
- script addition → build  

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.  

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs $5.  
   * Validate, sort deterministically, and de-dupe (≤3).  

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via $6.  
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

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- `/openapi-generate client ts apis/auth/openapi.yaml`
- Output: Summary table of generated paths, scripts to add, and next actions
- Notes: Prefer openapi-typescript + zod for TS clients when possible

---

# OpenAPI Generate

Trigger: /openapi-generate <server|client> <lang> <spec-path>

Purpose: Generate server stubs or typed clients from an OpenAPI spec.

**Steps:**

1. Validate `<spec-path>`; fail with actionable errors.
2. For `server`, generate controllers, routers, validation, and error middleware into `apps/api`.
3. For `client`, generate a typed SDK into `packages/sdk` with fetch wrapper and retry/backoff.
4. Add `make generate-api` or `pnpm sdk:gen` scripts and CI step to verify no drift.
5. Produce a diff summary and TODO list for unimplemented handlers.

**Output format:** summary table of generated paths, scripts to add, and next actions.

**Examples:** `/openapi-generate client ts apis/auth/openapi.yaml`.

**Notes:** Prefer openapi-typescript + zod for TS clients when possible.
