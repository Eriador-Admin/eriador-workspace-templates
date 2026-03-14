-- {{APP_NAME}} Restaurant POS Schema — Oracle

-- Menu categories
CREATE TABLE menu_categories (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name       VARCHAR2(100) NOT NULL UNIQUE,
    sort_order NUMBER(5) DEFAULT 0 NOT NULL,
    is_active  NUMBER(1) DEFAULT 1 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

-- Menu items
CREATE TABLE menu_items (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    category_id   RAW(16) NOT NULL REFERENCES menu_categories (id),
    name          VARCHAR2(200) NOT NULL,
    description   CLOB,
    price         NUMBER(10,2) NOT NULL,
    cost          NUMBER(10,2),
    is_available  NUMBER(1) DEFAULT 1 NOT NULL,
    prep_time_min NUMBER(5),
    allergens     CLOB DEFAULT '[]',
    image_url     VARCHAR2(500),
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_menu_items_category ON menu_items (category_id);

CREATE OR REPLACE TRIGGER trg_menu_items_updated
BEFORE UPDATE ON menu_items FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Dining tables (TABLES is not reserved in Oracle but using tables_tbl for clarity)
CREATE TABLE dining_tables (
    id       RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    label    VARCHAR2(20) NOT NULL UNIQUE,
    capacity NUMBER(3) DEFAULT 4 NOT NULL,
    section  VARCHAR2(50),
    status   VARCHAR2(15) DEFAULT 'available' NOT NULL CHECK (status IN ('available', 'occupied', 'reserved', 'cleaning'))
);

-- Staff
CREATE TABLE staff (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email      VARCHAR2(255) NOT NULL UNIQUE,
    name       VARCHAR2(200) NOT NULL,
    role       VARCHAR2(20) DEFAULT 'waiter' NOT NULL CHECK (role IN ('manager', 'chef', 'waiter', 'cashier', 'host')),
    pin_hash   VARCHAR2(255),
    is_active  NUMBER(1) DEFAULT 1 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_staff_updated
BEFORE UPDATE ON staff FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Reservations
CREATE TABLE reservations (
    id             RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    table_id       RAW(16) REFERENCES dining_tables (id),
    customer_name  VARCHAR2(200) NOT NULL,
    customer_phone VARCHAR2(50),
    party_size     NUMBER(3) DEFAULT 2 NOT NULL,
    reserved_at    TIMESTAMP WITH TIME ZONE NOT NULL,
    status         VARCHAR2(15) DEFAULT 'confirmed' NOT NULL CHECK (status IN ('confirmed', 'seated', 'completed', 'cancelled', 'no_show')),
    notes          CLOB,
    created_at     TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_reservations_table ON reservations (table_id);
CREATE INDEX idx_reservations_date ON reservations (reserved_at);

-- Orders
CREATE TABLE orders (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    table_id   RAW(16) REFERENCES dining_tables (id),
    server_id  RAW(16) NOT NULL REFERENCES staff (id),
    order_type VARCHAR2(15) DEFAULT 'dine_in' NOT NULL CHECK (order_type IN ('dine_in', 'takeout', 'delivery')),
    status     VARCHAR2(15) DEFAULT 'open' NOT NULL CHECK (status IN ('open', 'preparing', 'served', 'closed', 'cancelled')),
    subtotal   NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    tax        NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    tip        NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    total      NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    notes      CLOB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_orders_table ON orders (table_id);
CREATE INDEX idx_orders_server ON orders (server_id);
CREATE INDEX idx_orders_status ON orders (status);

CREATE OR REPLACE TRIGGER trg_orders_updated
BEFORE UPDATE ON orders FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Order items
CREATE TABLE order_items (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    order_id     RAW(16) NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    menu_item_id RAW(16) NOT NULL REFERENCES menu_items (id),
    quantity     NUMBER(5) DEFAULT 1 NOT NULL,
    unit_price   NUMBER(10,2) NOT NULL,
    modifiers    CLOB DEFAULT '[]',
    notes        CLOB,
    status       VARCHAR2(15) DEFAULT 'pending' NOT NULL CHECK (status IN ('pending', 'preparing', 'ready', 'served', 'cancelled')),
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_order_items_order ON order_items (order_id);

-- Payments
CREATE TABLE payments (
    id              RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    order_id        RAW(16) NOT NULL REFERENCES orders (id),
    method          VARCHAR2(20) NOT NULL CHECK (method IN ('cash', 'credit_card', 'debit_card', 'mobile_pay', 'gift_card')),
    amount          NUMBER(10,2) NOT NULL,
    tip             NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    transaction_ref VARCHAR2(100),
    status          VARCHAR2(15) DEFAULT 'completed' NOT NULL CHECK (status IN ('completed', 'refunded', 'failed')),
    processed_by    RAW(16) REFERENCES staff (id),
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_payments_order ON payments (order_id);
