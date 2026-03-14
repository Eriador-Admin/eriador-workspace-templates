# {{APP_NAME}}

User authentication database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **roles** — User roles (admin, user, moderator)
- **users** — User accounts with email, password hash, and profile
- **email_verifications** — Email verification tokens
- **password_resets** — Password reset tokens
- **sessions** — Active user sessions with IP and user agent tracking
- **auth_audit_log** — Security audit trail

## Getting Started

```bash
# Copy env and configure your database credentials
bash init.sh

# Edit .env with your connection details, then re-run
bash init.sh
```

The `init.sh` script reads `DB_VENDOR` from `.env` and runs the appropriate SQL files.

## Manual Execution

```bash
# PostgreSQL
psql -h localhost -U postgres -d myapp -f postgresql/schema.sql
psql -h localhost -U postgres -d myapp -f postgresql/seed.sql

# MySQL
mysql -u root -p myapp < mysql/schema.sql
mysql -u root -p myapp < mysql/seed.sql

# SQLite
sqlite3 myapp.db < sqlite/schema.sql
sqlite3 myapp.db < sqlite/seed.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
sqlplus user/pass@host:1521/service @oracle/seed.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
