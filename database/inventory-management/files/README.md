# {{APP_NAME}}

Inventory management database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **warehouses** — Physical storage locations with address
- **suppliers** — Vendor contacts, payment terms
- **product_categories** — Nested product categories
- **products** — Product catalog with SKU, cost/price, reorder thresholds
- **stock_levels** — Per-warehouse quantity tracking (on-hand, reserved)
- **purchase_orders** — Supplier orders with status workflow
- **purchase_order_items** — Line items per purchase order
- **stock_movements** — Audit trail for every quantity change

## Getting Started

```bash
bash init.sh
# Edit .env with your connection details, then re-run
bash init.sh
```

## Manual Execution

```bash
# PostgreSQL
psql -h localhost -U postgres -d myinventory -f postgresql/schema.sql

# MySQL
mysql -u root -p myinventory < mysql/schema.sql

# SQLite
sqlite3 myinventory.db < sqlite/schema.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
