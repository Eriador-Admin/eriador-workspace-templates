-- {{APP_NAME}} Helpdesk Ticketing Schema — SQLite

-- Departments
CREATE TABLE departments (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    name        TEXT NOT NULL UNIQUE,
    description TEXT,
    is_active   INTEGER NOT NULL DEFAULT 1,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Agents
CREATE TABLE agents (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    department_id TEXT REFERENCES departments (id),
    email         TEXT NOT NULL UNIQUE,
    display_name  TEXT NOT NULL,
    role          TEXT NOT NULL DEFAULT 'agent' CHECK (role IN ('admin', 'supervisor', 'agent')),
    is_available  INTEGER NOT NULL DEFAULT 1,
    max_tickets   INTEGER NOT NULL DEFAULT 20,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_agents_department ON agents (department_id);

CREATE TRIGGER trg_agents_updated AFTER UPDATE ON agents
BEGIN UPDATE agents SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Customers
CREATE TABLE customers (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    email      TEXT NOT NULL UNIQUE,
    name       TEXT NOT NULL,
    company    TEXT,
    phone      TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_customers_updated AFTER UPDATE ON customers
BEGIN UPDATE customers SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Ticket categories
CREATE TABLE ticket_categories (
    id        TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    parent_id TEXT REFERENCES ticket_categories (id),
    name      TEXT NOT NULL,
    slug      TEXT NOT NULL UNIQUE
);

-- SLA policies
CREATE TABLE sla_policies (
    id                  TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    name                TEXT NOT NULL UNIQUE,
    description         TEXT,
    first_response_hrs  INTEGER NOT NULL DEFAULT 4,
    resolution_hrs      INTEGER NOT NULL DEFAULT 24,
    priority            TEXT NOT NULL CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    is_active           INTEGER NOT NULL DEFAULT 1
);

-- Tickets
CREATE TABLE tickets (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    ticket_number TEXT NOT NULL UNIQUE,
    customer_id   TEXT NOT NULL REFERENCES customers (id),
    assigned_to   TEXT REFERENCES agents (id),
    department_id TEXT REFERENCES departments (id),
    category_id   TEXT REFERENCES ticket_categories (id),
    sla_policy_id TEXT REFERENCES sla_policies (id),
    subject       TEXT NOT NULL,
    description   TEXT NOT NULL,
    status        TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'waiting', 'resolved', 'closed')),
    priority      TEXT NOT NULL DEFAULT 'medium' CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    channel       TEXT NOT NULL DEFAULT 'web' CHECK (channel IN ('web', 'email', 'phone', 'chat', 'api')),
    tags          TEXT DEFAULT '[]',
    first_response_at TEXT,
    resolved_at   TEXT,
    closed_at     TEXT,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_tickets_customer ON tickets (customer_id);
CREATE INDEX idx_tickets_assigned ON tickets (assigned_to);
CREATE INDEX idx_tickets_status ON tickets (status);
CREATE INDEX idx_tickets_priority ON tickets (priority);
CREATE INDEX idx_tickets_created ON tickets (created_at);

CREATE TRIGGER trg_tickets_updated AFTER UPDATE ON tickets
BEGIN UPDATE tickets SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Ticket messages
CREATE TABLE ticket_messages (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    ticket_id   TEXT NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    sender_type TEXT NOT NULL CHECK (sender_type IN ('customer', 'agent', 'system')),
    sender_id   TEXT NOT NULL,
    body        TEXT NOT NULL,
    is_internal INTEGER NOT NULL DEFAULT 0,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_ticket_messages_ticket ON ticket_messages (ticket_id);

-- Ticket attachments
CREATE TABLE ticket_attachments (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    ticket_id   TEXT NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    message_id  TEXT REFERENCES ticket_messages (id) ON DELETE CASCADE,
    file_name   TEXT NOT NULL,
    file_path   TEXT NOT NULL,
    mime_type   TEXT NOT NULL,
    file_size   INTEGER NOT NULL,
    uploaded_by TEXT NOT NULL,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_ticket_attachments_ticket ON ticket_attachments (ticket_id);
