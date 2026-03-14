-- {{APP_NAME}} Restaurant POS Schema — SQLite

-- Menu categories
CREATE TABLE menu_categories (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    name       TEXT NOT NULL UNIQUE,
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_active  INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Menu items
CREATE TABLE menu_items (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    category_id   TEXT NOT NULL REFERENCES menu_categories (id),
    name          TEXT NOT NULL,
    description   TEXT,
    price         REAL NOT NULL,
    cost          REAL,
    is_available  INTEGER NOT NULL DEFAULT 1,
    prep_time_min INTEGER,
    allergens     TEXT DEFAULT '[]',
    image_url     TEXT,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_menu_items_category ON menu_items (category_id);

CREATE TRIGGER trg_menu_items_updated AFTER UPDATE ON menu_items
BEGIN UPDATE menu_items SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Dining tables
CREATE TABLE tables (
    id       TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    label    TEXT NOT NULL UNIQUE,
    capacity INTEGER NOT NULL DEFAULT 4,
    section  TEXT,
    status   TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'occupied', 'reserved', 'cleaning'))
);

-- Staff
CREATE TABLE staff (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    email      TEXT NOT NULL UNIQUE,
    name       TEXT NOT NULL,
    role       TEXT NOT NULL DEFAULT 'waiter' CHECK (role IN ('manager', 'chef', 'waiter', 'cashier', 'host')),
    pin_hash   TEXT,
    is_active  INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_staff_updated AFTER UPDATE ON staff
BEGIN UPDATE staff SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Reservations
CREATE TABLE reservations (
    id             TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    table_id       TEXT REFERENCES tables (id),
    customer_name  TEXT NOT NULL,
    customer_phone TEXT,
    party_size     INTEGER NOT NULL DEFAULT 2,
    reserved_at    TEXT NOT NULL,
    status         TEXT NOT NULL DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'seated', 'completed', 'cancelled', 'no_show')),
    notes          TEXT,
    created_at     TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_reservations_table ON reservations (table_id);
CREATE INDEX idx_reservations_date ON reservations (reserved_at);

-- Orders
CREATE TABLE orders (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    table_id   TEXT REFERENCES tables (id),
    server_id  TEXT NOT NULL REFERENCES staff (id),
    order_type TEXT NOT NULL DEFAULT 'dine_in' CHECK (order_type IN ('dine_in', 'takeout', 'delivery')),
    status     TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'preparing', 'served', 'closed', 'cancelled')),
    subtotal   REAL NOT NULL DEFAULT 0.00,
    tax        REAL NOT NULL DEFAULT 0.00,
    tip        REAL NOT NULL DEFAULT 0.00,
    total      REAL NOT NULL DEFAULT 0.00,
    notes      TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_orders_table ON orders (table_id);
CREATE INDEX idx_orders_server ON orders (server_id);
CREATE INDEX idx_orders_status ON orders (status);

CREATE TRIGGER trg_orders_updated AFTER UPDATE ON orders
BEGIN UPDATE orders SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Order items
CREATE TABLE order_items (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    order_id     TEXT NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    menu_item_id TEXT NOT NULL REFERENCES menu_items (id),
    quantity     INTEGER NOT NULL DEFAULT 1,
    unit_price   REAL NOT NULL,
    modifiers    TEXT DEFAULT '[]',
    notes        TEXT,
    status       TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'preparing', 'ready', 'served', 'cancelled')),
    created_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_order_items_order ON order_items (order_id);

-- Payments
CREATE TABLE payments (
    id              TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    order_id        TEXT NOT NULL REFERENCES orders (id),
    method          TEXT NOT NULL CHECK (method IN ('cash', 'credit_card', 'debit_card', 'mobile_pay', 'gift_card')),
    amount          REAL NOT NULL,
    tip             REAL NOT NULL DEFAULT 0.00,
    transaction_ref TEXT,
    status          TEXT NOT NULL DEFAULT 'completed' CHECK (status IN ('completed', 'refunded', 'failed')),
    processed_by    TEXT REFERENCES staff (id),
    created_at      TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_payments_order ON payments (order_id);
