-- {{APP_NAME}} Seed Data — PostgreSQL

INSERT INTO categories (name, slug, description, sort_order) VALUES
    ('Electronics', 'electronics', 'Gadgets, devices, and accessories', 1),
    ('Clothing', 'clothing', 'Apparel and fashion', 2),
    ('Books', 'books', 'Physical and digital books', 3);

INSERT INTO products (name, slug, description, price, compare_at_price, sku, stock_quantity, category_id, weight_grams) VALUES
    ('Wireless Headphones', 'wireless-headphones', 'Noise-cancelling Bluetooth headphones', 79.99, 99.99, 'ELEC-001', 150, (SELECT id FROM categories WHERE slug = 'electronics'), 250),
    ('USB-C Charger', 'usb-c-charger', '65W fast charger with GaN technology', 34.99, NULL, 'ELEC-002', 300, (SELECT id FROM categories WHERE slug = 'electronics'), 120),
    ('Cotton T-Shirt', 'cotton-tshirt', '100% organic cotton, unisex fit', 24.99, 29.99, 'CLO-001', 500, (SELECT id FROM categories WHERE slug = 'clothing'), 200),
    ('Denim Jacket', 'denim-jacket', 'Classic denim jacket, all seasons', 89.99, NULL, 'CLO-002', 75, (SELECT id FROM categories WHERE slug = 'clothing'), 800),
    ('SQL Cookbook', 'sql-cookbook', 'Practical SQL recipes for developers', 44.99, NULL, 'BOOK-001', 200, (SELECT id FROM categories WHERE slug = 'books'), 450);

INSERT INTO customers (email, first_name, last_name, phone, password_hash) VALUES
    ('alice@example.com', 'Alice', 'Johnson', '+1-555-0101', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W'),
    ('charlie@example.com', 'Charlie', 'Brown', '+1-555-0102', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W');

INSERT INTO customer_addresses (customer_id, label, address_line1, city, state, postal_code, country, is_default) VALUES
    ((SELECT id FROM customers WHERE email = 'alice@example.com'), 'home', '123 Main St', 'Springfield', 'IL', '62701', 'US', TRUE),
    ((SELECT id FROM customers WHERE email = 'charlie@example.com'), 'home', '456 Oak Ave', 'Portland', 'OR', '97201', 'US', TRUE);
