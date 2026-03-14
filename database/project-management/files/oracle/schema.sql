-- {{APP_NAME}} Project Management Schema — Oracle

CREATE TABLE projects (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(200) NOT NULL,
    slug        VARCHAR2(220) NOT NULL UNIQUE,
    description CLOB,
    owner_id    RAW(16) NOT NULL,
    status      VARCHAR2(20) DEFAULT 'active' NOT NULL CHECK (status IN ('active', 'archived', 'completed')),
    visibility  VARCHAR2(20) DEFAULT 'private' NOT NULL CHECK (visibility IN ('private', 'team', 'public')),
    created_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_projects_slug ON projects (slug);
CREATE INDEX idx_projects_owner ON projects (owner_id);

CREATE OR REPLACE TRIGGER trg_projects_updated BEFORE UPDATE ON projects FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE project_members (
    project_id RAW(16) NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    user_id    RAW(16) NOT NULL,
    role       VARCHAR2(20) DEFAULT 'member' NOT NULL CHECK (role IN ('owner', 'admin', 'member', 'viewer')),
    joined_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_project_members PRIMARY KEY (project_id, user_id)
);

CREATE TABLE boards (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    project_id RAW(16) NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    name       VARCHAR2(200) NOT NULL,
    sort_order NUMBER(10) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_boards_project ON boards (project_id);

CREATE TABLE columns_tbl (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    board_id   RAW(16) NOT NULL REFERENCES boards (id) ON DELETE CASCADE,
    name       VARCHAR2(100) NOT NULL,
    color      VARCHAR2(7) DEFAULT '#6B7280',
    wip_limit  NUMBER(10),
    sort_order NUMBER(10) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_columns_board ON columns_tbl (board_id);

CREATE TABLE labels (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    project_id RAW(16) NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    name       VARCHAR2(100) NOT NULL,
    color      VARCHAR2(7) DEFAULT '#3B82F6' NOT NULL,
    CONSTRAINT uq_labels_project_name UNIQUE (project_id, name)
);

CREATE TABLE tasks (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    project_id   RAW(16) NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    column_id    RAW(16) REFERENCES columns_tbl (id) ON DELETE SET NULL,
    parent_id    RAW(16) REFERENCES tasks (id) ON DELETE CASCADE,
    title        VARCHAR2(500) NOT NULL,
    description  CLOB,
    priority     VARCHAR2(10) DEFAULT 'medium' NOT NULL CHECK (priority IN ('critical', 'high', 'medium', 'low', 'none')),
    assignee_id  RAW(16),
    reporter_id  RAW(16) NOT NULL,
    due_date     DATE,
    estimate_hrs NUMBER(6,1),
    sort_order   NUMBER(10) DEFAULT 0 NOT NULL,
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_tasks_project ON tasks (project_id);
CREATE INDEX idx_tasks_column ON tasks (column_id);
CREATE INDEX idx_tasks_assignee ON tasks (assignee_id);

CREATE OR REPLACE TRIGGER trg_tasks_updated BEFORE UPDATE ON tasks FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE task_labels (
    task_id  RAW(16) NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
    label_id RAW(16) NOT NULL REFERENCES labels (id) ON DELETE CASCADE,
    CONSTRAINT pk_task_labels PRIMARY KEY (task_id, label_id)
);

CREATE TABLE task_comments (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    task_id    RAW(16) NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
    author_id  RAW(16) NOT NULL,
    body       CLOB NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_task_comments_task ON task_comments (task_id);

CREATE OR REPLACE TRIGGER trg_task_comments_updated BEFORE UPDATE ON task_comments FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

CREATE TABLE task_activity (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    task_id    RAW(16) NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
    actor_id   RAW(16) NOT NULL,
    action     VARCHAR2(50) NOT NULL,
    field      VARCHAR2(50),
    old_value  VARCHAR2(2000),
    new_value  VARCHAR2(2000),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_task_activity_task ON task_activity (task_id);
