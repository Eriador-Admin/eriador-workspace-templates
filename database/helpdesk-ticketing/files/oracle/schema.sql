-- {{APP_NAME}} Helpdesk Ticketing Schema — Oracle

-- Departments
CREATE TABLE departments (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(100) NOT NULL UNIQUE,
    description CLOB,
    is_active   NUMBER(1) DEFAULT 1 NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

-- Agents
CREATE TABLE agents (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    department_id RAW(16) REFERENCES departments (id),
    email         VARCHAR2(255) NOT NULL UNIQUE,
    display_name  VARCHAR2(200) NOT NULL,
    role          VARCHAR2(20) DEFAULT 'agent' NOT NULL CHECK (role IN ('admin', 'supervisor', 'agent')),
    is_available  NUMBER(1) DEFAULT 1 NOT NULL,
    max_tickets   NUMBER(5) DEFAULT 20 NOT NULL,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_agents_department ON agents (department_id);

CREATE OR REPLACE TRIGGER trg_agents_updated
BEFORE UPDATE ON agents FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Customers
CREATE TABLE customers (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email      VARCHAR2(255) NOT NULL UNIQUE,
    name       VARCHAR2(200) NOT NULL,
    company    VARCHAR2(200),
    phone      VARCHAR2(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_customers_updated
BEFORE UPDATE ON customers FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Ticket categories
CREATE TABLE ticket_categories (
    id        RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    parent_id RAW(16) REFERENCES ticket_categories (id),
    name      VARCHAR2(100) NOT NULL,
    slug      VARCHAR2(120) NOT NULL UNIQUE
);

-- SLA policies
CREATE TABLE sla_policies (
    id                  RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name                VARCHAR2(100) NOT NULL UNIQUE,
    description         CLOB,
    first_response_hrs  NUMBER(5) DEFAULT 4 NOT NULL,
    resolution_hrs      NUMBER(5) DEFAULT 24 NOT NULL,
    priority            VARCHAR2(10) NOT NULL CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    is_active           NUMBER(1) DEFAULT 1 NOT NULL
);

-- Tickets
CREATE TABLE tickets (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    ticket_number VARCHAR2(20) NOT NULL UNIQUE,
    customer_id   RAW(16) NOT NULL REFERENCES customers (id),
    assigned_to   RAW(16) REFERENCES agents (id),
    department_id RAW(16) REFERENCES departments (id),
    category_id   RAW(16) REFERENCES ticket_categories (id),
    sla_policy_id RAW(16) REFERENCES sla_policies (id),
    subject       VARCHAR2(500) NOT NULL,
    description   CLOB NOT NULL,
    status        VARCHAR2(20) DEFAULT 'open' NOT NULL CHECK (status IN ('open', 'in_progress', 'waiting', 'resolved', 'closed')),
    priority      VARCHAR2(10) DEFAULT 'medium' NOT NULL CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    channel       VARCHAR2(20) DEFAULT 'web' NOT NULL CHECK (channel IN ('web', 'email', 'phone', 'chat', 'api')),
    tags          CLOB DEFAULT '[]',
    first_response_at TIMESTAMP WITH TIME ZONE,
    resolved_at   TIMESTAMP WITH TIME ZONE,
    closed_at     TIMESTAMP WITH TIME ZONE,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_tickets_customer ON tickets (customer_id);
CREATE INDEX idx_tickets_assigned ON tickets (assigned_to);
CREATE INDEX idx_tickets_status ON tickets (status);
CREATE INDEX idx_tickets_priority ON tickets (priority);
CREATE INDEX idx_tickets_created ON tickets (created_at);

CREATE OR REPLACE TRIGGER trg_tickets_updated
BEFORE UPDATE ON tickets FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Ticket messages
CREATE TABLE ticket_messages (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    ticket_id   RAW(16) NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    sender_type VARCHAR2(10) NOT NULL CHECK (sender_type IN ('customer', 'agent', 'system')),
    sender_id   RAW(16) NOT NULL,
    body        CLOB NOT NULL,
    is_internal NUMBER(1) DEFAULT 0 NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_ticket_messages_ticket ON ticket_messages (ticket_id);

-- Ticket attachments
CREATE TABLE ticket_attachments (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    ticket_id   RAW(16) NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    message_id  RAW(16) REFERENCES ticket_messages (id) ON DELETE CASCADE,
    file_name   VARCHAR2(255) NOT NULL,
    file_path   VARCHAR2(500) NOT NULL,
    mime_type   VARCHAR2(100) NOT NULL,
    file_size   NUMBER(15) NOT NULL,
    uploaded_by RAW(16) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_ticket_attachments_ticket ON ticket_attachments (ticket_id);
