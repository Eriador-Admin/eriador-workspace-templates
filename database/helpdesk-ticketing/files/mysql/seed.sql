-- {{APP_NAME}} Seed Data — MySQL

-- Departments
INSERT INTO departments (name, description) VALUES
    ('Technical Support', 'Hardware and software troubleshooting'),
    ('Billing',           'Invoices, payments, and refunds'),
    ('Sales',             'Product inquiries and demos');

-- Agents
INSERT INTO agents (email, display_name, department_id, role) VALUES
    ('alice@support.com', 'Alice Admin',    (SELECT id FROM departments WHERE name = 'Technical Support'), 'admin'),
    ('bob@support.com',   'Bob Agent',      (SELECT id FROM departments WHERE name = 'Technical Support'), 'agent'),
    ('carol@support.com', 'Carol Billing',  (SELECT id FROM departments WHERE name = 'Billing'), 'agent');

-- Customers
INSERT INTO customers (email, name, company, phone) VALUES
    ('john@acme.com',  'John Customer', 'Acme Corp',    '+1-555-0100'),
    ('jane@startup.io', 'Jane User',    'Startup Labs', '+1-555-0200');

-- Categories
INSERT INTO ticket_categories (name, slug) VALUES
    ('Bug Report',       'bug-report'),
    ('Feature Request',  'feature-request'),
    ('Account Issue',    'account-issue'),
    ('Billing Question', 'billing-question');

-- SLA Policies
INSERT INTO sla_policies (name, priority, first_response_hrs, resolution_hrs) VALUES
    ('Critical SLA', 'critical', 1,  4),
    ('High SLA',     'high',     2,  8),
    ('Medium SLA',   'medium',   4,  24),
    ('Low SLA',      'low',      8,  48);

-- Tickets
INSERT INTO tickets (ticket_number, customer_id, assigned_to, department_id, category_id, sla_policy_id, subject, description, status, priority, channel) VALUES
    ('TKT-0001',
     (SELECT id FROM customers WHERE email = 'john@acme.com'),
     (SELECT id FROM agents WHERE email = 'bob@support.com'),
     (SELECT id FROM departments WHERE name = 'Technical Support'),
     (SELECT id FROM ticket_categories WHERE slug = 'bug-report'),
     (SELECT id FROM sla_policies WHERE name = 'High SLA'),
     'Login page returns 500 error',
     'After the latest update, clicking "Sign In" returns a 500 Internal Server Error. Tested in Chrome and Firefox.',
     'in_progress', 'high', 'web'),
    ('TKT-0002',
     (SELECT id FROM customers WHERE email = 'jane@startup.io'),
     NULL,
     (SELECT id FROM departments WHERE name = 'Billing'),
     (SELECT id FROM ticket_categories WHERE slug = 'billing-question'),
     (SELECT id FROM sla_policies WHERE name = 'Medium SLA'),
     'Invoice #1234 duplicate charge',
     'I was charged twice for my March subscription. Please refund the duplicate.',
     'open', 'medium', 'email');

-- Messages
INSERT INTO ticket_messages (ticket_id, sender_type, sender_id, body, is_internal) VALUES
    ((SELECT id FROM tickets WHERE ticket_number = 'TKT-0001'), 'customer', (SELECT id FROM customers WHERE email = 'john@acme.com'), 'Login page returns 500 error after the latest update.', FALSE),
    ((SELECT id FROM tickets WHERE ticket_number = 'TKT-0001'), 'agent', (SELECT id FROM agents WHERE email = 'bob@support.com'), 'Thanks for reporting. I can reproduce the issue. Looking into it now.', FALSE),
    ((SELECT id FROM tickets WHERE ticket_number = 'TKT-0001'), 'agent', (SELECT id FROM agents WHERE email = 'bob@support.com'), 'Root cause: missing env var after deploy. Escalating to DevOps.', TRUE);
