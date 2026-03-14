-- {{APP_NAME}} Inventory Management Schema — SQLite

CREATE TABLE warehouses (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    name       TEXT NOT NULL,
    code       TEXT NOT NULL UNIQUE,
    address    TEXT,
    city       TEXT,
    country    TEXT,
    is_active  INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_warehouses_updated AFTER UPDATE ON warehouses
BEGIN UPDATE warehouses SET updated_at = datetime('now') WHERE id = NEW.id; END;

CREATE TABLE suppliers (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    name          TEXT NOT NULL,
    code          TEXT NOT NULL UNIQUE,
    contact_name  TEXT,
    contact_email TEXT,
    contact_phone TEXT,
    address       TEXT,
    payment_terms INTEGER DEFAULT 30,
    is_active     INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_suppliers_updated AFTER UPDATE ON suppliers
BEGIN UPDATE suppliers SET updated_at = datetime('now') WHERE id = NEW.id; END;

CREATE TABLE product_categories (
    id        TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    parent_id TEXT REFERENCES product_categories (id),
    name      TEXT NOT NULL,
    slug      TEXT NOT NULL UNIQUE
);

CREATE TABLE products (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    category_id   TEXT REFERENCES product_categories (id),
    sku           TEXT NOT NULL UNIQUE,
    name          TEXT NOT NULL,
    description   TEXT,
    unit          TEXT NOT NULL DEFAULT 'pcs',
    unit_cost     REAL NOT NULL DEFAULT 0,
    unit_price    REAL NOT NULL DEFAULT 0,
    reorder_point INTEGER NOT NULL DEFAULT 10,
    reorder_qty   INTEGER NOT NULL DEFAULT 50,
    is_active     INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_products_updated AFTER UPDATE ON products
BEGIN UPDATE products SET updated_at = datetime('now') WHERE id = NEW.id; END;

CREATE TABLE stock_levels (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    warehouse_id  TEXT NOT NULL REFERENCES warehouses (id) ON DELETE CASCADE,
    product_id    TEXT NOT NULL REFERENCES products (id) ON DELETE CASCADE,
    qty_on_hand   INTEGER NOT NULL DEFAULT 0 CHECK (qty_on_hand >= 0),
    qty_reserved  INTEGER NOT NULL DEFAULT 0 CHECK (qty_reserved >= 0),
    last_counted_at TEXT,
    updated_at    TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (warehouse_id, product_id)
);

CREATE TABLE purchase_orders (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    po_number     TEXT NOT NULL UNIQUE,
    supplier_id   TEXT NOT NULL REFERENCES suppliers (id),
    warehouse_id  TEXT NOT NULL REFERENCES warehouses (id),
    status        TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'submitted', 'confirmed', 'shipped', 'received', 'cancelled')),
    order_date    TEXT NOT NULL DEFAULT (date('now')),
    expected_date TEXT,
    total_amount  REAL NOT NULL DEFAULT 0,
    notes         TEXT,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_purchase_orders_updated AFTER UPDATE ON purchase_orders
BEGIN UPDATE purchase_orders SET updated_at = datetime('now') WHERE id = NEW.id; END;

CREATE TABLE purchase_order_items (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    po_id      TEXT NOT NULL REFERENCES purchase_orders (id) ON DELETE CASCADE,
    product_id TEXT NOT NULL REFERENCES products (id),
    qty        INTEGER NOT NULL CHECK (qty > 0),
    unit_cost  REAL NOT NULL
);

CREATE TABLE stock_movements (
    id             TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))),
    warehouse_id   TEXT NOT NULL REFERENCES warehouses (id),
    product_id     TEXT NOT NULL REFERENCES products (id),
    movement_type  TEXT NOT NULL CHECK (movement_type IN ('receive', 'ship', 'adjust', 'transfer', 'return')),
    qty            INTEGER NOT NULL,
    reference_id   TEXT,
    reference_type TEXT,
    notes          TEXT,
    performed_by   TEXT,
    created_at     TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_stock_movements_warehouse ON stock_movements (warehouse_id);
CREATE INDEX idx_stock_movements_product ON stock_movements (product_id);
