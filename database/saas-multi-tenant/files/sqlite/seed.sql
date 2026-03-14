-- {{APP_NAME}} Seed Data — SQLite

-- Plans
INSERT INTO plans (name, slug, description, price_monthly, price_yearly, max_members, features, sort_order) VALUES
    ('Free',       'free',       'Get started at no cost',              0,      0,    3,  '{"api_access": false, "support": "community"}',  10),
    ('Starter',    'starter',    'For small teams getting started',     19.00,  190.00, 10, '{"api_access": true, "support": "email"}',       20),
    ('Business',   'business',   'For growing organizations',           49.00,  490.00, 50, '{"api_access": true, "support": "priority", "sso": true}', 30),
    ('Enterprise', 'enterprise', 'Custom solutions for large teams',    0,      0,    -1, '{"api_access": true, "support": "dedicated", "sso": true, "custom_domain": true}', 40);

-- Organizations
INSERT INTO organizations (name, slug, plan_id, owner_email) VALUES
    ('Acme Corp',   'acme-corp',   (SELECT id FROM plans WHERE slug = 'business'),  'admin@acme.com'),
    ('Startup Labs', 'startup-labs', (SELECT id FROM plans WHERE slug = 'starter'),  'founder@startuplabs.io');

-- Members
INSERT INTO members (org_id, email, display_name, password_hash, role) VALUES
    ((SELECT id FROM organizations WHERE slug = 'acme-corp'), 'admin@acme.com', 'Alice Admin', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'owner'),
    ((SELECT id FROM organizations WHERE slug = 'acme-corp'), 'bob@acme.com',   'Bob Builder', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'admin'),
    ((SELECT id FROM organizations WHERE slug = 'acme-corp'), 'carol@acme.com', 'Carol Coder', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'member'),
    ((SELECT id FROM organizations WHERE slug = 'startup-labs'), 'founder@startuplabs.io', 'Dana Founder', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'owner');

-- Subscriptions
INSERT INTO subscriptions (org_id, plan_id, status, billing_cycle, current_period_start, current_period_end) VALUES
    ((SELECT id FROM organizations WHERE slug = 'acme-corp'),    (SELECT id FROM plans WHERE slug = 'business'), 'active',   'yearly',  datetime('now'), datetime('now', '+1 year')),
    ((SELECT id FROM organizations WHERE slug = 'startup-labs'), (SELECT id FROM plans WHERE slug = 'starter'),  'trialing', 'monthly', datetime('now'), datetime('now', '+14 days'));

-- Invitations
INSERT INTO invitations (org_id, invited_by, email, role, token, status, expires_at) VALUES
    ((SELECT id FROM organizations WHERE slug = 'acme-corp'),
     (SELECT id FROM members WHERE email = 'admin@acme.com'),
     'dave@acme.com', 'member', 'inv_abc123def456', 'pending', datetime('now', '+7 days'));
