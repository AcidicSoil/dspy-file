<!-- $1 = database type (postgres/mysql/sqlite/mongodb) -->
<!-- $2 = ORM/driver (Prisma/Drizzle) -->
<!-- $3 = base schema file (prisma/schema.prisma or drizzle/*.ts) -->
<!-- $4 = compose file path (db/compose.yaml) -->
<!-- $5 = migration scripts (pnpm db:migrate, db:reset, db:seed) -->
<!-- $6 = seed data content -->
<!-- $7 = environment variable (DATABASE_URL) -->

# DB Bootstrap

Trigger: `/db-bootstrap $1`

Purpose: Pick a database, initialize migrations, local compose, and seed scripts.

**Steps:**

1. Create $4 for local dev (skip for sqlite).
2. Choose ORM/driver $2. Add migration config.
3. Create $3 with baseline tables (users, sessions, audit_log).
4. Add $5 scripts. Write $6 for local admin user.
5. Update `.env.example` with $7 and test connection script.

**Output format:** Migration plan list and generated file paths.

**Examples:** `/db-bootstrap $1` → $2 + $1 docker-compose.

**Notes:** Avoid destructive defaults; provide `--preview-feature` warnings if relevant.
