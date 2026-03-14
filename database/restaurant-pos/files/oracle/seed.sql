-- {{APP_NAME}} Seed Data — Oracle

-- Menu categories
INSERT INTO menu_categories (id, name, sort_order) VALUES (HEXTORAW('CA00000100004000A000000000000001'), 'Appetizers', 1);
INSERT INTO menu_categories (id, name, sort_order) VALUES (HEXTORAW('CA00000100004000A000000000000002'), 'Mains',      2);
INSERT INTO menu_categories (id, name, sort_order) VALUES (HEXTORAW('CA00000100004000A000000000000003'), 'Desserts',   3);
INSERT INTO menu_categories (id, name, sort_order) VALUES (HEXTORAW('CA00000100004000A000000000000004'), 'Beverages',  4);

-- Menu items
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000001'), HEXTORAW('CA00000100004000A000000000000001'), 'Bruschetta',       'Toasted bread with tomato, basil, and olive oil.',  8.50,  2.50,  10);
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000002'), HEXTORAW('CA00000100004000A000000000000001'), 'Caesar Salad',     'Romaine lettuce with Caesar dressing and croutons.', 10.00, 3.00,  8);
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000003'), HEXTORAW('CA00000100004000A000000000000002'), 'Grilled Salmon',   'Atlantic salmon with seasonal vegetables.',          22.00, 9.00,  20);
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000004'), HEXTORAW('CA00000100004000A000000000000002'), 'Margherita Pizza', 'Classic tomato, mozzarella, and fresh basil.',       14.50, 4.00,  15);
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000005'), HEXTORAW('CA00000100004000A000000000000003'), 'Tiramisu',         'Espresso-soaked ladyfingers with mascarpone cream.', 9.00,  3.50,  5);
INSERT INTO menu_items (id, category_id, name, description, price, cost, prep_time_min) VALUES
    (HEXTORAW('F100000100004000A000000000000006'), HEXTORAW('CA00000100004000A000000000000004'), 'House Red Wine',   'Glass of Chianti Classico.',                         7.00,  2.00,  NULL);

-- Dining tables
INSERT INTO dining_tables (id, label, capacity, section, status) VALUES (HEXTORAW('1B00000100004000A000000000000001'), 'T1', 2, 'Window',  'available');
INSERT INTO dining_tables (id, label, capacity, section, status) VALUES (HEXTORAW('1B00000100004000A000000000000002'), 'T2', 4, 'Window',  'available');
INSERT INTO dining_tables (id, label, capacity, section, status) VALUES (HEXTORAW('1B00000100004000A000000000000003'), 'T3', 4, 'Main',    'available');
INSERT INTO dining_tables (id, label, capacity, section, status) VALUES (HEXTORAW('1B00000100004000A000000000000004'), 'T4', 6, 'Main',    'occupied');
INSERT INTO dining_tables (id, label, capacity, section, status) VALUES (HEXTORAW('1B00000100004000A000000000000005'), 'T5', 8, 'Private', 'available');

-- Staff
INSERT INTO staff (id, email, name, role) VALUES (HEXTORAW('2B00000100004000A000000000000001'), 'marco@restaurant.com', 'Marco Manager', 'manager');
INSERT INTO staff (id, email, name, role) VALUES (HEXTORAW('2B00000100004000A000000000000002'), 'sofia@restaurant.com', 'Sofia Waiter',  'waiter');
INSERT INTO staff (id, email, name, role) VALUES (HEXTORAW('2B00000100004000A000000000000003'), 'luigi@restaurant.com', 'Luigi Chef',    'chef');
INSERT INTO staff (id, email, name, role) VALUES (HEXTORAW('2B00000100004000A000000000000004'), 'anna@restaurant.com',  'Anna Cashier',  'cashier');

-- Reservations
INSERT INTO reservations (table_id, customer_name, customer_phone, party_size, reserved_at, status) VALUES
    (HEXTORAW('1B00000100004000A000000000000005'), 'David Parker',  '+1-555-0300', 6, SYSTIMESTAMP + INTERVAL '2' HOUR, 'confirmed');
INSERT INTO reservations (table_id, customer_name, customer_phone, party_size, reserved_at, status) VALUES
    (HEXTORAW('1B00000100004000A000000000000002'), 'Emily Roberts', '+1-555-0400', 3, SYSTIMESTAMP + INTERVAL '4' HOUR, 'confirmed');

-- Orders
INSERT INTO orders (id, table_id, server_id, order_type, status, subtotal, tax, tip, total) VALUES
    (HEXTORAW('3B00000100004000A000000000000001'),
     HEXTORAW('1B00000100004000A000000000000004'),
     HEXTORAW('2B00000100004000A000000000000002'),
     'dine_in', 'served', 45.00, 3.60, 7.00, 55.60);

-- Order items
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, status) VALUES
    (HEXTORAW('3B00000100004000A000000000000001'), HEXTORAW('F100000100004000A000000000000001'), 1, 8.50,  'served');
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, status) VALUES
    (HEXTORAW('3B00000100004000A000000000000001'), HEXTORAW('F100000100004000A000000000000003'), 1, 22.00, 'served');
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, status) VALUES
    (HEXTORAW('3B00000100004000A000000000000001'), HEXTORAW('F100000100004000A000000000000004'), 1, 14.50, 'served');

-- Payment
INSERT INTO payments (order_id, method, amount, tip, status, processed_by) VALUES
    (HEXTORAW('3B00000100004000A000000000000001'), 'credit_card', 48.60, 7.00, 'completed', HEXTORAW('2B00000100004000A000000000000004'));

COMMIT;
