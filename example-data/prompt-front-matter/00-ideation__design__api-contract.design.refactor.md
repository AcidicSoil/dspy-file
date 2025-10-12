# API Contract Design

## Inputs
- Feature or domain string (e.g., "accounts & auth")
- Existing documentation and requirements
- Preference for OpenAPI 3.1 or GraphQL SDL

## Canonical taxonomy (exact strings)
- design
- specification
- contract generation

### Stage hints (for inference)
- design → initial creation of a contract from inputs
- specification → detailed schema definition
- implementation → code generation phase

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
- All categories must be from the canonical taxonomy.
- Stage mapping is deterministic and context-aware.

## Validation
- Identifier matches a normalized id pattern (e.g., api-contract).
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Dependencies must be explicit or inferable from input structure.
- Artifacts list ≤3 items; all valid outputs.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: `api-contract`  
- Categories: design, specification, contract generation  
- Stage: design  
- Dependencies: feature/domain input, existing documentation  
- Artifacts: openapi.yaml, schema.graphql, changelog entry  
- Summary: "Do generate an API contract from requirements to achieve a standardized specification for endpoints."

---

# API Contract

Trigger: /api-contract "<feature or domain>"

Purpose: Author an initial OpenAPI 3.1 or GraphQL SDL contract from requirements.

**Steps:**

1. Parse inputs and existing docs. If REST, prefer OpenAPI 3.1 YAML; if GraphQL, produce SDL.
2. Define resources, operations, request/response schemas, error model, auth, and rate limit headers.
3. Add examples for each endpoint or type. Include pagination and filtering conventions.
4. Save to `apis/<domain>/openapi.yaml` or `apis/<domain>/schema.graphql`.
5. Emit changelog entry `docs/api/CHANGELOG.md` with rationale and breaking-change flags.

**Output format:**

- `Contract Path`, `Design Notes`, and a fenced code block with the spec body.

**Examples:**

- `/api-contract "accounts & auth"` → `apis/auth/openapi.yaml` with OAuth 2.1 flows.

**Notes:**

- Follow JSON:API style for REST unless caller specifies otherwise. Include `429` and `5xx` models.
