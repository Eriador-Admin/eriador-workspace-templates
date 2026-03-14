-- {{APP_NAME}} Social Network Schema — PostgreSQL

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users / profiles
CREATE TABLE users (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username     VARCHAR(50) NOT NULL UNIQUE,
    email        VARCHAR(255) NOT NULL UNIQUE,
    display_name VARCHAR(200) NOT NULL,
    bio          TEXT,
    avatar_url   VARCHAR(500),
    location     VARCHAR(200),
    website      VARCHAR(500),
    is_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Friendships / follow relationships
CREATE TABLE friendships (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    requester_id UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    addressee_id UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    status       VARCHAR(10) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'blocked')),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (requester_id, addressee_id),
    CHECK (requester_id <> addressee_id)
);

CREATE INDEX idx_friendships_requester ON friendships (requester_id);
CREATE INDEX idx_friendships_addressee ON friendships (addressee_id);

-- Posts
CREATE TABLE posts (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    author_id  UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    content    TEXT NOT NULL,
    media_url  VARCHAR(500),
    media_type VARCHAR(20) CHECK (media_type IN ('image', 'video', 'gif', NULL)),
    visibility VARCHAR(10) NOT NULL DEFAULT 'public' CHECK (visibility IN ('public', 'friends', 'private')),
    like_count   INTEGER NOT NULL DEFAULT 0,
    comment_count INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_posts_author ON posts (author_id);
CREATE INDEX idx_posts_created ON posts (created_at DESC);

-- Comments
CREATE TABLE comments (
    id        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id   UUID NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    parent_id UUID REFERENCES comments (id) ON DELETE CASCADE,
    body      TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_comments_post ON comments (post_id);

-- Likes (polymorphic: post or comment)
CREATE TABLE likes (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    target_type VARCHAR(10) NOT NULL CHECK (target_type IN ('post', 'comment')),
    target_id   UUID NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, target_type, target_id)
);

CREATE INDEX idx_likes_target ON likes (target_type, target_id);

-- Direct messages
CREATE TABLE messages (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id   UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    receiver_id UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    body        TEXT NOT NULL,
    is_read     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (sender_id <> receiver_id)
);

CREATE INDEX idx_messages_sender ON messages (sender_id);
CREATE INDEX idx_messages_receiver ON messages (receiver_id);

-- Notifications
CREATE TABLE notifications (
    id        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id   UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    actor_id  UUID REFERENCES users (id) ON DELETE SET NULL,
    type      VARCHAR(30) NOT NULL CHECK (type IN ('like', 'comment', 'follow_request', 'follow_accept', 'mention', 'message')),
    target_type VARCHAR(10) CHECK (target_type IN ('post', 'comment', 'message', NULL)),
    target_id UUID,
    is_read   BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications (user_id, is_read);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_friendships_updated BEFORE UPDATE ON friendships FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_posts_updated BEFORE UPDATE ON posts FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_comments_updated BEFORE UPDATE ON comments FOR EACH ROW EXECUTE FUNCTION update_updated_at();
