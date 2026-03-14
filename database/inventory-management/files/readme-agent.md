# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                                                  |
| -------- | ----------------------------------------------------------------------- |
| Type     | Database schema template                                                |
| Schema   | Inventory Management (warehouses, products, stock, purchase orders)      |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                                       |

## Tables

| Table                  | Purpose                                                 |
| ---------------------- | ------------------------------------------------------- |
| `warehouses`           | Physical storage locations                              |
| `suppliers`            | Vendor/supplier contacts and payment terms              |
| `product_categories`   | Nested product classification                           |
| `products`             | Product catalog with SKU, cost, price, reorder triggers |
| `stock_levels`         | Per-warehouse per-product quantity tracking              |
| `purchase_orders`      | Orders placed with suppliers                            |
| `purchase_order_items` | Line items for purchase orders                          |
| `stock_movements`      | Audit trail for all quantity changes                    |

## PO Status Flow

`draft` → `submitted` → `confirmed` → `shipped` → `received`

Alternative: any status → `cancelled`

## Movement Types

`receive` | `ship` | `adjust` | `transfer` | `return`

## Vendor Differences

- **PostgreSQL**: Generated column `qty_available`, `NUMERIC(12,2)`, partial indexes
- **MySQL**: `DECIMAL(12,2)`, generated `qty_available` and `line_total` columns
- **SQLite**: `REAL` for decimals, no generated columns (compute in app)
- **Oracle**: `NUMBER(12,2)`, `RAW(16)` SYS_GUID(), no generated columns
