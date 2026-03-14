-- {{APP_NAME}} Inventory Management Schema — MySQL

CREATE TABLE warehouses (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name       VARCHAR(200) NOT NULL,
    code       VARCHAR(20) NOT NULL UNIQUE,
    address    TEXT,
    city       VARCHAR(100),
    country    VARCHAR(100),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE suppliers (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name          VARCHAR(200) NOT NULL,
    code          VARCHAR(20) NOT NULL UNIQUE,
    contact_name  VARCHAR(200),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    address       TEXT,
    payment_terms INT DEFAULT 30,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE product_categories (
    id        CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    parent_id CHAR(36),
    name      VARCHAR(100) NOT NULL,
    slug      VARCHAR(120) NOT NULL UNIQUE,
    FOREIGN KEY (parent_id) REFERENCES product_categories (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE products (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    category_id   CHAR(36),
    sku           VARCHAR(50) NOT NULL UNIQUE,
    name          VARCHAR(300) NOT NULL,
    description   TEXT,
    unit          VARCHAR(20) NOT NULL DEFAULT 'pcs',
    unit_cost     DECIMAL(12,2) NOT NULL DEFAULT 0,
    unit_price    DECIMAL(12,2) NOT NULL DEFAULT 0,
    reorder_point INT NOT NULL DEFAULT 10,
    reorder_qty   INT NOT NULL DEFAULT 50,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES product_categories (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_products_sku ON products (sku);
CREATE INDEX idx_products_category ON products (category_id);

CREATE TABLE stock_levels (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    warehouse_id CHAR(36) NOT NULL,
    product_id   CHAR(36) NOT NULL,
    qty_on_hand  INT NOT NULL DEFAULT 0 CHECK (qty_on_hand >= 0),
    qty_reserved INT NOT NULL DEFAULT 0 CHECK (qty_reserved >= 0),
    qty_available INT GENERATED ALWAYS AS (qty_on_hand - qty_reserved) STORED,
    last_counted_at TIMESTAMP NULL,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_stock_warehouse_product (warehouse_id, product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE purchase_orders (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    po_number     VARCHAR(30) NOT NULL UNIQUE,
    supplier_id   CHAR(36) NOT NULL,
    warehouse_id  CHAR(36) NOT NULL,
    status        VARCHAR(20) NOT NULL DEFAULT 'draft',
    order_date    DATE NOT NULL DEFAULT (CURDATE()),
    expected_date DATE,
    total_amount  DECIMAL(14,2) NOT NULL DEFAULT 0,
    notes         TEXT,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses (id),
    CHECK (status IN ('draft', 'submitted', 'confirmed', 'shipped', 'received', 'cancelled'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_purchase_orders_supplier ON purchase_orders (supplier_id);
CREATE INDEX idx_purchase_orders_status ON purchase_orders (status);

CREATE TABLE purchase_order_items (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    po_id      CHAR(36) NOT NULL,
    product_id CHAR(36) NOT NULL,
    qty        INT NOT NULL CHECK (qty > 0),
    unit_cost  DECIMAL(12,2) NOT NULL,
    line_total DECIMAL(14,2) GENERATED ALWAYS AS (qty * unit_cost) STORED,
    FOREIGN KEY (po_id) REFERENCES purchase_orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE stock_movements (
    id             CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    warehouse_id   CHAR(36) NOT NULL,
    product_id     CHAR(36) NOT NULL,
    movement_type  VARCHAR(20) NOT NULL,
    qty            INT NOT NULL,
    reference_id   CHAR(36),
    reference_type VARCHAR(30),
    notes          TEXT,
    performed_by   CHAR(36),
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses (id),
    FOREIGN KEY (product_id) REFERENCES products (id),
    CHECK (movement_type IN ('receive', 'ship', 'adjust', 'transfer', 'return'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_stock_movements_warehouse ON stock_movements (warehouse_id);
CREATE INDEX idx_stock_movements_product ON stock_movements (product_id);
CREATE INDEX idx_stock_movements_type ON stock_movements (movement_type);
CREATE INDEX idx_stock_movements_created ON stock_movements (created_at);
