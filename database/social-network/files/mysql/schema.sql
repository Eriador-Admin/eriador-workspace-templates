-- {{APP_NAME}} Social Network Schema — MySQL

-- Users / profiles
CREATE TABLE users (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    username     VARCHAR(50) NOT NULL UNIQUE,
    email        VARCHAR(255) NOT NULL UNIQUE,
    display_name VARCHAR(200) NOT NULL,
    bio          TEXT,
    avatar_url   VARCHAR(500),
    location     VARCHAR(200),
    website      VARCHAR(500),
    is_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Friendships
CREATE TABLE friendships (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    requester_id CHAR(36) NOT NULL,
    addressee_id CHAR(36) NOT NULL,
    status       ENUM('pending', 'accepted', 'blocked') NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (requester_id, addressee_id),
    FOREIGN KEY (requester_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (addressee_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_friendships_requester ON friendships (requester_id);
CREATE INDEX idx_friendships_addressee ON friendships (addressee_id);

-- Posts
CREATE TABLE posts (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    author_id    CHAR(36) NOT NULL,
    content      TEXT NOT NULL,
    media_url    VARCHAR(500),
    media_type   ENUM('image', 'video', 'gif') NULL,
    visibility   ENUM('public', 'friends', 'private') NOT NULL DEFAULT 'public',
    like_count   INTEGER NOT NULL DEFAULT 0,
    comment_count INTEGER NOT NULL DEFAULT 0,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_posts_author ON posts (author_id);
CREATE INDEX idx_posts_created ON posts (created_at DESC);

-- Comments
CREATE TABLE comments (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    post_id    CHAR(36) NOT NULL,
    author_id  CHAR(36) NOT NULL,
    parent_id  CHAR(36),
    body       TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_comments_post ON comments (post_id);

-- Likes
CREATE TABLE `likes` (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id     CHAR(36) NOT NULL,
    target_type ENUM('post', 'comment') NOT NULL,
    target_id   CHAR(36) NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, target_type, target_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_likes_target ON `likes` (target_type, target_id);

-- Direct messages
CREATE TABLE messages (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id   CHAR(36) NOT NULL,
    receiver_id CHAR(36) NOT NULL,
    body        TEXT NOT NULL,
    is_read     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_messages_sender ON messages (sender_id);
CREATE INDEX idx_messages_receiver ON messages (receiver_id);

-- Notifications
CREATE TABLE notifications (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id     CHAR(36) NOT NULL,
    actor_id    CHAR(36),
    type        ENUM('like', 'comment', 'follow_request', 'follow_accept', 'mention', 'message') NOT NULL,
    target_type ENUM('post', 'comment', 'message') NULL,
    target_id   CHAR(36),
    is_read     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_notifications_user ON notifications (user_id, is_read);
