# {{APP_NAME}}

SaaS multi-tenant database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **plans** — Subscription tiers with pricing, limits, and feature flags
- **organizations** — Tenant accounts with settings and plan association
- **members** — Users within organizations (owner, admin, member, viewer)
- **subscriptions** — Billing records linking orgs to plans with period tracking
- **invitations** — Pending member invitations with token-based acceptance
- **audit_log** — Per-organization activity log for compliance and debugging

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
psql -h localhost -U postgres -d mysaas -f postgresql/schema.sql
psql -h localhost -U postgres -d mysaas -f postgresql/seed.sql

# MySQL
mysql -u root -p mysaas < mysql/schema.sql

# SQLite
sqlite3 mysaas.db < sqlite/schema.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
