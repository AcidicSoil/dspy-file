<!-- Placeholder mapping (semantics) -->

$1 = Command syntax (e.g., `/openapi-generate server js spec.yaml`)
$2 = Target (server/client)
$3 = Language (e.g., ts, js)
$4 = OpenAPI spec path
$5 = Output directory for server (e.g., `apps/api`)
$6 = Output directory for client (e.g., `packages/sdk`)
$7 = Specific output format (e.g., "summary table of generated paths, scripts to add, and next actions")

# OpenAPI Generate

Trigger: $1

Purpose: Generate $2 stubs or typed $3 clients from an OpenAPI spec.

**Steps:**

1. Validate $4; fail with actionable errors.
2. For $2, generate controllers, routers, validation, and error middleware into $5.
3. For $3, generate a typed SDK into $6 with fetch wrapper and retry/backoff.
4. Add `make generate-api` or `pnpm sdk:gen` scripts and CI step to verify no drift.
5. Produce a diff summary and TODO list for unimplemented handlers.

**Output format:** $7

**Examples:** `$1 client $3 $4`.

**Notes:** Prefer openapi-typescript + zod for $3 clients when possible.

---

**Affected files**
- $5 (server output)
- $6 (client output)

**Root cause**
- None specified in input

**Proposed fix**
- N/A (implementation details)

**Tests**
- N/A (implementation details)

**Docs gaps**
- None specified in input

**Open questions**
- None specified in input
