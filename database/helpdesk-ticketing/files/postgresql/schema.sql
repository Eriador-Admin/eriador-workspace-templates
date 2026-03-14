-- {{APP_NAME}} Helpdesk Ticketing Schema — PostgreSQL

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Departments
CREATE TABLE departments (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Agents (support staff)
CREATE TABLE agents (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    department_id UUID REFERENCES departments (id),
    email         VARCHAR(255) NOT NULL UNIQUE,
    display_name  VARCHAR(200) NOT NULL,
    role          VARCHAR(20) NOT NULL DEFAULT 'agent' CHECK (role IN ('admin', 'supervisor', 'agent')),
    is_available  BOOLEAN NOT NULL DEFAULT TRUE,
    max_tickets   INTEGER NOT NULL DEFAULT 20,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_agents_department ON agents (department_id);

-- Customers
CREATE TABLE customers (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    company    VARCHAR(200),
    phone      VARCHAR(50),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Ticket categories
CREATE TABLE ticket_categories (
    id        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    parent_id UUID REFERENCES ticket_categories (id),
    name      VARCHAR(100) NOT NULL,
    slug      VARCHAR(120) NOT NULL UNIQUE
);

-- SLA policies
CREATE TABLE sla_policies (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name                VARCHAR(100) NOT NULL UNIQUE,
    description         TEXT,
    first_response_hrs  INTEGER NOT NULL DEFAULT 4,
    resolution_hrs      INTEGER NOT NULL DEFAULT 24,
    priority            VARCHAR(10) NOT NULL CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    is_active           BOOLEAN NOT NULL DEFAULT TRUE
);

-- Tickets
CREATE TABLE tickets (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticket_number VARCHAR(20) NOT NULL UNIQUE,
    customer_id   UUID NOT NULL REFERENCES customers (id),
    assigned_to   UUID REFERENCES agents (id),
    department_id UUID REFERENCES departments (id),
    category_id   UUID REFERENCES ticket_categories (id),
    sla_policy_id UUID REFERENCES sla_policies (id),
    subject       VARCHAR(500) NOT NULL,
    description   TEXT NOT NULL,
    status        VARCHAR(20) NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'waiting', 'resolved', 'closed')),
    priority      VARCHAR(10) NOT NULL DEFAULT 'medium' CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    channel       VARCHAR(20) NOT NULL DEFAULT 'web' CHECK (channel IN ('web', 'email', 'phone', 'chat', 'api')),
    tags          JSONB DEFAULT '[]',
    first_response_at TIMESTAMPTZ,
    resolved_at   TIMESTAMPTZ,
    closed_at     TIMESTAMPTZ,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_tickets_customer ON tickets (customer_id);
CREATE INDEX idx_tickets_assigned ON tickets (assigned_to);
CREATE INDEX idx_tickets_status ON tickets (status);
CREATE INDEX idx_tickets_priority ON tickets (priority);
CREATE INDEX idx_tickets_created ON tickets (created_at);

-- Ticket messages (threaded conversation)
CREATE TABLE ticket_messages (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticket_id  UUID NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    sender_type VARCHAR(10) NOT NULL CHECK (sender_type IN ('customer', 'agent', 'system')),
    sender_id  UUID NOT NULL,
    body       TEXT NOT NULL,
    is_internal BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ticket_messages_ticket ON ticket_messages (ticket_id);

-- Ticket attachments
CREATE TABLE ticket_attachments (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticket_id  UUID NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    message_id UUID REFERENCES ticket_messages (id) ON DELETE CASCADE,
    file_name  VARCHAR(255) NOT NULL,
    file_path  VARCHAR(500) NOT NULL,
    mime_type  VARCHAR(100) NOT NULL,
    file_size  BIGINT NOT NULL,
    uploaded_by UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ticket_attachments_ticket ON ticket_attachments (ticket_id);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_agents_updated BEFORE UPDATE ON agents FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_customers_updated BEFORE UPDATE ON customers FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_tickets_updated BEFORE UPDATE ON tickets FOR EACH ROW EXECUTE FUNCTION update_updated_at();
