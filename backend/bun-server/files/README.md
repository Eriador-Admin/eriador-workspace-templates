# {{PROJECT_NAME}}

A zero-dependency HTTP server built with [Bun](https://bun.sh/) — the all-in-one JavaScript runtime. Uses Bun's native APIs for HTTP serving, SQLite database, file I/O, and password hashing.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start server on port 3000
bash stop.sh    # stop server
```

## Prerequisites

- Bun 1.0+ (`curl -fsSL https://bun.sh/install | bash`)

## Project Structure

```
src/
  server.ts                     # Bun.serve entry point
  router.ts                     # URL pattern router
  routes/
    items.ts                    # Items CRUD handlers
    health.ts                   # Health check
  db/
    database.ts                 # Bun SQLite setup
    migrations.ts               # Table creation
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | /api/items | List all items |
| GET | /api/items/:id | Get item by ID |
| POST | /api/items | Create item |
| PUT | /api/items/:id | Update item |
| DELETE | /api/items/:id | Delete item |
| GET | /health | Health check |

## Why Bun?

- **Fast** — Bun's HTTP server is ~2-4x faster than Node.js
- **Zero-dep** — SQLite, password hashing, .env, TS all built-in
- **Native TypeScript** — no build step needed
- **Drop-in Node.js compat** — most npm packages just work
