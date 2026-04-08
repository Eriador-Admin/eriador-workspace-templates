# {{PROJECT_NAME}}

An ultrafast web API built with [Hono](https://hono.dev/) — a small, simple, and ultrafast web framework for the edge and any JavaScript runtime.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server on port 3000
bash stop.sh    # stop dev server
```

## Prerequisites

- Node.js 18+

## Project Structure

```
src/
  index.ts                      # App entry point
  routes/
    items.ts                    # Items CRUD routes
    health.ts                   # Health check
  middleware/
    logger.ts                   # Request logger
    error-handler.ts            # Global error handler
  validators/
    item.ts                     # Zod schemas for validation
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

## Why Hono?

- **Ultrafast** — built on Web Standard APIs, minimal overhead
- **Tiny** — ~14KB minified
- **Multi-runtime** — runs on Node.js, Bun, Deno, Cloudflare Workers, Vercel Edge
- **TypeScript-first** — full type safety including route params
- **Built-in middleware** — cors, logger, compress, bearer auth, etc.
