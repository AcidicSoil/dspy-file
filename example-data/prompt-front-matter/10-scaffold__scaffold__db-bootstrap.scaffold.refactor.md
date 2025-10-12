# DB Bootstrap

## Metadata

- **Identifier**: db-bootstrap  
- **Categories**: 
  - database setup
  - migration configuration
  - local development environment
- **Lifecycle Stage**: setup  
- **Dependencies**: none  
- **Provided Artifacts**: 
  - migration plan list
  - db/compose.yaml (skip for sqlite)
  - prisma/schema.prisma or drizzle/*.ts (baseline tables: users, sessions, audit_log)
  - pnpm db:migrate, db:reset, db:seed scripts
  - .env.example with DATABASE_URL and test connection script  
- **Summary**: Do db-bootstrap with a database to initialize migrations, compose files, and seed data.

## Inputs

- Database type (e.g., postgres, mysql, sqlite)

## Canonical taxonomy (exact strings)

- database setup
- migration configuration
- local development environment

### Stage hints (for inference)

- setup → initial configuration phase  
- build → after schema is defined  
- deploy → post-migration to production  

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
- Dependencies: none → valid
- Artifacts ≤3 → satisfied
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- `/db-bootstrap postgres` → Prisma + Postgres docker-compose  
- `/db-bootstrap sqlite` → skip compose, use minimal schema and seed  

# DB Bootstrap

Trigger: /db-bootstrap <postgres|mysql|sqlite|mongodb>

Purpose: Pick a database, initialize migrations, local compose, and seed scripts.

**Steps:**

1. Create `db/compose.yaml` for local dev (skip for sqlite).
2. Choose ORM/driver (Prisma or Drizzle for SQL). Add migration config.
3. Create `prisma/schema.prisma` or `drizzle/*.ts` with baseline tables (users, sessions, audit_log).
4. Add `pnpm db:migrate`, `db:reset`, `db:seed` scripts. Write seed data for local admin user.
5. Update `.env.example` with `DATABASE_URL` and test connection script.

**Output format:** Migration plan list and generated file paths.

**Examples:** `/db-bootstrap postgres` → Prisma + Postgres docker-compose.

**Notes:** Avoid destructive defaults; provide `--preview-feature` warnings if relevant.
