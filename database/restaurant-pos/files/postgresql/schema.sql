-- {{APP_NAME}} Restaurant POS Schema — PostgreSQL

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Menu categories
CREATE TABLE menu_categories (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(100) NOT NULL UNIQUE,
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Menu items
CREATE TABLE menu_items (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES menu_categories (id),
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    price       NUMERIC(10,2) NOT NULL,
    cost        NUMERIC(10,2),
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    prep_time_min INTEGER,
    allergens    JSONB DEFAULT '[]',
    image_url    VARCHAR(500),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_menu_items_category ON menu_items (category_id);

-- Dining tables
CREATE TABLE tables (
    id       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    label    VARCHAR(20) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL DEFAULT 4,
    section  VARCHAR(50),
    status   VARCHAR(15) NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'occupied', 'reserved', 'cleaning'))
);

-- Staff
CREATE TABLE staff (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    role       VARCHAR(20) NOT NULL DEFAULT 'waiter' CHECK (role IN ('manager', 'chef', 'waiter', 'cashier', 'host')),
    pin_hash   VARCHAR(255),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Reservations
CREATE TABLE reservations (
    id             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    table_id       UUID REFERENCES tables (id),
    customer_name  VARCHAR(200) NOT NULL,
    customer_phone VARCHAR(50),
    party_size     INTEGER NOT NULL DEFAULT 2,
    reserved_at    TIMESTAMPTZ NOT NULL,
    status         VARCHAR(15) NOT NULL DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'seated', 'completed', 'cancelled', 'no_show')),
    notes          TEXT,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_reservations_table ON reservations (table_id);
CREATE INDEX idx_reservations_date ON reservations (reserved_at);

-- Orders
CREATE TABLE orders (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    table_id   UUID REFERENCES tables (id),
    server_id  UUID NOT NULL REFERENCES staff (id),
    order_type VARCHAR(15) NOT NULL DEFAULT 'dine_in' CHECK (order_type IN ('dine_in', 'takeout', 'delivery')),
    status     VARCHAR(15) NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'preparing', 'served', 'closed', 'cancelled')),
    subtotal   NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    tax        NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    tip        NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    total      NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    notes      TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_orders_table ON orders (table_id);
CREATE INDEX idx_orders_server ON orders (server_id);
CREATE INDEX idx_orders_status ON orders (status);

-- Order items
CREATE TABLE order_items (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id     UUID NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    menu_item_id UUID NOT NULL REFERENCES menu_items (id),
    quantity     INTEGER NOT NULL DEFAULT 1,
    unit_price   NUMERIC(10,2) NOT NULL,
    modifiers    JSONB DEFAULT '[]',
    notes        TEXT,
    status       VARCHAR(15) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'preparing', 'ready', 'served', 'cancelled')),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_order_items_order ON order_items (order_id);

-- Payments
CREATE TABLE payments (
    id             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id       UUID NOT NULL REFERENCES orders (id),
    method         VARCHAR(20) NOT NULL CHECK (method IN ('cash', 'credit_card', 'debit_card', 'mobile_pay', 'gift_card')),
    amount         NUMERIC(10,2) NOT NULL,
    tip            NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    transaction_ref VARCHAR(100),
    status         VARCHAR(15) NOT NULL DEFAULT 'completed' CHECK (status IN ('completed', 'refunded', 'failed')),
    processed_by   UUID REFERENCES staff (id),
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_payments_order ON payments (order_id);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_menu_items_updated BEFORE UPDATE ON menu_items FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_staff_updated BEFORE UPDATE ON staff FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_orders_updated BEFORE UPDATE ON orders FOR EACH ROW EXECUTE FUNCTION update_updated_at();
