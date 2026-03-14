-- {{APP_NAME}} Seed Data — SQLite

INSERT INTO warehouses (name, code, address, city, country) VALUES
    ('Main Warehouse',  'WH-MAIN', '100 Industrial Blvd', 'Austin',  'US'),
    ('East Distribution', 'WH-EAST', '200 Logistics Pkwy', 'Atlanta', 'US');

INSERT INTO suppliers (name, code, contact_name, contact_email, payment_terms) VALUES
    ('Acme Supplies',  'SUP-ACME',  'John Doe',   'john@acmesupplies.com',  30),
    ('Global Parts Co', 'SUP-GLOB', 'Jane Smith', 'jane@globalparts.com',    45);

INSERT INTO product_categories (id, name, slug) VALUES
    ('cc000000-0000-0000-0000-000000000001', 'Electronics',     'electronics'),
    ('cc000000-0000-0000-0000-000000000002', 'Office Supplies', 'office-supplies'),
    ('cc000000-0000-0000-0000-000000000003', 'Raw Materials',   'raw-materials');

INSERT INTO products (sku, name, category_id, unit, unit_cost, unit_price, reorder_point, reorder_qty) VALUES
    ('ELEC-001', 'USB-C Cable 2m',       'cc000000-0000-0000-0000-000000000001', 'pcs',  2.50,  9.99,  50,  200),
    ('ELEC-002', 'Wireless Mouse',        'cc000000-0000-0000-0000-000000000001', 'pcs',  8.00,  24.99, 30,  100),
    ('OFFC-001', 'A4 Paper (500 sheets)', 'cc000000-0000-0000-0000-000000000002', 'ream', 3.20,  7.99,  100, 500),
    ('RAW-001',  'Steel Rod 10mm',        'cc000000-0000-0000-0000-000000000003', 'kg',   1.80,  4.50,  200, 1000);

INSERT INTO stock_levels (warehouse_id, product_id, qty_on_hand, qty_reserved)
SELECT w.id, p.id, 150, 10 FROM warehouses w, products p WHERE w.code = 'WH-MAIN' AND p.sku = 'ELEC-001';

INSERT INTO stock_levels (warehouse_id, product_id, qty_on_hand, qty_reserved)
SELECT w.id, p.id, 75, 5 FROM warehouses w, products p WHERE w.code = 'WH-MAIN' AND p.sku = 'ELEC-002';

INSERT INTO stock_levels (warehouse_id, product_id, qty_on_hand, qty_reserved)
SELECT w.id, p.id, 400, 0 FROM warehouses w, products p WHERE w.code = 'WH-MAIN' AND p.sku = 'OFFC-001';

INSERT INTO purchase_orders (po_number, supplier_id, warehouse_id, status, expected_date, total_amount)
SELECT 'PO-2026-001', s.id, w.id, 'confirmed', date('now', '+14 days'), 500.00
FROM suppliers s, warehouses w WHERE s.code = 'SUP-ACME' AND w.code = 'WH-MAIN';

INSERT INTO purchase_order_items (po_id, product_id, qty, unit_cost)
SELECT po.id, p.id, 200, 2.50 FROM purchase_orders po, products p WHERE po.po_number = 'PO-2026-001' AND p.sku = 'ELEC-001';
