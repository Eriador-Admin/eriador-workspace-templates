-- {{APP_NAME}} E-Commerce Schema — Oracle

CREATE TABLE categories (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    slug VARCHAR2(120) NOT NULL UNIQUE,
    description CLOB,
    parent_id RAW(16),
    sort_order NUMBER(10) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_categories_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE products (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    slug VARCHAR2(280) NOT NULL UNIQUE,
    description CLOB,
    price NUMBER(12,2) NOT NULL CHECK (price >= 0),
    compare_at_price NUMBER(12,2) CHECK (compare_at_price >= 0),
    sku VARCHAR2(100) UNIQUE,
    stock_quantity NUMBER(10) DEFAULT 0 NOT NULL CHECK (stock_quantity >= 0),
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    category_id RAW(16),
    image_url VARCHAR2(2000),
    weight_grams NUMBER(10),
    metadata CLOB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE customers (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email VARCHAR2(255) NOT NULL UNIQUE,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(30),
    password_hash VARCHAR2(255) NOT NULL,
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE TABLE customer_addresses (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    customer_id RAW(16) NOT NULL,
    label VARCHAR2(50) DEFAULT 'home',
    address_line1 VARCHAR2(255) NOT NULL,
    address_line2 VARCHAR2(255),
    city VARCHAR2(100) NOT NULL,
    state VARCHAR2(100),
    postal_code VARCHAR2(20) NOT NULL,
    country VARCHAR2(2) NOT NULL,
    is_default NUMBER(1) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_addr_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    order_number VARCHAR2(30) NOT NULL UNIQUE,
    customer_id RAW(16) NOT NULL,
    status VARCHAR2(30) DEFAULT 'pending' NOT NULL CHECK (status IN ('pending','confirmed','processing','shipped','delivered','cancelled','refunded')),
    subtotal NUMBER(12,2) DEFAULT 0 NOT NULL,
    tax NUMBER(12,2) DEFAULT 0 NOT NULL,
    shipping_cost NUMBER(12,2) DEFAULT 0 NOT NULL,
    total NUMBER(12,2) DEFAULT 0 NOT NULL,
    shipping_address_id RAW(16),
    notes CLOB,
    placed_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    shipped_at TIMESTAMP WITH TIME ZONE,
    delivered_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT fk_orders_address FOREIGN KEY (shipping_address_id) REFERENCES customer_addresses(id) ON DELETE SET NULL
);

CREATE TABLE order_items (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    order_id RAW(16) NOT NULL,
    product_id RAW(16) NOT NULL,
    quantity NUMBER(10) NOT NULL CHECK (quantity > 0),
    unit_price NUMBER(12,2) NOT NULL,
    total_price NUMBER(12,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_reviews (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    product_id RAW(16) NOT NULL,
    customer_id RAW(16) NOT NULL,
    rating NUMBER(1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR2(200),
    body CLOB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_review_product_customer UNIQUE (product_id, customer_id),
    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_customer_addresses_customer ON customer_addresses(customer_id);
CREATE INDEX idx_product_reviews_product ON product_reviews(product_id);
CREATE INDEX idx_categories_parent ON categories(parent_id);

CREATE OR REPLACE TRIGGER trg_products_updated BEFORE UPDATE ON products FOR EACH ROW BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/
CREATE OR REPLACE TRIGGER trg_customers_updated BEFORE UPDATE ON customers FOR EACH ROW BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/
CREATE OR REPLACE TRIGGER trg_orders_updated BEFORE UPDATE ON orders FOR EACH ROW BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/
CREATE OR REPLACE TRIGGER trg_categories_updated BEFORE UPDATE ON categories FOR EACH ROW BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/
