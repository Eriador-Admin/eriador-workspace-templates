-- {{APP_NAME}} Inventory Management Schema — Oracle

CREATE TABLE warehouses (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name       VARCHAR2(200) NOT NULL,
    code       VARCHAR2(20) NOT NULL UNIQUE,
    address    VARCHAR2(500),
    city       VARCHAR2(100),
    country    VARCHAR2(100),
    is_active  NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_warehouses_upd BEFORE UPDATE ON warehouses FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE suppliers (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name          VARCHAR2(200) NOT NULL,
    code          VARCHAR2(20) NOT NULL UNIQUE,
    contact_name  VARCHAR2(200),
    contact_email VARCHAR2(255),
    contact_phone VARCHAR2(50),
    address       VARCHAR2(500),
    payment_terms NUMBER(10) DEFAULT 30,
    is_active     NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_suppliers_upd BEFORE UPDATE ON suppliers FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE product_categories (
    id        RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    parent_id RAW(16) REFERENCES product_categories (id),
    name      VARCHAR2(100) NOT NULL,
    slug      VARCHAR2(120) NOT NULL UNIQUE
);

CREATE TABLE products (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    category_id   RAW(16) REFERENCES product_categories (id),
    sku           VARCHAR2(50) NOT NULL UNIQUE,
    name          VARCHAR2(300) NOT NULL,
    description   CLOB,
    unit          VARCHAR2(20) DEFAULT 'pcs' NOT NULL,
    unit_cost     NUMBER(12,2) DEFAULT 0 NOT NULL,
    unit_price    NUMBER(12,2) DEFAULT 0 NOT NULL,
    reorder_point NUMBER(10) DEFAULT 10 NOT NULL,
    reorder_qty   NUMBER(10) DEFAULT 50 NOT NULL,
    is_active     NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_products_upd BEFORE UPDATE ON products FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE stock_levels (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    warehouse_id  RAW(16) NOT NULL REFERENCES warehouses (id) ON DELETE CASCADE,
    product_id    RAW(16) NOT NULL REFERENCES products (id) ON DELETE CASCADE,
    qty_on_hand   NUMBER(10) DEFAULT 0 NOT NULL CHECK (qty_on_hand >= 0),
    qty_reserved  NUMBER(10) DEFAULT 0 NOT NULL CHECK (qty_reserved >= 0),
    last_counted_at TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_stock_wh_prod UNIQUE (warehouse_id, product_id)
);

CREATE TABLE purchase_orders (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    po_number     VARCHAR2(30) NOT NULL UNIQUE,
    supplier_id   RAW(16) NOT NULL REFERENCES suppliers (id),
    warehouse_id  RAW(16) NOT NULL REFERENCES warehouses (id),
    status        VARCHAR2(20) DEFAULT 'draft' NOT NULL CHECK (status IN ('draft', 'submitted', 'confirmed', 'shipped', 'received', 'cancelled')),
    order_date    DATE DEFAULT SYSDATE NOT NULL,
    expected_date DATE,
    total_amount  NUMBER(14,2) DEFAULT 0 NOT NULL,
    notes         CLOB,
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_po_upd BEFORE UPDATE ON purchase_orders FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE purchase_order_items (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    po_id      RAW(16) NOT NULL REFERENCES purchase_orders (id) ON DELETE CASCADE,
    product_id RAW(16) NOT NULL REFERENCES products (id),
    qty        NUMBER(10) NOT NULL CHECK (qty > 0),
    unit_cost  NUMBER(12,2) NOT NULL
);

CREATE TABLE stock_movements (
    id             RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    warehouse_id   RAW(16) NOT NULL REFERENCES warehouses (id),
    product_id     RAW(16) NOT NULL REFERENCES products (id),
    movement_type  VARCHAR2(20) NOT NULL CHECK (movement_type IN ('receive', 'ship', 'adjust', 'transfer', 'return')),
    qty            NUMBER(10) NOT NULL,
    reference_id   RAW(16),
    reference_type VARCHAR2(30),
    notes          CLOB,
    performed_by   RAW(16),
    created_at     TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_stk_mv_wh ON stock_movements (warehouse_id);
CREATE INDEX idx_stk_mv_prod ON stock_movements (product_id);
CREATE INDEX idx_stk_mv_type ON stock_movements (movement_type);
