-- {{APP_NAME}} Seed Data — MySQL

-- Default roles
INSERT INTO roles (name, description) VALUES
    ('admin', 'Full system administrator'),
    ('user', 'Standard user'),
    ('moderator', 'Content moderator');

-- Sample users (passwords are bcrypt hash of "password123")
INSERT INTO users (email, username, password_hash, first_name, last_name, is_active, is_verified, role_id) VALUES
    ('admin@example.com', 'admin', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Admin', 'User', TRUE, TRUE, (SELECT id FROM roles WHERE name = 'admin')),
    ('jane@example.com', 'janesmith', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Jane', 'Smith', TRUE, TRUE, (SELECT id FROM roles WHERE name = 'user')),
    ('bob@example.com', 'bobwilson', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Bob', 'Wilson', TRUE, FALSE, (SELECT id FROM roles WHERE name = 'user'));
