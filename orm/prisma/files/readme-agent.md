# Agent Instructions — {{PROJECT_NAME}}

This is a Prisma ORM project with PostgreSQL.

## Tech Stack
- **ORM**: Prisma
- **Database**: PostgreSQL (Docker)
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Prisma client singleton in `src/prisma.ts`
- Schema in `prisma/schema.prisma`
- Always run `npx prisma generate` after schema changes
- Use `npx prisma migrate dev --name description` for migrations
- Seed data in `prisma/seed.ts`
