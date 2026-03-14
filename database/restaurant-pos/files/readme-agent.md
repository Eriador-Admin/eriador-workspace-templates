# {{APP_NAME}} — Restaurant POS Database

## Agent Guidelines
- This is a **database-only** template (SQL schemas + seed data).
- Vendor chosen at scaffold time: **{{DB_VENDOR}}**.
- Run `bash init.sh` to apply schema and seed data.
- Tables: menu_categories, menu_items, tables (dining_tables in Oracle), staff, reservations, orders, order_items, payments.
- Order types: dine_in, takeout, delivery.
- Order lifecycle: open → preparing → served → closed (or cancelled).
- Table statuses: available, occupied, reserved, cleaning.
- Staff roles: manager, chef, waiter, cashier, host.
- Payment methods: cash, credit_card, debit_card, mobile_pay, gift_card.
- Oracle uses `dining_tables` instead of `tables` (reserved word).
- MySQL uses backtick-escaped `tables`.
