# {{APP_NAME}}

Restaurant POS database schema for **{{DB_VENDOR}}**.

## Quick Start

```bash
bash init.sh
```

## Tables

| Table | Purpose |
|-------|---------|
| menu_categories | Food & drink categories |
| menu_items | Menu entries with pricing and prep time |
| tables | Dining tables with capacity and status |
| staff | Employees (manager, chef, waiter, cashier, host) |
| reservations | Customer reservations with party size |
| orders | Customer orders (dine-in, takeout, delivery) |
| order_items | Individual line items per order |
| payments | Payment records with multiple methods |

## Order Lifecycle

`open` → `preparing` → `served` → `closed`

## Table Status

`available` · `occupied` · `reserved` · `cleaning`

## Payment Methods

cash · credit_card · debit_card · mobile_pay · gift_card
