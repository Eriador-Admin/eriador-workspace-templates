# {{APP_NAME}}

Project management database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **projects** — Top-level project containers with status and visibility
- **project_members** — User–project assignments with roles (owner/admin/member/viewer)
- **boards** — Kanban boards within a project
- **columns** — Board lanes (Backlog, To Do, In Progress, Review, Done)
- **labels** — Color-coded labels per project
- **tasks** — Work items with priority, assignee, due date, estimates, and subtask support
- **task_labels** — Many-to-many task–label association
- **task_comments** — Threaded discussion on tasks
- **task_activity** — Change history audit log per task

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
psql -h localhost -U postgres -d myprojects -f postgresql/schema.sql
psql -h localhost -U postgres -d myprojects -f postgresql/seed.sql

# MySQL
mysql -u root -p myprojects < mysql/schema.sql

# SQLite
sqlite3 myprojects.db < sqlite/schema.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
