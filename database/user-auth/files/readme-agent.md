# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                             |
| -------- | -------------------------------------------------- |
| Type     | Database schema template                           |
| Schema   | User authentication (users, roles, sessions)       |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                  |

## Project Structure

```
├── postgresql/
│   ├── schema.sql          # PostgreSQL DDL
│   └── seed.sql            # Sample data
├── mysql/
│   ├── schema.sql          # MySQL DDL
│   └── seed.sql            # Sample data
├── sqlite/
│   ├── schema.sql          # SQLite DDL
│   └── seed.sql            # Sample data
├── oracle/
│   ├── schema.sql          # Oracle DDL
│   └── seed.sql            # Sample data
├── init.sh                 # Auto-run schema + seed based on DB_VENDOR
├── .env.example            # Connection config per vendor
├── .gitignore
├── readme-agent.md
└── README.md
```

## Tables

| Table                 | Purpose                                |
| --------------------- | -------------------------------------- |
| `roles`               | User roles (admin, user, moderator)    |
| `users`               | User accounts with credentials         |
| `email_verifications` | Email verification tokens              |
| `password_resets`     | Password reset tokens                  |
| `sessions`            | Active user sessions                   |
| `auth_audit_log`      | Login/logout/security audit trail      |

## Environment Variables

| Variable         | Used By    | Description          |
| ---------------- | ---------- | -------------------- |
| `DB_VENDOR`      | init.sh    | Which vendor to use  |
| `PG_HOST`        | PostgreSQL | Database host        |
| `PG_PORT`        | PostgreSQL | Port (default 5432)  |
| `PG_USER`        | PostgreSQL | Username             |
| `PG_PASSWORD`    | PostgreSQL | Password             |
| `PG_DATABASE`    | PostgreSQL | Database name        |
| `MYSQL_HOST`     | MySQL      | Database host        |
| `MYSQL_PORT`     | MySQL      | Port (default 3306)  |
| `MYSQL_USER`     | MySQL      | Username             |
| `MYSQL_PASSWORD` | MySQL      | Password             |
| `MYSQL_DATABASE` | MySQL      | Database name        |
| `SQLITE_FILE`    | SQLite     | Path to .db file     |
| `ORACLE_HOST`    | Oracle     | Database host        |
| `ORACLE_PORT`    | Oracle     | Port (default 1521)  |
| `ORACLE_USER`    | Oracle     | Username             |
| `ORACLE_PASSWORD`| Oracle     | Password             |
| `ORACLE_SERVICE` | Oracle     | Service name         |

## Vendor Differences

- **PostgreSQL**: Uses `UUID`, `TIMESTAMPTZ`, `JSONB`, `INET`, PL/pgSQL triggers
- **MySQL**: Uses `CHAR(36)` UUIDs, `JSON` type, `ON UPDATE CURRENT_TIMESTAMP`
- **SQLite**: Uses `TEXT` UUIDs via `randomblob()`, `INTEGER` for booleans, `AFTER UPDATE` triggers
- **Oracle**: Uses `RAW(16)` with `SYS_GUID()`, `CLOB` for JSON, `BEFORE UPDATE` triggers
