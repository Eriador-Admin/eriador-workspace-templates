-- {{APP_NAME}} Seed Data — SQLite

-- Departments
INSERT INTO departments (id, name, description) VALUES
    ('d0000001-0000-4000-a000-000000000001', 'Technical Support', 'Hardware and software troubleshooting'),
    ('d0000001-0000-4000-a000-000000000002', 'Billing',           'Invoices, payments, and refunds'),
    ('d0000001-0000-4000-a000-000000000003', 'Sales',             'Product inquiries and demos');

-- Agents
INSERT INTO agents (id, email, display_name, department_id, role) VALUES
    ('a0000001-0000-4000-a000-000000000001', 'alice@support.com', 'Alice Admin',   'd0000001-0000-4000-a000-000000000001', 'admin'),
    ('a0000001-0000-4000-a000-000000000002', 'bob@support.com',   'Bob Agent',     'd0000001-0000-4000-a000-000000000001', 'agent'),
    ('a0000001-0000-4000-a000-000000000003', 'carol@support.com', 'Carol Billing', 'd0000001-0000-4000-a000-000000000002', 'agent');

-- Customers
INSERT INTO customers (id, email, name, company, phone) VALUES
    ('c0000001-0000-4000-a000-000000000001', 'john@acme.com',   'John Customer', 'Acme Corp',    '+1-555-0100'),
    ('c0000001-0000-4000-a000-000000000002', 'jane@startup.io', 'Jane User',     'Startup Labs', '+1-555-0200');

-- Categories
INSERT INTO ticket_categories (id, name, slug) VALUES
    ('tc000001-0000-4000-a000-000000000001', 'Bug Report',       'bug-report'),
    ('tc000001-0000-4000-a000-000000000002', 'Feature Request',  'feature-request'),
    ('tc000001-0000-4000-a000-000000000003', 'Account Issue',    'account-issue'),
    ('tc000001-0000-4000-a000-000000000004', 'Billing Question', 'billing-question');

-- SLA Policies
INSERT INTO sla_policies (id, name, priority, first_response_hrs, resolution_hrs) VALUES
    ('sl000001-0000-4000-a000-000000000001', 'Critical SLA', 'critical', 1,  4),
    ('sl000001-0000-4000-a000-000000000002', 'High SLA',     'high',     2,  8),
    ('sl000001-0000-4000-a000-000000000003', 'Medium SLA',   'medium',   4,  24),
    ('sl000001-0000-4000-a000-000000000004', 'Low SLA',      'low',      8,  48);

-- Tickets
INSERT INTO tickets (id, ticket_number, customer_id, assigned_to, department_id, category_id, sla_policy_id, subject, description, status, priority, channel) VALUES
    ('t0000001-0000-4000-a000-000000000001', 'TKT-0001',
     'c0000001-0000-4000-a000-000000000001',
     'a0000001-0000-4000-a000-000000000002',
     'd0000001-0000-4000-a000-000000000001',
     'tc000001-0000-4000-a000-000000000001',
     'sl000001-0000-4000-a000-000000000002',
     'Login page returns 500 error',
     'After the latest update, clicking "Sign In" returns a 500 Internal Server Error.',
     'in_progress', 'high', 'web'),
    ('t0000001-0000-4000-a000-000000000002', 'TKT-0002',
     'c0000001-0000-4000-a000-000000000002',
     NULL,
     'd0000001-0000-4000-a000-000000000002',
     'tc000001-0000-4000-a000-000000000004',
     'sl000001-0000-4000-a000-000000000003',
     'Invoice #1234 duplicate charge',
     'I was charged twice for my March subscription. Please refund the duplicate.',
     'open', 'medium', 'email');

-- Messages
INSERT INTO ticket_messages (ticket_id, sender_type, sender_id, body, is_internal) VALUES
    ('t0000001-0000-4000-a000-000000000001', 'customer', 'c0000001-0000-4000-a000-000000000001', 'Login page returns 500 error after the latest update.', 0),
    ('t0000001-0000-4000-a000-000000000001', 'agent',    'a0000001-0000-4000-a000-000000000002', 'Thanks for reporting. I can reproduce the issue. Looking into it now.', 0),
    ('t0000001-0000-4000-a000-000000000001', 'agent',    'a0000001-0000-4000-a000-000000000002', 'Root cause: missing env var after deploy. Escalating to DevOps.', 1);
