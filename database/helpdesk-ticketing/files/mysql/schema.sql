-- {{APP_NAME}} Helpdesk Ticketing Schema — MySQL

-- Departments
CREATE TABLE departments (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agents
CREATE TABLE agents (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    department_id CHAR(36),
    email         VARCHAR(255) NOT NULL UNIQUE,
    display_name  VARCHAR(200) NOT NULL,
    role          ENUM('admin', 'supervisor', 'agent') NOT NULL DEFAULT 'agent',
    is_available  BOOLEAN NOT NULL DEFAULT TRUE,
    max_tickets   INTEGER NOT NULL DEFAULT 20,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_agents_department ON agents (department_id);

-- Customers
CREATE TABLE customers (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    company    VARCHAR(200),
    phone      VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ticket categories
CREATE TABLE ticket_categories (
    id        CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    parent_id CHAR(36),
    name      VARCHAR(100) NOT NULL,
    slug      VARCHAR(120) NOT NULL UNIQUE,
    FOREIGN KEY (parent_id) REFERENCES ticket_categories (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SLA policies
CREATE TABLE sla_policies (
    id                  CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name                VARCHAR(100) NOT NULL UNIQUE,
    description         TEXT,
    first_response_hrs  INTEGER NOT NULL DEFAULT 4,
    resolution_hrs      INTEGER NOT NULL DEFAULT 24,
    priority            ENUM('critical', 'high', 'medium', 'low') NOT NULL,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tickets
CREATE TABLE tickets (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    ticket_number VARCHAR(20) NOT NULL UNIQUE,
    customer_id   CHAR(36) NOT NULL,
    assigned_to   CHAR(36),
    department_id CHAR(36),
    category_id   CHAR(36),
    sla_policy_id CHAR(36),
    subject       VARCHAR(500) NOT NULL,
    description   TEXT NOT NULL,
    status        ENUM('open', 'in_progress', 'waiting', 'resolved', 'closed') NOT NULL DEFAULT 'open',
    priority      ENUM('critical', 'high', 'medium', 'low') NOT NULL DEFAULT 'medium',
    channel       ENUM('web', 'email', 'phone', 'chat', 'api') NOT NULL DEFAULT 'web',
    tags          JSON DEFAULT ('[]'),
    first_response_at TIMESTAMP NULL,
    resolved_at   TIMESTAMP NULL,
    closed_at     TIMESTAMP NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (assigned_to) REFERENCES agents (id),
    FOREIGN KEY (department_id) REFERENCES departments (id),
    FOREIGN KEY (category_id) REFERENCES ticket_categories (id),
    FOREIGN KEY (sla_policy_id) REFERENCES sla_policies (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_tickets_customer ON tickets (customer_id);
CREATE INDEX idx_tickets_assigned ON tickets (assigned_to);
CREATE INDEX idx_tickets_status ON tickets (status);
CREATE INDEX idx_tickets_priority ON tickets (priority);
CREATE INDEX idx_tickets_created ON tickets (created_at);

-- Ticket messages
CREATE TABLE ticket_messages (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    ticket_id   CHAR(36) NOT NULL,
    sender_type ENUM('customer', 'agent', 'system') NOT NULL,
    sender_id   CHAR(36) NOT NULL,
    body        TEXT NOT NULL,
    is_internal BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_ticket_messages_ticket ON ticket_messages (ticket_id);

-- Ticket attachments
CREATE TABLE ticket_attachments (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    ticket_id   CHAR(36) NOT NULL,
    message_id  CHAR(36),
    file_name   VARCHAR(255) NOT NULL,
    file_path   VARCHAR(500) NOT NULL,
    mime_type   VARCHAR(100) NOT NULL,
    file_size   BIGINT NOT NULL,
    uploaded_by CHAR(36) NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets (id) ON DELETE CASCADE,
    FOREIGN KEY (message_id) REFERENCES ticket_messages (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_ticket_attachments_ticket ON ticket_attachments (ticket_id);
