-- {{APP_NAME}} Blog/CMS Schema — Oracle

-- Authors
CREATE TABLE authors (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email        VARCHAR2(255) NOT NULL UNIQUE,
    username     VARCHAR2(100) NOT NULL UNIQUE,
    display_name VARCHAR2(200) NOT NULL,
    bio          CLOB,
    avatar_url   VARCHAR2(500),
    password_hash VARCHAR2(255) NOT NULL,
    is_active    NUMBER(1) DEFAULT 1 NOT NULL CHECK (is_active IN (0, 1)),
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_authors_email ON authors (email);

CREATE OR REPLACE TRIGGER trg_authors_updated
    BEFORE UPDATE ON authors
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Categories (nested via parent_id)
CREATE TABLE categories (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    parent_id   RAW(16) REFERENCES categories (id),
    name        VARCHAR2(100) NOT NULL,
    slug        VARCHAR2(120) NOT NULL UNIQUE,
    description VARCHAR2(500),
    sort_order  NUMBER(10) DEFAULT 0 NOT NULL,
    created_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_categories_slug ON categories (slug);
CREATE INDEX idx_categories_parent ON categories (parent_id);

-- Posts
CREATE TABLE posts (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    author_id    RAW(16) NOT NULL REFERENCES authors (id),
    category_id  RAW(16) REFERENCES categories (id),
    title        VARCHAR2(300) NOT NULL,
    slug         VARCHAR2(320) NOT NULL UNIQUE,
    excerpt      VARCHAR2(1000),
    body         CLOB NOT NULL,
    status       VARCHAR2(20) DEFAULT 'draft' NOT NULL CHECK (status IN ('draft', 'published', 'archived')),
    is_featured  NUMBER(1) DEFAULT 0 NOT NULL CHECK (is_featured IN (0, 1)),
    published_at TIMESTAMP,
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_posts_slug ON posts (slug);
CREATE INDEX idx_posts_author ON posts (author_id);
CREATE INDEX idx_posts_category ON posts (category_id);
CREATE INDEX idx_posts_status ON posts (status);
CREATE INDEX idx_posts_published_at ON posts (published_at);

CREATE OR REPLACE TRIGGER trg_posts_updated
    BEFORE UPDATE ON posts
    FOR EACH ROW
BEGIN
    :NEW.updated_at := SYSTIMESTAMP;
END;
/

-- Tags
CREATE TABLE tags (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name       VARCHAR2(100) NOT NULL UNIQUE,
    slug       VARCHAR2(120) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_tags_slug ON tags (slug);

-- Post–Tag junction
CREATE TABLE post_tags (
    post_id RAW(16) NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    tag_id  RAW(16) NOT NULL REFERENCES tags (id) ON DELETE CASCADE,
    CONSTRAINT pk_post_tags PRIMARY KEY (post_id, tag_id)
);

-- Comments (threaded via parent_id)
CREATE TABLE comments (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    post_id      RAW(16) NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    parent_id    RAW(16) REFERENCES comments (id),
    author_name  VARCHAR2(200) NOT NULL,
    author_email VARCHAR2(255) NOT NULL,
    body         CLOB NOT NULL,
    is_approved  NUMBER(1) DEFAULT 0 NOT NULL CHECK (is_approved IN (0, 1)),
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_comments_post ON comments (post_id);
CREATE INDEX idx_comments_parent ON comments (parent_id);

-- Media library
CREATE TABLE media (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    uploaded_by RAW(16) NOT NULL REFERENCES authors (id),
    file_name   VARCHAR2(255) NOT NULL,
    file_path   VARCHAR2(500) NOT NULL,
    mime_type   VARCHAR2(100) NOT NULL,
    file_size   NUMBER(20) NOT NULL,
    alt_text    VARCHAR2(500),
    created_at  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_media_uploader ON media (uploaded_by);
