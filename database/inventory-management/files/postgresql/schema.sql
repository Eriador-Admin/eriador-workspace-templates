-- {{APP_NAME}} Inventory Management Schema — PostgreSQL

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Warehouses
CREATE TABLE warehouses (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name       VARCHAR(200) NOT NULL,
    code       VARCHAR(20) NOT NULL UNIQUE,
    address    TEXT,
    city       VARCHAR(100),
    country    VARCHAR(100),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Suppliers
CREATE TABLE suppliers (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name          VARCHAR(200) NOT NULL,
    code          VARCHAR(20) NOT NULL UNIQUE,
    contact_name  VARCHAR(200),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    address       TEXT,
    payment_terms INTEGER DEFAULT 30,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Product categories
CREATE TABLE product_categories (
    id        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    parent_id UUID REFERENCES product_categories (id),
    name      VARCHAR(100) NOT NULL,
    slug      VARCHAR(120) NOT NULL UNIQUE
);

CREATE INDEX idx_product_categories_parent ON product_categories (parent_id);

-- Products
CREATE TABLE products (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id   UUID REFERENCES product_categories (id),
    sku           VARCHAR(50) NOT NULL UNIQUE,
    name          VARCHAR(300) NOT NULL,
    description   TEXT,
    unit          VARCHAR(20) NOT NULL DEFAULT 'pcs',
    unit_cost     NUMERIC(12,2) NOT NULL DEFAULT 0,
    unit_price    NUMERIC(12,2) NOT NULL DEFAULT 0,
    reorder_point INTEGER NOT NULL DEFAULT 10,
    reorder_qty   INTEGER NOT NULL DEFAULT 50,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_products_sku ON products (sku);
CREATE INDEX idx_products_category ON products (category_id);

-- Stock levels (per warehouse per product)
CREATE TABLE stock_levels (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    warehouse_id UUID NOT NULL REFERENCES warehouses (id) ON DELETE CASCADE,
    product_id   UUID NOT NULL REFERENCES products (id) ON DELETE CASCADE,
    qty_on_hand  INTEGER NOT NULL DEFAULT 0 CHECK (qty_on_hand >= 0),
    qty_reserved INTEGER NOT NULL DEFAULT 0 CHECK (qty_reserved >= 0),
    qty_available INTEGER GENERATED ALWAYS AS (qty_on_hand - qty_reserved) STORED,
    last_counted_at TIMESTAMPTZ,
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (warehouse_id, product_id)
);

CREATE INDEX idx_stock_levels_warehouse ON stock_levels (warehouse_id);
CREATE INDEX idx_stock_levels_product ON stock_levels (product_id);

-- Purchase orders
CREATE TABLE purchase_orders (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    po_number     VARCHAR(30) NOT NULL UNIQUE,
    supplier_id   UUID NOT NULL REFERENCES suppliers (id),
    warehouse_id  UUID NOT NULL REFERENCES warehouses (id),
    status        VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'submitted', 'confirmed', 'shipped', 'received', 'cancelled')),
    order_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    expected_date DATE,
    total_amount  NUMERIC(14,2) NOT NULL DEFAULT 0,
    notes         TEXT,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_purchase_orders_supplier ON purchase_orders (supplier_id);
CREATE INDEX idx_purchase_orders_status ON purchase_orders (status);

-- Purchase order line items
CREATE TABLE purchase_order_items (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    po_id      UUID NOT NULL REFERENCES purchase_orders (id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products (id),
    qty        INTEGER NOT NULL CHECK (qty > 0),
    unit_cost  NUMERIC(12,2) NOT NULL,
    line_total NUMERIC(14,2) GENERATED ALWAYS AS (qty * unit_cost) STORED
);

CREATE INDEX idx_po_items_po ON purchase_order_items (po_id);

-- Stock movements (audit trail)
CREATE TABLE stock_movements (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    warehouse_id UUID NOT NULL REFERENCES warehouses (id),
    product_id   UUID NOT NULL REFERENCES products (id),
    movement_type VARCHAR(20) NOT NULL CHECK (movement_type IN ('receive', 'ship', 'adjust', 'transfer', 'return')),
    qty          INTEGER NOT NULL,
    reference_id UUID,
    reference_type VARCHAR(30),
    notes        TEXT,
    performed_by UUID,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_stock_movements_warehouse ON stock_movements (warehouse_id);
CREATE INDEX idx_stock_movements_product ON stock_movements (product_id);
CREATE INDEX idx_stock_movements_type ON stock_movements (movement_type);
CREATE INDEX idx_stock_movements_created ON stock_movements (created_at);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_warehouses_updated BEFORE UPDATE ON warehouses FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_suppliers_updated BEFORE UPDATE ON suppliers FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_products_updated BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_purchase_orders_updated BEFORE UPDATE ON purchase_orders FOR EACH ROW EXECUTE FUNCTION update_updated_at();
