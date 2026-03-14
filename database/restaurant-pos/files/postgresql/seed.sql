-- {{APP_NAME}} Seed Data — PostgreSQL

-- Menu categories
INSERT INTO menu_categories (name, sort_order) VALUES
    ('Appetizers', 1),
    ('Mains',      2),
    ('Desserts',   3),
    ('Beverages',  4);

-- Menu items
INSERT INTO menu_items (category_id, name, description, price, cost, prep_time_min) VALUES
    ((SELECT id FROM menu_categories WHERE name = 'Appetizers'), 'Bruschetta',       'Toasted bread with tomato, basil, and olive oil.',  8.50,  2.50,  10),
    ((SELECT id FROM menu_categories WHERE name = 'Appetizers'), 'Caesar Salad',     'Romaine lettuce with Caesar dressing and croutons.', 10.00, 3.00,  8),
    ((SELECT id FROM menu_categories WHERE name = 'Mains'),      'Grilled Salmon',   'Atlantic salmon with seasonal vegetables.',          22.00, 9.00,  20),
    ((SELECT id FROM menu_categories WHERE name = 'Mains'),      'Margherita Pizza', 'Classic tomato, mozzarella, and fresh basil.',       14.50, 4.00,  15),
    ((SELECT id FROM menu_categories WHERE name = 'Desserts'),   'Tiramisu',         'Espresso-soaked ladyfingers with mascarpone cream.', 9.00,  3.50,  5),
    ((SELECT id FROM menu_categories WHERE name = 'Beverages'),  'House Red Wine',   'Glass of Chianti Classico.',                         7.00,  2.00,  NULL);

-- Tables
INSERT INTO tables (label, capacity, section, status) VALUES
    ('T1', 2, 'Window',  'available'),
    ('T2', 4, 'Window',  'available'),
    ('T3', 4, 'Main',    'available'),
    ('T4', 6, 'Main',    'occupied'),
    ('T5', 8, 'Private', 'available');

-- Staff
INSERT INTO staff (email, name, role) VALUES
    ('marco@restaurant.com',  'Marco Manager', 'manager'),
    ('sofia@restaurant.com',  'Sofia Waiter',  'waiter'),
    ('luigi@restaurant.com',  'Luigi Chef',    'chef'),
    ('anna@restaurant.com',   'Anna Cashier',  'cashier');

-- Reservations
INSERT INTO reservations (table_id, customer_name, customer_phone, party_size, reserved_at, status) VALUES
    ((SELECT id FROM tables WHERE label = 'T5'), 'David Parker',  '+1-555-0300', 6, NOW() + INTERVAL '2 hours', 'confirmed'),
    ((SELECT id FROM tables WHERE label = 'T2'), 'Emily Roberts', '+1-555-0400', 3, NOW() + INTERVAL '4 hours', 'confirmed');

-- Orders
INSERT INTO orders (id, table_id, server_id, order_type, status, subtotal, tax, tip, total) VALUES
    (uuid_generate_v4(),
     (SELECT id FROM tables WHERE label = 'T4'),
     (SELECT id FROM staff WHERE email = 'sofia@restaurant.com'),
     'dine_in', 'served', 45.00, 3.60, 7.00, 55.60);

-- Order items
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, status) VALUES
    ((SELECT id FROM orders LIMIT 1), (SELECT id FROM menu_items WHERE name = 'Bruschetta'),       1, 8.50,  'served'),
    ((SELECT id FROM orders LIMIT 1), (SELECT id FROM menu_items WHERE name = 'Grilled Salmon'),   1, 22.00, 'served'),
    ((SELECT id FROM orders LIMIT 1), (SELECT id FROM menu_items WHERE name = 'Margherita Pizza'), 1, 14.50, 'served');

-- Payment
INSERT INTO payments (order_id, method, amount, tip, status, processed_by) VALUES
    ((SELECT id FROM orders LIMIT 1), 'credit_card', 48.60, 7.00, 'completed',
     (SELECT id FROM staff WHERE email = 'anna@restaurant.com'));
