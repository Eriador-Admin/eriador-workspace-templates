-- {{APP_NAME}} Seed Data — SQLite

-- Users
INSERT INTO users (id, username, email, display_name, bio, is_verified) VALUES
    ('u0000001-0000-4000-a000-000000000001', 'alice', 'alice@example.com', 'Alice Johnson', 'Software engineer & coffee addict.', 1),
    ('u0000001-0000-4000-a000-000000000002', 'bob',   'bob@example.com',   'Bob Smith',     'Photographer | traveller | foodie.', 0),
    ('u0000001-0000-4000-a000-000000000003', 'carol', 'carol@example.com', 'Carol Williams','Building the future, one line at a time.', 1);

-- Friendships
INSERT INTO friendships (requester_id, addressee_id, status) VALUES
    ('u0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000002', 'accepted'),
    ('u0000001-0000-4000-a000-000000000003', 'u0000001-0000-4000-a000-000000000001', 'accepted'),
    ('u0000001-0000-4000-a000-000000000002', 'u0000001-0000-4000-a000-000000000003', 'pending');

-- Posts
INSERT INTO posts (id, author_id, content, visibility) VALUES
    ('p0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000001', 'Just shipped v2.0 of my side project!', 'public'),
    ('p0000001-0000-4000-a000-000000000002', 'u0000001-0000-4000-a000-000000000002', 'Golden hour at the Grand Canyon', 'public'),
    ('p0000001-0000-4000-a000-000000000003', 'u0000001-0000-4000-a000-000000000003', 'Reading Designing Data-Intensive Applications — highly recommend.', 'friends');

-- Comments
INSERT INTO comments (post_id, author_id, body) VALUES
    ('p0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000002', 'Congrats Alice!'),
    ('p0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000003', 'Amazing work — can''t wait to try it.');

-- Likes
INSERT INTO likes (user_id, target_type, target_id) VALUES
    ('u0000001-0000-4000-a000-000000000002', 'post', 'p0000001-0000-4000-a000-000000000001'),
    ('u0000001-0000-4000-a000-000000000003', 'post', 'p0000001-0000-4000-a000-000000000001'),
    ('u0000001-0000-4000-a000-000000000001', 'post', 'p0000001-0000-4000-a000-000000000002');

UPDATE posts SET like_count = 2, comment_count = 2 WHERE id = 'p0000001-0000-4000-a000-000000000001';
UPDATE posts SET like_count = 1 WHERE id = 'p0000001-0000-4000-a000-000000000002';

-- Messages
INSERT INTO messages (sender_id, receiver_id, body) VALUES
    ('u0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000002', 'Hey Bob, love the canyon photo!'),
    ('u0000001-0000-4000-a000-000000000002', 'u0000001-0000-4000-a000-000000000001', 'Thanks Alice! Taken with my new lens.');

-- Notifications
INSERT INTO notifications (user_id, actor_id, type, target_type, target_id) VALUES
    ('u0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000002', 'like',    'post', 'p0000001-0000-4000-a000-000000000001'),
    ('u0000001-0000-4000-a000-000000000001', 'u0000001-0000-4000-a000-000000000003', 'comment', 'post', 'p0000001-0000-4000-a000-000000000001');
