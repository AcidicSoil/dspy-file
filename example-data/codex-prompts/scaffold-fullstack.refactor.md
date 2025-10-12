```
# Scaffold Full‑Stack App

Trigger: $1

Purpose: Create a minimal, production-ready monorepo template with app, API, tests, CI seeds, and infra stubs.

**Steps:**

1. Read repository context: `git rev-parse --is-inside-work-tree`.
2. If repo is empty, initialize: `git init -b main` and create `.editorconfig`, `.gitignore`, `README.md`.
3. For $1 derive presets (examples):
   - $2: Next.js app, $3 API, $4 + $5, $6, pnpm workspaces.
4. Create workspace layout:
   - root: `package.json` with `pnpm` workspaces, `tsconfig.base.json`, `eslint`, `prettier`.
   - apps/web, apps/api, packages/ui, packages/config.
5. Add scripts:
   - root: `dev`, `build`, `lint`, `typecheck`, `test`, `e2e`, `format`.
   - web: $7 scripts. api: dev with ts-node or tsx.
6. Seed CI files: `.github/workflows/ci.yml` with jobs [lint, typecheck, test, build, e2e] and artifact uploads.
7. Add example routes:
   - web: `/health` page. api: `GET /health` returning `{ ok: true }`.
8. Write docs to `README.md`: how to run dev, test, build, and env variables.
9. Stage files, but do not commit. Output a tree and next commands.

**Output format:**
- Title line: `Scaffold created: $1`
- Sections: `Repo Tree`, `Next Steps`, `CI Seeds`.
- Include a fenced code block of the `tree` and sample scripts.

**Placeholder Mapping:**
- $1: Stack name (e.g., `ts-next-express-pg`)
- $2: App framework (e.g., Next.js)
- $3: API framework (e.g., Express)
- $4: Database type (e.g., PostgreSQL)
- $5: Database library (e.g., Prisma)
- $6: Tooling (e.g., Playwright)
- $7: Example dev scripts (e.g., `next dev`)

**Missing sections added for analysis context:**
- Affected files: `apps/web`, `apps/api`, `packages/ui`, `packages/config`, `package.json`, `.github/workflows/ci.yml`
- Root cause: N/A (no specific issue)
- Proposed fix: N/A (scaffolding is procedural)
- Tests: E2E tests via Playwright
- Docs gaps: None (docs in README)
- Open questions: None (all steps covered)
```
