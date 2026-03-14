-- {{APP_NAME}} Seed Data — PostgreSQL

-- Users
INSERT INTO users (username, email, display_name, bio, is_verified) VALUES
    ('alice',  'alice@example.com',  'Alice Johnson', 'Software engineer & coffee addict.', TRUE),
    ('bob',    'bob@example.com',    'Bob Smith',     'Photographer | traveller | foodie.', FALSE),
    ('carol',  'carol@example.com',  'Carol Williams','Building the future, one line at a time.', TRUE);

-- Friendships
INSERT INTO friendships (requester_id, addressee_id, status) VALUES
    ((SELECT id FROM users WHERE username = 'alice'), (SELECT id FROM users WHERE username = 'bob'),   'accepted'),
    ((SELECT id FROM users WHERE username = 'carol'), (SELECT id FROM users WHERE username = 'alice'), 'accepted'),
    ((SELECT id FROM users WHERE username = 'bob'),   (SELECT id FROM users WHERE username = 'carol'), 'pending');

-- Posts
INSERT INTO posts (author_id, content, visibility) VALUES
    ((SELECT id FROM users WHERE username = 'alice'), 'Just shipped v2.0 of my side project! 🎉', 'public'),
    ((SELECT id FROM users WHERE username = 'bob'),   'Golden hour at the Grand Canyon 🌅', 'public'),
    ((SELECT id FROM users WHERE username = 'carol'), 'Reading "Designing Data-Intensive Applications" — highly recommend.', 'friends');

-- Comments
INSERT INTO comments (post_id, author_id, body) VALUES
    ((SELECT id FROM posts WHERE content LIKE 'Just shipped%'), (SELECT id FROM users WHERE username = 'bob'),   'Congrats Alice! 🔥'),
    ((SELECT id FROM posts WHERE content LIKE 'Just shipped%'), (SELECT id FROM users WHERE username = 'carol'), 'Amazing work — can''t wait to try it.');

-- Likes
INSERT INTO likes (user_id, target_type, target_id) VALUES
    ((SELECT id FROM users WHERE username = 'bob'),   'post', (SELECT id FROM posts WHERE content LIKE 'Just shipped%')),
    ((SELECT id FROM users WHERE username = 'carol'), 'post', (SELECT id FROM posts WHERE content LIKE 'Just shipped%')),
    ((SELECT id FROM users WHERE username = 'alice'), 'post', (SELECT id FROM posts WHERE content LIKE 'Golden hour%'));

-- Update counters
UPDATE posts SET like_count = 2, comment_count = 2 WHERE content LIKE 'Just shipped%';
UPDATE posts SET like_count = 1 WHERE content LIKE 'Golden hour%';

-- Messages
INSERT INTO messages (sender_id, receiver_id, body) VALUES
    ((SELECT id FROM users WHERE username = 'alice'), (SELECT id FROM users WHERE username = 'bob'), 'Hey Bob, love the canyon photo!'),
    ((SELECT id FROM users WHERE username = 'bob'),   (SELECT id FROM users WHERE username = 'alice'), 'Thanks Alice! Taken with my new lens 📷');

-- Notifications
INSERT INTO notifications (user_id, actor_id, type, target_type, target_id) VALUES
    ((SELECT id FROM users WHERE username = 'alice'), (SELECT id FROM users WHERE username = 'bob'),   'like',    'post', (SELECT id FROM posts WHERE content LIKE 'Just shipped%')),
    ((SELECT id FROM users WHERE username = 'alice'), (SELECT id FROM users WHERE username = 'carol'), 'comment', 'post', (SELECT id FROM posts WHERE content LIKE 'Just shipped%'));
