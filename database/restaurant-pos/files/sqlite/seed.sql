-- {{APP_NAME}} Seed Data — SQLite

-- Menu categories
INSERT INTO menu_categories (id, name, sort_order) VALUES
    ('mc000001-0000-4000-a000-000000000001', 'Appetizers', 1),
    ('mc000001-0000-4000-a000-000000000002', 'Mains',      2),
    ('mc000001-0000-4000-a000-000000000003', 'Desserts',   3),
    ('mc000001-0000-4000-a000-000000000004', 'Beverages',  4);

-- Menu items
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    ('mi000001-0000-4000-a000-000000000001', 'mc000001-0000-4000-a000-000000000001', 'Bruschetta',       'Toasted bread with tomato, basil, and olive oil.',  8.50,  2.50,  10),
    ('mi000001-0000-4000-a000-000000000002', 'mc000001-0000-4000-a000-000000000001', 'Caesar Salad',     'Romaine lettuce with Caesar dressing and croutons.', 10.00, 3.00,  8),
    ('mi000001-0000-4000-a000-000000000003', 'mc000001-0000-4000-a000-000000000002', 'Grilled Salmon',   'Atlantic salmon with seasonal vegetables.',          22.00, 9.00,  20),
    ('mi000001-0000-4000-a000-000000000004', 'mc000001-0000-4000-a000-000000000002', 'Margherita Pizza', 'Classic tomato, mozzarella, and fresh basil.',       14.50, 4.00,  15),
    ('mi000001-0000-4000-a000-000000000005', 'mc000001-0000-4000-a000-000000000003', 'Tiramisu',         'Espresso-soaked ladyfingers with mascarpone cream.', 9.00,  3.50,  5),
    ('mi000001-0000-4000-a000-000000000006', 'mc000001-0000-4000-a000-000000000004', 'House Red Wine',   'Glass of Chianti Classico.',                         7.00,  2.00,  NULL);

-- Tables
INSERT INTO tables (id, label, capacity, section, status) VALUES
    ('tb000001-0000-4000-a000-000000000001', 'T1', 2, 'Window',  'available'),
    ('tb000001-0000-4000-a000-000000000002', 'T2', 4, 'Window',  'available'),
    ('tb000001-0000-4000-a000-000000000003', 'T3', 4, 'Main',    'available'),
    ('tb000001-0000-4000-a000-000000000004', 'T4', 6, 'Main',    'occupied'),
    ('tb000001-0000-4000-a000-000000000005', 'T5', 8, 'Private', 'available');

-- Staff
INSERT INTO staff (id, email, name, role) VALUES
    ('sf000001-0000-4000-a000-000000000001', 'marco@restaurant.com', 'Marco Manager', 'manager'),
    ('sf000001-0000-4000-a000-000000000002', 'sofia@restaurant.com', 'Sofia Waiter',  'waiter'),
    ('sf000001-0000-4000-a000-000000000003', 'luigi@restaurant.com', 'Luigi Chef',    'chef'),
    ('sf000001-0000-4000-a000-000000000004', 'anna@restaurant.com',  'Anna Cashier',  'cashier');

-- Reservations
INSERT INTO reservations (table_id, customer_name, customer_phone, party_size, reserved_at, status) VALUES
    ('tb000001-0000-4000-a000-000000000005', 'David Parker',  '+1-555-0300', 6, datetime('now', '+2 hours'), 'confirmed'),
    ('tb000001-0000-4000-a000-000000000002', 'Emily Roberts', '+1-555-0400', 3, datetime('now', '+4 hours'), 'confirmed');

-- Orders
INSERT INTO orders (id, table_id, server_id, order_type, status, subtotal, tax, tip, total) VALUES
    ('or000001-0000-4000-a000-000000000001',
     'tb000001-0000-4000-a000-000000000004',
     'sf000001-0000-4000-a000-000000000002',
     'dine_in', 'served', 45.00, 3.60, 7.00, 55.60);

-- Order items
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, status) VALUES
    ('or000001-0000-4000-a000-000000000001', 'mi000001-0000-4000-a000-000000000001', 1, 8.50,  'served'),
    ('or000001-0000-4000-a000-000000000001', 'mi000001-0000-4000-a000-000000000003', 1, 22.00, 'served'),
    ('or000001-0000-4000-a000-000000000001', 'mi000001-0000-4000-a000-000000000004', 1, 14.50, 'served');

-- Payment
INSERT INTO payments (order_id, method, amount, tip, status, processed_by) VALUES
    ('or000001-0000-4000-a000-000000000001', 'credit_card', 48.60, 7.00, 'completed', 'sf000001-0000-4000-a000-000000000004');
