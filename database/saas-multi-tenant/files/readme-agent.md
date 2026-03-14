# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                                          |
| -------- | --------------------------------------------------------------- |
| Type     | Database schema template                                        |
| Schema   | SaaS Multi-Tenant (orgs, members, subscriptions, invitations)   |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                               |

## Tables

| Table           | Purpose                                               |
| --------------- | ----------------------------------------------------- |
| `plans`         | Subscription tiers with pricing and feature flags     |
| `organizations` | Tenant accounts (the top-level entity)                |
| `members`       | Users within an organization (owner/admin/member/viewer) |
| `subscriptions` | Billing records tying an org to a plan                |
| `invitations`   | Pending invites with token and expiry                 |
| `audit_log`     | Activity log scoped per organization                  |

## Member Roles

`owner` → `admin` → `member` → `viewer` (descending privilege)

## Subscription Status Flow

`trialing` → `active` → `past_due` → `cancelled` / `expired`

## Invitation Status Flow

`pending` → `accepted` / `expired` / `revoked`

## Project Structure

```
├── postgresql/
│   ├── schema.sql
│   └── seed.sql
├── mysql/
│   ├── schema.sql
│   └── seed.sql
├── sqlite/
│   ├── schema.sql
│   └── seed.sql
├── oracle/
│   ├── schema.sql
│   └── seed.sql
├── init.sh
├── .env.example
├── .gitignore
├── readme-agent.md
└── README.md
```

## Environment Variables

Same structure as other database templates — see `.env.example` for per-vendor connection details.

## Vendor Differences

- **PostgreSQL**: `UUID`, `TIMESTAMPTZ`, `JSONB` for features/settings, `INET` for IP, shared `update_updated_at()` trigger function
- **MySQL**: `CHAR(36)` UUIDs, `JSON` type, `ON UPDATE CURRENT_TIMESTAMP`, InnoDB + utf8mb4
- **SQLite**: `TEXT` types, `REAL` for decimals, `INTEGER` booleans, `AFTER UPDATE` triggers
- **Oracle**: `RAW(16)` SYS_GUID(), `CLOB` for JSON, `NUMBER(1)` booleans, `BEFORE UPDATE` triggers
