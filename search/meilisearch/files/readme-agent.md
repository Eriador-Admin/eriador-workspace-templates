# Agent Instructions — {{PROJECT_NAME}}

This is a Meilisearch full-text search project.

## Tech Stack
- **Search Engine**: Meilisearch
- **API Server**: Express + TypeScript
- **Client**: meilisearch JS SDK

## Key Conventions
- Entry point: `src/app.ts`
- Meilisearch client in `src/client.ts`
- Seed data with `src/seed.ts`
- Sample data in `src/data/movies.json`
- Meilisearch runs in Docker on port 7700
