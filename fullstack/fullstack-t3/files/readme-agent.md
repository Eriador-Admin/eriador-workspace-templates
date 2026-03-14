# Agent Reference — T3 Stack (Next.js + tRPC + Prisma + Tailwind)

## Overview

Full-stack TypeScript application using the T3 stack. Combines Next.js App Router for the frontend and API layer, tRPC for end-to-end type-safe API calls, Prisma for database access, and Tailwind CSS for styling. Uses SQLite by default for zero-configuration development.

## Tech Stack

- **Next.js 14** — React framework with App Router and Server Components
- **tRPC 10** — End-to-end type-safe API layer (no REST, no codegen)
- **Prisma 5** — Type-safe ORM and schema-first database toolkit
- **React Query (TanStack Query)** — Server state management for tRPC
- **Tailwind CSS 3** — Utility-first CSS framework
- **Zod** — Schema validation for tRPC inputs
- **TypeScript** — Type safety across the entire stack

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json                      — Dependencies and scripts
next.config.js                    — Next.js configuration
tsconfig.json                     — TypeScript configuration
tailwind.config.js                — Tailwind CSS theme and content paths
postcss.config.js                 — PostCSS plugins
prisma/schema.prisma              — Database schema definition
app/layout.tsx                    — Root layout component
app/page.tsx                      — Home page
app/providers.tsx                 — React Query + tRPC provider setup
app/globals.css                   — Global styles with Tailwind directives
app/api/trpc/[trpc]/route.ts     — tRPC HTTP handler (Next.js API route)
server/trpc.ts                    — tRPC initialization (context, middleware)
server/root.ts                    — tRPC router definition (procedures)
utils/trpc.ts                     — tRPC client hooks for React
.env.example                      — Environment variable defaults
init.sh                           — Install deps, generate Prisma client, push schema
run.sh                            — Start development server
stop.sh                           — Stop development server
Dockerfile                        — Production container
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DATABASE_URL` | Yes | `file:./dev.db` | Prisma database connection string. Default uses SQLite. For production, use PostgreSQL: `postgresql://user:pass@host:5432/dbname` |
| `PORT` | No | `3000` | Port for the Next.js server |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env`, generate Prisma client, push schema to database | `bash init.sh` |
| `run.sh` | Start the Next.js dev server with hot reload | `bash run.sh` |
| `stop.sh` | Stop the running dev server by killing the process on the configured port | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The dev server starts at `http://localhost:3000`. The SQLite database `dev.db` is created automatically by `init.sh`.

Additional database commands:

```bash
npx prisma studio      # Visual database browser at localhost:5555
npx prisma db push     # Push schema changes to the database
npx prisma generate    # Regenerate Prisma client after schema changes
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t t3-app .
docker run -d -p 3000:3000 \
  -e DATABASE_URL="postgresql://user:pass@host:5432/dbname" \
  --name t3-app t3-app
```

Or use an env file:

```bash
docker run -d -p 3000:3000 --env-file .env --name t3-app t3-app
```

**Important:** The default `DATABASE_URL` uses SQLite (`file:./dev.db`), which works in the container but data is lost when the container is removed. For production, switch to PostgreSQL or another external database and update `prisma/schema.prisma` datasource provider accordingly.

The Dockerfile:
1. Installs dependencies
2. Copies `.env.example` as `.env` for the build step (Prisma needs it at build time)
3. Generates the Prisma client
4. Builds the Next.js application
5. Runs `npm start` (Next.js production server)

## Health Check

```bash
curl -s http://localhost:3000/api/trpc/hello?input=%7B%7D
```

Expected response: JSON with `{"result":{"data":{"greeting":"Hello world!"}}}`.

## API (tRPC Procedures)

| Procedure | Type | Input | Description |
|-----------|------|-------|-------------|
| `hello` | query | `{ text?: string }` | Returns a greeting message |
| `posts.list` | query | none | List all posts from the database |
| `posts.create` | mutation | `{ title: string, content?: string }` | Create a new post |

tRPC procedures are defined in `server/root.ts`. Call them from React using the hooks in `utils/trpc.ts`.

## Customization

- **Add procedures:** Define new procedures in `server/root.ts` using `publicProcedure.input(zodSchema).query()` or `.mutation()`
- **Add database models:** Edit `prisma/schema.prisma`, run `npx prisma db push`, then `npx prisma generate`
- **Switch to PostgreSQL:** Change `provider = "sqlite"` to `provider = "postgresql"` in `prisma/schema.prisma` and update `DATABASE_URL`
- **Add pages:** Create `app/<route>/page.tsx` files
- **Add auth:** Install `next-auth` and add session-based tRPC context in `server/trpc.ts`
