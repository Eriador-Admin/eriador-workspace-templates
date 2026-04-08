# {{PROJECT_NAME}}

[Prisma](https://www.prisma.io/) ORM starter with PostgreSQL, schema-driven migrations, and a CRUD API.

## Getting Started

```bash
bash init.sh    # install deps, start Postgres, run migrations + seed
bash run.sh     # start the API
bash stop.sh    # stop everything
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/users` | List all users with posts |
| POST | `/users` | Create a user |
| GET | `/posts` | List all published posts |
| POST | `/posts` | Create a post |
| PATCH | `/posts/:id/publish` | Publish a post |
| GET | `/health` | Health check |

## Prisma Commands

```bash
npx prisma studio        # Visual database editor
npx prisma migrate dev   # Create + apply migration
npx prisma generate      # Regenerate Prisma Client
npx prisma db seed       # Run seed script
```

## Project Structure

```
prisma/
  schema.prisma      # Data model
  seed.ts            # Seed script
src/
  app.ts             # Express API
  prisma.ts          # Prisma Client singleton
docker-compose.yml   # PostgreSQL
```

## Requirements

- Node.js 18+
- Docker (for PostgreSQL)
