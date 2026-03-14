-- {{APP_NAME}} Social Network Schema — SQLite

-- Users / profiles
CREATE TABLE users (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    username     TEXT NOT NULL UNIQUE,
    email        TEXT NOT NULL UNIQUE,
    display_name TEXT NOT NULL,
    bio          TEXT,
    avatar_url   TEXT,
    location     TEXT,
    website      TEXT,
    is_verified  INTEGER NOT NULL DEFAULT 0,
    is_active    INTEGER NOT NULL DEFAULT 1,
    created_at   TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_users_updated AFTER UPDATE ON users
BEGIN UPDATE users SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Friendships
CREATE TABLE friendships (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    requester_id TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    addressee_id TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    status       TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'blocked')),
    created_at   TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at   TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (requester_id, addressee_id)
);

CREATE INDEX idx_friendships_requester ON friendships (requester_id);
CREATE INDEX idx_friendships_addressee ON friendships (addressee_id);

CREATE TRIGGER trg_friendships_updated AFTER UPDATE ON friendships
BEGIN UPDATE friendships SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Posts
CREATE TABLE posts (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    author_id     TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    content       TEXT NOT NULL,
    media_url     TEXT,
    media_type    TEXT CHECK (media_type IN ('image', 'video', 'gif', NULL)),
    visibility    TEXT NOT NULL DEFAULT 'public' CHECK (visibility IN ('public', 'friends', 'private')),
    like_count    INTEGER NOT NULL DEFAULT 0,
    comment_count INTEGER NOT NULL DEFAULT 0,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_posts_author ON posts (author_id);
CREATE INDEX idx_posts_created ON posts (created_at DESC);

CREATE TRIGGER trg_posts_updated AFTER UPDATE ON posts
BEGIN UPDATE posts SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Comments
CREATE TABLE comments (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    post_id    TEXT NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    author_id  TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    parent_id  TEXT REFERENCES comments (id) ON DELETE CASCADE,
    body       TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_comments_post ON comments (post_id);

CREATE TRIGGER trg_comments_updated AFTER UPDATE ON comments
BEGIN UPDATE comments SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Likes
CREATE TABLE likes (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    user_id     TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    target_type TEXT NOT NULL CHECK (target_type IN ('post', 'comment')),
    target_id   TEXT NOT NULL,
    created_at  TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (user_id, target_type, target_id)
);

CREATE INDEX idx_likes_target ON likes (target_type, target_id);

-- Direct messages
CREATE TABLE messages (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    sender_id   TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    receiver_id TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    body        TEXT NOT NULL,
    is_read     INTEGER NOT NULL DEFAULT 0,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_messages_sender ON messages (sender_id);
CREATE INDEX idx_messages_receiver ON messages (receiver_id);

-- Notifications
CREATE TABLE notifications (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    user_id     TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    actor_id    TEXT REFERENCES users (id) ON DELETE SET NULL,
    type        TEXT NOT NULL CHECK (type IN ('like', 'comment', 'follow_request', 'follow_accept', 'mention', 'message')),
    target_type TEXT CHECK (target_type IN ('post', 'comment', 'message', NULL)),
    target_id   TEXT,
    is_read     INTEGER NOT NULL DEFAULT 0,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_notifications_user ON notifications (user_id, is_read);
