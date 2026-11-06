# Agent Instructions — {{PROJECT_NAME}}

This is a Strapi headless CMS project.

## Tech Stack
- **CMS**: Strapi v5 (admin panel uses React 18)
- **Language**: JavaScript
- **Database**: SQLite via better-sqlite3 (default; set `DATABASE_CLIENT` to `postgres` or `mysql` and install `pg` / `mysql2`)

## Key Conventions
- Content types defined in `src/api/`
- Server config in `config/server.js`
- Database config in `config/database.js`
- Middleware stack in `config/middlewares.js`, REST defaults in `config/api.js`, plugin config in `config/plugins.js`
- `ENCRYPTION_KEY` (in `.env`) is required by Strapi 5's admin `secrets.encryptionKey`
- Strapi 5 uses the Document Service API (`strapi.documents()`), not the v4 Entity Service
- Admin panel at `/admin`
- REST API auto-generated for content types
