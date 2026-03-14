-- {{APP_NAME}} Seed Data — Oracle

INSERT INTO roles (name, description) VALUES ('admin', 'Full system administrator');
INSERT INTO roles (name, description) VALUES ('user', 'Standard user');
INSERT INTO roles (name, description) VALUES ('moderator', 'Content moderator');

INSERT INTO users (email, username, password_hash, first_name, last_name, is_active, is_verified, role_id)
    VALUES ('admin@example.com', 'admin', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Admin', 'User', 1, 1, (SELECT id FROM roles WHERE name = 'admin'));

INSERT INTO users (email, username, password_hash, first_name, last_name, is_active, is_verified, role_id)
    VALUES ('jane@example.com', 'janesmith', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Jane', 'Smith', 1, 1, (SELECT id FROM roles WHERE name = 'user'));

INSERT INTO users (email, username, password_hash, first_name, last_name, is_active, is_verified, role_id)
    VALUES ('bob@example.com', 'bobwilson', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W', 'Bob', 'Wilson', 1, 0, (SELECT id FROM roles WHERE name = 'user'));

COMMIT;
