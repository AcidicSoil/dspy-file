<!-- Placeholder mapping:
- $1 = command pattern (e.g., "/api-contract")
- $2 = feature/domain input (e.g., "accounts & auth")
- $3 = output path (e.g., "apis/auth/openapi.yaml")
- $4 = changelog path (e.g., "docs/api/CHANGELOG.md")
- $5 = auth type (e.g., "OAuth 2.1")
- $6 = API style convention (e.g., "JSON:API")
- $7 = API convention (e.g., "JSON:API" or "REST")
-->

# API Contract Generator

**Trigger:** $1

**Purpose:** Author an initial OpenAPI 3.1 or GraphQL SDL contract from requirements.

**Steps:**

1. Parse inputs and existing docs. If REST, prefer OpenAPI 3.1 YAML; if GraphQL, produce SDL.
2. Define resources, operations, request/response schemas, error model, auth, and rate limit headers.
3. Add examples for each endpoint or type. Include pagination and filtering conventions.
4. Save to $3.
5. Emit changelog entry $4 with rationale and breaking-change flags.

**Expected Outputs:**
- `Contract Path`: $3
- `Design Notes`: $5

**Prerequisites:** $7

**Output format:**
- Fenced code block with spec body (format: $6)
