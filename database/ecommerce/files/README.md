# {{APP_NAME}}

E-Commerce database schema with support for PostgreSQL, MySQL, SQLite, and Oracle.

## Tables

- **categories** — Product categories with nested hierarchy
- **products** — Product catalog (name, price, SKU, stock, images)
- **customers** — Customer accounts with credentials
- **customer_addresses** — Shipping/billing addresses
- **orders** — Order headers with status tracking and totals
- **order_items** — Individual line items per order
- **product_reviews** — Customer reviews with star ratings

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
psql -h localhost -U postgres -d myshop -f postgresql/schema.sql
psql -h localhost -U postgres -d myshop -f postgresql/seed.sql

# MySQL
mysql -u root -p myshop < mysql/schema.sql

# SQLite
sqlite3 myshop.db < sqlite/schema.sql

# Oracle
sqlplus user/pass@host:1521/service @oracle/schema.sql
```

## Configuration

Copy `.env.example` to `.env` and update values. See `readme-agent.md` for full details.
