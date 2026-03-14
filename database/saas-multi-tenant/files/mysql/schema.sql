-- {{APP_NAME}} SaaS Multi-Tenant Schema — MySQL

CREATE TABLE plans (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name          VARCHAR(100) NOT NULL UNIQUE,
    slug          VARCHAR(120) NOT NULL UNIQUE,
    description   TEXT,
    price_monthly DECIMAL(10,2) NOT NULL DEFAULT 0,
    price_yearly  DECIMAL(10,2) NOT NULL DEFAULT 0,
    max_members   INT NOT NULL DEFAULT 5,
    features      JSON DEFAULT ('{}'),
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    sort_order    INT NOT NULL DEFAULT 0,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE organizations (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name        VARCHAR(200) NOT NULL,
    slug        VARCHAR(220) NOT NULL UNIQUE,
    logo_url    VARCHAR(500),
    plan_id     CHAR(36),
    owner_email VARCHAR(255) NOT NULL,
    settings    JSON DEFAULT ('{}'),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES plans (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_organizations_slug ON organizations (slug);
CREATE INDEX idx_organizations_plan ON organizations (plan_id);

CREATE TABLE members (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    org_id        CHAR(36) NOT NULL,
    email         VARCHAR(255) NOT NULL,
    display_name  VARCHAR(200) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role          VARCHAR(30) NOT NULL DEFAULT 'member',
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    last_login_at TIMESTAMP NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_members_org_email (org_id, email),
    FOREIGN KEY (org_id) REFERENCES organizations (id) ON DELETE CASCADE,
    CHECK (role IN ('owner', 'admin', 'member', 'viewer'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_members_org ON members (org_id);
CREATE INDEX idx_members_email ON members (email);

CREATE TABLE subscriptions (
    id                   CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    org_id               CHAR(36) NOT NULL,
    plan_id              CHAR(36) NOT NULL,
    status               VARCHAR(20) NOT NULL DEFAULT 'active',
    billing_cycle        VARCHAR(10) NOT NULL DEFAULT 'monthly',
    current_period_start TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    current_period_end   TIMESTAMP NOT NULL,
    cancelled_at         TIMESTAMP NULL,
    created_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES organizations (id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES plans (id),
    CHECK (status IN ('trialing', 'active', 'past_due', 'cancelled', 'expired')),
    CHECK (billing_cycle IN ('monthly', 'yearly'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_subscriptions_org ON subscriptions (org_id);
CREATE INDEX idx_subscriptions_status ON subscriptions (status);

CREATE TABLE invitations (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    org_id     CHAR(36) NOT NULL,
    invited_by CHAR(36) NOT NULL,
    email      VARCHAR(255) NOT NULL,
    role       VARCHAR(30) NOT NULL DEFAULT 'member',
    token      VARCHAR(128) NOT NULL UNIQUE,
    status     VARCHAR(20) NOT NULL DEFAULT 'pending',
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES organizations (id) ON DELETE CASCADE,
    FOREIGN KEY (invited_by) REFERENCES members (id),
    CHECK (role IN ('admin', 'member', 'viewer')),
    CHECK (status IN ('pending', 'accepted', 'expired', 'revoked'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_invitations_org ON invitations (org_id);
CREATE INDEX idx_invitations_token ON invitations (token);
CREATE INDEX idx_invitations_email ON invitations (email);

CREATE TABLE audit_log (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    org_id     CHAR(36) NOT NULL,
    actor_id   CHAR(36),
    action     VARCHAR(100) NOT NULL,
    resource   VARCHAR(100),
    details    JSON DEFAULT ('{}'),
    ip_address VARCHAR(45),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES organizations (id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES members (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_audit_log_org ON audit_log (org_id);
CREATE INDEX idx_audit_log_actor ON audit_log (actor_id);
CREATE INDEX idx_audit_log_action ON audit_log (action);
CREATE INDEX idx_audit_log_created ON audit_log (created_at);
