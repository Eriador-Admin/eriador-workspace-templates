-- {{APP_NAME}} Restaurant POS Schema — MySQL

-- Menu categories
CREATE TABLE menu_categories (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name       VARCHAR(100) NOT NULL UNIQUE,
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Menu items
CREATE TABLE menu_items (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    category_id  CHAR(36) NOT NULL,
    name         VARCHAR(200) NOT NULL,
    description  TEXT,
    price        DECIMAL(10,2) NOT NULL,
    cost         DECIMAL(10,2),
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    prep_time_min INTEGER,
    allergens    JSON DEFAULT ('[]'),
    image_url    VARCHAR(500),
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES menu_categories (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_menu_items_category ON menu_items (category_id);

-- Dining tables
CREATE TABLE `tables` (
    id       CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    label    VARCHAR(20) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL DEFAULT 4,
    section  VARCHAR(50),
    status   ENUM('available', 'occupied', 'reserved', 'cleaning') NOT NULL DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Staff
CREATE TABLE staff (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    role       ENUM('manager', 'chef', 'waiter', 'cashier', 'host') NOT NULL DEFAULT 'waiter',
    pin_hash   VARCHAR(255),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Reservations
CREATE TABLE reservations (
    id             CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    table_id       CHAR(36),
    customer_name  VARCHAR(200) NOT NULL,
    customer_phone VARCHAR(50),
    party_size     INTEGER NOT NULL DEFAULT 2,
    reserved_at    TIMESTAMP NOT NULL,
    status         ENUM('confirmed', 'seated', 'completed', 'cancelled', 'no_show') NOT NULL DEFAULT 'confirmed',
    notes          TEXT,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES `tables` (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_reservations_table ON reservations (table_id);
CREATE INDEX idx_reservations_date ON reservations (reserved_at);

-- Orders
CREATE TABLE orders (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    table_id   CHAR(36),
    server_id  CHAR(36) NOT NULL,
    order_type ENUM('dine_in', 'takeout', 'delivery') NOT NULL DEFAULT 'dine_in',
    status     ENUM('open', 'preparing', 'served', 'closed', 'cancelled') NOT NULL DEFAULT 'open',
    subtotal   DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    tax        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    tip        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    notes      TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES `tables` (id),
    FOREIGN KEY (server_id) REFERENCES staff (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_orders_table ON orders (table_id);
CREATE INDEX idx_orders_server ON orders (server_id);
CREATE INDEX idx_orders_status ON orders (status);

-- Order items
CREATE TABLE order_items (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    order_id     CHAR(36) NOT NULL,
    menu_item_id CHAR(36) NOT NULL,
    quantity     INTEGER NOT NULL DEFAULT 1,
    unit_price   DECIMAL(10,2) NOT NULL,
    modifiers    JSON DEFAULT ('[]'),
    notes        TEXT,
    status       ENUM('pending', 'preparing', 'ready', 'served', 'cancelled') NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_order_items_order ON order_items (order_id);

-- Payments
CREATE TABLE payments (
    id              CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    order_id        CHAR(36) NOT NULL,
    method          ENUM('cash', 'credit_card', 'debit_card', 'mobile_pay', 'gift_card') NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    tip             DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    transaction_ref VARCHAR(100),
    status          ENUM('completed', 'refunded', 'failed') NOT NULL DEFAULT 'completed',
    processed_by    CHAR(36),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (processed_by) REFERENCES staff (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_payments_order ON payments (order_id);
