-- {{APP_NAME}} Project Management Schema — MySQL

CREATE TABLE projects (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name        VARCHAR(200) NOT NULL,
    slug        VARCHAR(220) NOT NULL UNIQUE,
    description TEXT,
    owner_id    CHAR(36) NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'active',
    visibility  VARCHAR(20) NOT NULL DEFAULT 'private',
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CHECK (status IN ('active', 'archived', 'completed')),
    CHECK (visibility IN ('private', 'team', 'public'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_projects_slug ON projects (slug);
CREATE INDEX idx_projects_owner ON projects (owner_id);

CREATE TABLE project_members (
    project_id CHAR(36) NOT NULL,
    user_id    CHAR(36) NOT NULL,
    role       VARCHAR(20) NOT NULL DEFAULT 'member',
    joined_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE,
    CHECK (role IN ('owner', 'admin', 'member', 'viewer'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE boards (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    project_id CHAR(36) NOT NULL,
    name       VARCHAR(200) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_boards_project ON boards (project_id);

CREATE TABLE `columns` (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    board_id   CHAR(36) NOT NULL,
    name       VARCHAR(100) NOT NULL,
    color      VARCHAR(7) DEFAULT '#6B7280',
    wip_limit  INT,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (board_id) REFERENCES boards (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_columns_board ON `columns` (board_id);

CREATE TABLE labels (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    project_id CHAR(36) NOT NULL,
    name       VARCHAR(100) NOT NULL,
    color      VARCHAR(7) NOT NULL DEFAULT '#3B82F6',
    UNIQUE KEY uq_labels_project_name (project_id, name),
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tasks (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    project_id   CHAR(36) NOT NULL,
    column_id    CHAR(36),
    parent_id    CHAR(36),
    title        VARCHAR(500) NOT NULL,
    description  TEXT,
    priority     VARCHAR(10) NOT NULL DEFAULT 'medium',
    assignee_id  CHAR(36),
    reporter_id  CHAR(36) NOT NULL,
    due_date     DATE,
    estimate_hrs DECIMAL(6,1),
    sort_order   INT NOT NULL DEFAULT 0,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE,
    FOREIGN KEY (column_id) REFERENCES `columns` (id) ON DELETE SET NULL,
    FOREIGN KEY (parent_id) REFERENCES tasks (id) ON DELETE CASCADE,
    CHECK (priority IN ('critical', 'high', 'medium', 'low', 'none'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_tasks_project ON tasks (project_id);
CREATE INDEX idx_tasks_column ON tasks (column_id);
CREATE INDEX idx_tasks_assignee ON tasks (assignee_id);
CREATE INDEX idx_tasks_parent ON tasks (parent_id);

CREATE TABLE task_labels (
    task_id  CHAR(36) NOT NULL,
    label_id CHAR(36) NOT NULL,
    PRIMARY KEY (task_id, label_id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE,
    FOREIGN KEY (label_id) REFERENCES labels (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE task_comments (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    task_id    CHAR(36) NOT NULL,
    author_id  CHAR(36) NOT NULL,
    body       TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_task_comments_task ON task_comments (task_id);

CREATE TABLE task_activity (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    task_id    CHAR(36) NOT NULL,
    actor_id   CHAR(36) NOT NULL,
    action     VARCHAR(50) NOT NULL,
    field      VARCHAR(50),
    old_value  TEXT,
    new_value  TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_task_activity_task ON task_activity (task_id);
