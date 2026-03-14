-- {{APP_NAME}} SaaS Multi-Tenant Schema — Oracle

-- Subscription plans
CREATE TABLE plans (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name          VARCHAR2(100) NOT NULL UNIQUE,
    slug          VARCHAR2(120) NOT NULL UNIQUE,
    description   VARCHAR2(1000),
    price_monthly NUMBER(10,2) DEFAULT 0 NOT NULL,
    price_yearly  NUMBER(10,2) DEFAULT 0 NOT NULL,
    max_members   NUMBER(10) DEFAULT 5 NOT NULL,
    features      CLOB DEFAULT '{}',
    is_active     NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    sort_order    NUMBER(10) DEFAULT 0 NOT NULL,
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_plans_updated
    BEFORE UPDATE ON plans
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Organizations (tenants)
CREATE TABLE organizations (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(200) NOT NULL,
    slug        VARCHAR2(220) NOT NULL UNIQUE,
    logo_url    VARCHAR2(500),
    plan_id     RAW(16) REFERENCES plans (id),
    owner_email VARCHAR2(255) NOT NULL,
    settings    CLOB DEFAULT '{}',
    is_active   NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    created_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_organizations_slug ON organizations (slug);
CREATE INDEX idx_organizations_plan ON organizations (plan_id);

CREATE OR REPLACE TRIGGER trg_organizations_updated
    BEFORE UPDATE ON organizations
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Members
CREATE TABLE members (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    org_id        RAW(16) NOT NULL REFERENCES organizations (id) ON DELETE CASCADE,
    email         VARCHAR2(255) NOT NULL,
    display_name  VARCHAR2(200) NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    role          VARCHAR2(30) DEFAULT 'member' NOT NULL CHECK (role IN ('owner', 'admin', 'member', 'viewer')),
    is_active     NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    last_login_at TIMESTAMP,
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_members_org_email UNIQUE (org_id, email)
);

CREATE INDEX idx_members_org ON members (org_id);
CREATE INDEX idx_members_email ON members (email);

CREATE OR REPLACE TRIGGER trg_members_updated
    BEFORE UPDATE ON members
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Subscriptions
CREATE TABLE subscriptions (
    id                   RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    org_id               RAW(16) NOT NULL REFERENCES organizations (id) ON DELETE CASCADE,
    plan_id              RAW(16) NOT NULL REFERENCES plans (id),
    status               VARCHAR2(20) DEFAULT 'active' NOT NULL CHECK (status IN ('trialing', 'active', 'past_due', 'cancelled', 'expired')),
    billing_cycle        VARCHAR2(10) DEFAULT 'monthly' NOT NULL CHECK (billing_cycle IN ('monthly', 'yearly')),
    current_period_start TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    current_period_end   TIMESTAMP NOT NULL,
    cancelled_at         TIMESTAMP,
    created_at           TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at           TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_subscriptions_org ON subscriptions (org_id);
CREATE INDEX idx_subscriptions_status ON subscriptions (status);

CREATE OR REPLACE TRIGGER trg_subscriptions_updated
    BEFORE UPDATE ON subscriptions
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Invitations
CREATE TABLE invitations (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    org_id     RAW(16) NOT NULL REFERENCES organizations (id) ON DELETE CASCADE,
    invited_by RAW(16) NOT NULL REFERENCES members (id),
    email      VARCHAR2(255) NOT NULL,
    role       VARCHAR2(30) DEFAULT 'member' NOT NULL CHECK (role IN ('admin', 'member', 'viewer')),
    token      VARCHAR2(128) NOT NULL UNIQUE,
    status     VARCHAR2(20) DEFAULT 'pending' NOT NULL CHECK (status IN ('pending', 'accepted', 'expired', 'revoked')),
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_invitations_org ON invitations (org_id);
CREATE INDEX idx_invitations_token ON invitations (token);
CREATE INDEX idx_invitations_email ON invitations (email);

-- Audit log
CREATE TABLE audit_log (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    org_id     RAW(16) NOT NULL REFERENCES organizations (id) ON DELETE CASCADE,
    actor_id   RAW(16) REFERENCES members (id),
    action     VARCHAR2(100) NOT NULL,
    resource   VARCHAR2(100),
    details    CLOB DEFAULT '{}',
    ip_address VARCHAR2(45),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_audit_log_org ON audit_log (org_id);
CREATE INDEX idx_audit_log_actor ON audit_log (actor_id);
CREATE INDEX idx_audit_log_action ON audit_log (action);
CREATE INDEX idx_audit_log_created ON audit_log (created_at);
