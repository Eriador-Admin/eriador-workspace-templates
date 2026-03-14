-- {{APP_NAME}} Seed Data — Oracle

-- Users
INSERT INTO users (id, username, email, display_name, bio, is_verified) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), 'alice', 'alice@example.com', 'Alice Johnson', 'Software engineer and coffee addict.', 1);
INSERT INTO users (id, username, email, display_name, bio, is_verified) VALUES
    (HEXTORAW('A100000100004000A000000000000002'), 'bob',   'bob@example.com',   'Bob Smith',     'Photographer, traveller, foodie.', 0);
INSERT INTO users (id, username, email, display_name, bio, is_verified) VALUES
    (HEXTORAW('A100000100004000A000000000000003'), 'carol', 'carol@example.com', 'Carol Williams','Building the future, one line at a time.', 1);

-- Friendships
INSERT INTO friendships (requester_id, addressee_id, status) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000002'), 'accepted');
INSERT INTO friendships (requester_id, addressee_id, status) VALUES
    (HEXTORAW('A100000100004000A000000000000003'), HEXTORAW('A100000100004000A000000000000001'), 'accepted');
INSERT INTO friendships (requester_id, addressee_id, status) VALUES
    (HEXTORAW('A100000100004000A000000000000002'), HEXTORAW('A100000100004000A000000000000003'), 'pending');

-- Posts
INSERT INTO posts (id, author_id, content, visibility) VALUES
    (HEXTORAW('B100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000001'), 'Just shipped v2.0 of my side project!', 'public');
INSERT INTO posts (id, author_id, content, visibility) VALUES
    (HEXTORAW('B100000100004000A000000000000002'), HEXTORAW('A100000100004000A000000000000002'), 'Golden hour at the Grand Canyon', 'public');
INSERT INTO posts (id, author_id, content, visibility) VALUES
    (HEXTORAW('B100000100004000A000000000000003'), HEXTORAW('A100000100004000A000000000000003'), 'Reading Designing Data-Intensive Applications — highly recommend.', 'friends');

-- Comments
INSERT INTO comments (post_id, author_id, body) VALUES
    (HEXTORAW('B100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000002'), 'Congrats Alice!');
INSERT INTO comments (post_id, author_id, body) VALUES
    (HEXTORAW('B100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000003'), 'Amazing work — cannot wait to try it.');

-- Likes
INSERT INTO likes_tbl (user_id, target_type, target_id) VALUES
    (HEXTORAW('A100000100004000A000000000000002'), 'post', HEXTORAW('B100000100004000A000000000000001'));
INSERT INTO likes_tbl (user_id, target_type, target_id) VALUES
    (HEXTORAW('A100000100004000A000000000000003'), 'post', HEXTORAW('B100000100004000A000000000000001'));
INSERT INTO likes_tbl (user_id, target_type, target_id) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), 'post', HEXTORAW('B100000100004000A000000000000002'));

UPDATE posts SET like_count = 2, comment_count = 2 WHERE id = HEXTORAW('B100000100004000A000000000000001');
UPDATE posts SET like_count = 1 WHERE id = HEXTORAW('B100000100004000A000000000000002');

-- Messages
INSERT INTO messages (sender_id, receiver_id, body) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000002'), 'Hey Bob, love the canyon photo!');
INSERT INTO messages (sender_id, receiver_id, body) VALUES
    (HEXTORAW('A100000100004000A000000000000002'), HEXTORAW('A100000100004000A000000000000001'), 'Thanks Alice! Taken with my new lens.');

-- Notifications
INSERT INTO notifications (user_id, actor_id, type, target_type, target_id) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000002'), 'like',    'post', HEXTORAW('B100000100004000A000000000000001'));
INSERT INTO notifications (user_id, actor_id, type, target_type, target_id) VALUES
    (HEXTORAW('A100000100004000A000000000000001'), HEXTORAW('A100000100004000A000000000000003'), 'comment', 'post', HEXTORAW('B100000100004000A000000000000001'));

COMMIT;
