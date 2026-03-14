# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                                |
| -------- | ----------------------------------------------------- |
| Type     | Database schema template                              |
| Schema   | E-Commerce (products, orders, customers, inventory)   |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                     |

## Tables

| Table                | Purpose                                    |
| -------------------- | ------------------------------------------ |
| `categories`         | Product categories (supports nesting)      |
| `products`           | Product catalog with pricing and stock     |
| `customers`          | Customer accounts                          |
| `customer_addresses` | Shipping/billing addresses per customer    |
| `orders`             | Order header with totals and status        |
| `order_items`        | Line items per order                       |
| `product_reviews`    | Customer reviews with 1-5 star ratings     |

## Order Status Flow

`pending` → `confirmed` → `processing` → `shipped` → `delivered`

Alternative: `pending` → `cancelled` or `delivered` → `refunded`

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

Same structure as user-auth — see `.env.example` for per-vendor connection details.

## Vendor Differences

- **PostgreSQL**: `NUMERIC(12,2)`, `JSONB` metadata, `INET`, partial indexes
- **MySQL**: `DECIMAL(12,2)`, `JSON` type, `ON UPDATE CURRENT_TIMESTAMP`
- **SQLite**: `REAL` for decimals, `TEXT` for JSON, `INTEGER` booleans
- **Oracle**: `NUMBER(12,2)`, `CLOB` for JSON, `RAW(16)` UUIDs
