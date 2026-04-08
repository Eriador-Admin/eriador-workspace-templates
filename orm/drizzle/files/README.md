# {{PROJECT_NAME}}

[Drizzle ORM](https://orm.drizzle.team/) — lightweight, SQL-like TypeScript ORM with PostgreSQL.

## Getting Started

```bash
bash init.sh    # install deps, start Postgres, run migrations + seed
bash run.sh     # start the API
bash stop.sh    # stop everything
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/users` | List all users |
| POST | `/users` | Create a user |
| GET | `/posts` | List published posts |
| POST | `/posts` | Create a post |
| PATCH | `/posts/:id/publish` | Publish a post |
| GET | `/health` | Health check |

## Drizzle Commands

```bash
npx drizzle-kit generate    # Generate migration from schema changes
npx drizzle-kit migrate     # Apply pending migrations
npx drizzle-kit studio      # Visual DB browser (port 4983)
```

## Project Structure

```
src/
  app.ts             # Express API
  db.ts              # Drizzle client
  schema.ts          # Table definitions
  seed.ts            # Seed script
drizzle.config.ts    # Drizzle Kit config
docker-compose.yml   # PostgreSQL
```

## Requirements

- Node.js 18+
- Docker (for PostgreSQL)
