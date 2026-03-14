-- {{APP_NAME}} Seed Data — Oracle

-- Departments
INSERT INTO departments (id, name, description) VALUES
    (HEXTORAW('D000000100004000A000000000000001'), 'Technical Support', 'Hardware and software troubleshooting');
INSERT INTO departments (id, name, description) VALUES
    (HEXTORAW('D000000100004000A000000000000002'), 'Billing', 'Invoices, payments, and refunds');
INSERT INTO departments (id, name, description) VALUES
    (HEXTORAW('D000000100004000A000000000000003'), 'Sales', 'Product inquiries and demos');

-- Agents
INSERT INTO agents (id, email, display_name, department_id, role) VALUES
    (HEXTORAW('A000000100004000A000000000000001'), 'alice@support.com', 'Alice Admin',   HEXTORAW('D000000100004000A000000000000001'), 'admin');
INSERT INTO agents (id, email, display_name, department_id, role) VALUES
    (HEXTORAW('A000000100004000A000000000000002'), 'bob@support.com',   'Bob Agent',     HEXTORAW('D000000100004000A000000000000001'), 'agent');
INSERT INTO agents (id, email, display_name, department_id, role) VALUES
    (HEXTORAW('A000000100004000A000000000000003'), 'carol@support.com', 'Carol Billing', HEXTORAW('D000000100004000A000000000000002'), 'agent');

-- Customers
INSERT INTO customers (id, email, name, company, phone) VALUES
    (HEXTORAW('C000000100004000A000000000000001'), 'john@acme.com',   'John Customer', 'Acme Corp',    '+1-555-0100');
INSERT INTO customers (id, email, name, company, phone) VALUES
    (HEXTORAW('C000000100004000A000000000000002'), 'jane@startup.io', 'Jane User',     'Startup Labs', '+1-555-0200');

-- Categories
INSERT INTO ticket_categories (id, name, slug) VALUES (HEXTORAW('CC00000100004000A000000000000001'), 'Bug Report',       'bug-report');
INSERT INTO ticket_categories (id, name, slug) VALUES (HEXTORAW('CC00000100004000A000000000000002'), 'Feature Request',  'feature-request');
INSERT INTO ticket_categories (id, name, slug) VALUES (HEXTORAW('CC00000100004000A000000000000003'), 'Account Issue',    'account-issue');
INSERT INTO ticket_categories (id, name, slug) VALUES (HEXTORAW('CC00000100004000A000000000000004'), 'Billing Question', 'billing-question');

-- SLA Policies
INSERT INTO sla_policies (id, name, priority, first_response_hrs, resolution_hrs) VALUES (HEXTORAW('5A00000100004000A000000000000001'), 'Critical SLA', 'critical', 1,  4);
INSERT INTO sla_policies (id, name, priority, first_response_hrs, resolution_hrs) VALUES (HEXTORAW('5A00000100004000A000000000000002'), 'High SLA',     'high',     2,  8);
INSERT INTO sla_policies (id, name, priority, first_response_hrs, resolution_hrs) VALUES (HEXTORAW('5A00000100004000A000000000000003'), 'Medium SLA',   'medium',   4,  24);
INSERT INTO sla_policies (id, name, priority, first_response_hrs, resolution_hrs) VALUES (HEXTORAW('5A00000100004000A000000000000004'), 'Low SLA',      'low',      8,  48);

-- Tickets
INSERT INTO tickets (id, ticket_number, customer_id, assigned_to, department_id, category_id, sla_policy_id, subject, description, status, priority, channel) VALUES
    (HEXTORAW('7000000100004000A000000000000001'), 'TKT-0001',
     HEXTORAW('C000000100004000A000000000000001'),
     HEXTORAW('A000000100004000A000000000000002'),
     HEXTORAW('D000000100004000A000000000000001'),
     HEXTORAW('CC00000100004000A000000000000001'),
     HEXTORAW('5A00000100004000A000000000000002'),
     'Login page returns 500 error',
     'After the latest update, clicking Sign In returns a 500 Internal Server Error.',
     'in_progress', 'high', 'web');
INSERT INTO tickets (id, ticket_number, customer_id, assigned_to, department_id, category_id, sla_policy_id, subject, description, status, priority, channel) VALUES
    (HEXTORAW('7000000100004000A000000000000002'), 'TKT-0002',
     HEXTORAW('C000000100004000A000000000000002'),
     NULL,
     HEXTORAW('D000000100004000A000000000000002'),
     HEXTORAW('CC00000100004000A000000000000004'),
     HEXTORAW('5A00000100004000A000000000000003'),
     'Invoice #1234 duplicate charge',
     'I was charged twice for my March subscription. Please refund the duplicate.',
     'open', 'medium', 'email');

-- Messages
INSERT INTO ticket_messages (ticket_id, sender_type, sender_id, body, is_internal) VALUES
    (HEXTORAW('7000000100004000A000000000000001'), 'customer', HEXTORAW('C000000100004000A000000000000001'), 'Login page returns 500 error after the latest update.', 0);
INSERT INTO ticket_messages (ticket_id, sender_type, sender_id, body, is_internal) VALUES
    (HEXTORAW('7000000100004000A000000000000001'), 'agent', HEXTORAW('A000000100004000A000000000000002'), 'Thanks for reporting. I can reproduce the issue. Looking into it now.', 0);
INSERT INTO ticket_messages (ticket_id, sender_type, sender_id, body, is_internal) VALUES
    (HEXTORAW('7000000100004000A000000000000001'), 'agent', HEXTORAW('A000000100004000A000000000000002'), 'Root cause: missing env var after deploy. Escalating to DevOps.', 1);

COMMIT;
