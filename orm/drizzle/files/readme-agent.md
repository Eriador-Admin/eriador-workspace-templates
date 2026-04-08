# Agent Instructions — {{PROJECT_NAME}}

This is a Drizzle ORM project with PostgreSQL.

## Tech Stack
- **ORM**: Drizzle ORM
- **Database**: PostgreSQL (Docker)
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Schema definitions in `src/schema.ts` (table definitions as code)
- DB client in `src/db.ts`
- Drizzle config in `drizzle.config.ts`
- Queries look like SQL: `db.select().from(users).where(eq(users.id, 1))`
- Run `npx drizzle-kit generate` after schema changes
