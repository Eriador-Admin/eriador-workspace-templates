-- {{APP_NAME}} Social Network Schema — Oracle

-- Users / profiles
CREATE TABLE users (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    username     VARCHAR2(50) NOT NULL UNIQUE,
    email        VARCHAR2(255) NOT NULL UNIQUE,
    display_name VARCHAR2(200) NOT NULL,
    bio          CLOB,
    avatar_url   VARCHAR2(500),
    location     VARCHAR2(200),
    website      VARCHAR2(500),
    is_verified  NUMBER(1) DEFAULT 0 NOT NULL,
    is_active    NUMBER(1) DEFAULT 1 NOT NULL,
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_users_updated
BEFORE UPDATE ON users FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Friendships
CREATE TABLE friendships (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    requester_id RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    addressee_id RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    status       VARCHAR2(10) DEFAULT 'pending' NOT NULL CHECK (status IN ('pending', 'accepted', 'blocked')),
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_friendship UNIQUE (requester_id, addressee_id)
);

CREATE INDEX idx_friendships_requester ON friendships (requester_id);
CREATE INDEX idx_friendships_addressee ON friendships (addressee_id);

CREATE OR REPLACE TRIGGER trg_friendships_updated
BEFORE UPDATE ON friendships FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Posts
CREATE TABLE posts (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    author_id     RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    content       CLOB NOT NULL,
    media_url     VARCHAR2(500),
    media_type    VARCHAR2(20) CHECK (media_type IN ('image', 'video', 'gif', NULL)),
    visibility    VARCHAR2(10) DEFAULT 'public' NOT NULL CHECK (visibility IN ('public', 'friends', 'private')),
    like_count    NUMBER(10) DEFAULT 0 NOT NULL,
    comment_count NUMBER(10) DEFAULT 0 NOT NULL,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_posts_author ON posts (author_id);
CREATE INDEX idx_posts_created ON posts (created_at DESC);

CREATE OR REPLACE TRIGGER trg_posts_updated
BEFORE UPDATE ON posts FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Comments
CREATE TABLE comments (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    post_id    RAW(16) NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    author_id  RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    parent_id  RAW(16) REFERENCES comments (id) ON DELETE CASCADE,
    body       CLOB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_comments_post ON comments (post_id);

CREATE OR REPLACE TRIGGER trg_comments_updated
BEFORE UPDATE ON comments FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Likes
CREATE TABLE likes_tbl (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    user_id     RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    target_type VARCHAR2(10) NOT NULL CHECK (target_type IN ('post', 'comment')),
    target_id   RAW(16) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_like UNIQUE (user_id, target_type, target_id)
);

CREATE INDEX idx_likes_target ON likes_tbl (target_type, target_id);

-- Direct messages
CREATE TABLE messages (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    sender_id   RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    receiver_id RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    body        CLOB NOT NULL,
    is_read     NUMBER(1) DEFAULT 0 NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_messages_sender ON messages (sender_id);
CREATE INDEX idx_messages_receiver ON messages (receiver_id);

-- Notifications
CREATE TABLE notifications (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    user_id     RAW(16) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    actor_id    RAW(16) REFERENCES users (id) ON DELETE SET NULL,
    type        VARCHAR2(30) NOT NULL CHECK (type IN ('like', 'comment', 'follow_request', 'follow_accept', 'mention', 'message')),
    target_type VARCHAR2(10) CHECK (target_type IN ('post', 'comment', 'message', NULL)),
    target_id   RAW(16),
    is_read     NUMBER(1) DEFAULT 0 NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_notifications_user ON notifications (user_id, is_read);
