# {{APP_NAME}}

Blog / CMS database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **authors** — Content authors with profiles and credentials
- **categories** — Post categories with nested hierarchy
- **posts** — Blog posts with draft/published/archived workflow
- **tags** — Flat tags for flexible post labeling
- **post_tags** — Many-to-many junction between posts and tags
- **comments** — Reader comments with threaded replies (via parent_id)
- **media** — Uploaded file library (images, documents)

## Getting Started

```bash
# Copy env and configure your database credentials
bash init.sh

# Edit .env with your connection details, then re-run
bash init.sh
```

## Manual Execution

```bash
# PostgreSQL
psql -h localhost -U postgres -d myblog -f postgresql/schema.sql
psql -h localhost -U postgres -d myblog -f postgresql/seed.sql

# MySQL
mysql -u root -p myblog < mysql/schema.sql

# SQLite
sqlite3 myblog.db < sqlite/schema.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
