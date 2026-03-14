-- {{APP_NAME}} Seed Data — Oracle

-- Authors
INSERT INTO authors (email, username, display_name, bio, password_hash)
VALUES ('editor@example.com', 'editor', 'Jane Editor', 'Senior content editor and tech writer.', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W');

INSERT INTO authors (email, username, display_name, bio, password_hash)
VALUES ('writer@example.com', 'writer', 'Alex Writer', 'Freelance journalist and blogger.', '$2b$12$LJ3m4ys3Lk0TSwHCbS0v4OX5Jj2qlFH0Iu.9hVGcflHv3MBq4K6W');

-- Categories
INSERT INTO categories (name, slug, description)
VALUES ('Technology', 'technology', 'Tech news, tutorials, and reviews');

INSERT INTO categories (name, slug, description)
VALUES ('Lifestyle', 'lifestyle', 'Health, travel, and personal growth');

INSERT INTO categories (name, slug, description)
VALUES ('Tutorials', 'tutorials', 'Step-by-step guides and how-tos');

-- Tags
INSERT INTO tags (name, slug) VALUES ('JavaScript', 'javascript');
INSERT INTO tags (name, slug) VALUES ('Python', 'python');
INSERT INTO tags (name, slug) VALUES ('SQL', 'sql');
INSERT INTO tags (name, slug) VALUES ('DevOps', 'devops');
INSERT INTO tags (name, slug) VALUES ('Career', 'career');

-- Posts
INSERT INTO posts (title, slug, excerpt, body, author_id, category_id, status, is_featured, published_at)
VALUES ('Getting Started with SQL', 'getting-started-with-sql', 'A beginner-friendly guide to SQL databases.',
    'SQL (Structured Query Language) is the standard language for managing relational databases...',
    (SELECT id FROM authors WHERE username = 'editor'),
    (SELECT id FROM categories WHERE slug = 'tutorials'),
    'published', 1, SYSTIMESTAMP);

INSERT INTO posts (title, slug, excerpt, body, author_id, category_id, status, is_featured, published_at)
VALUES ('10 Tips for Remote Work', '10-tips-remote-work', 'Boost your productivity while working from home.',
    'Working remotely has become the new normal. Here are 10 tips...',
    (SELECT id FROM authors WHERE username = 'writer'),
    (SELECT id FROM categories WHERE slug = 'lifestyle'),
    'published', 0, SYSTIMESTAMP);

INSERT INTO posts (title, slug, excerpt, body, author_id, category_id, status, is_featured)
VALUES ('Draft: AI in 2026', 'draft-ai-2026', NULL,
    'Exploring the latest advances in artificial intelligence...',
    (SELECT id FROM authors WHERE username = 'editor'),
    (SELECT id FROM categories WHERE slug = 'technology'),
    'draft', 0);

-- Post tags
INSERT INTO post_tags (post_id, tag_id)
VALUES ((SELECT id FROM posts WHERE slug = 'getting-started-with-sql'), (SELECT id FROM tags WHERE slug = 'sql'));

INSERT INTO post_tags (post_id, tag_id)
VALUES ((SELECT id FROM posts WHERE slug = '10-tips-remote-work'), (SELECT id FROM tags WHERE slug = 'career'));

-- Comments
INSERT INTO comments (post_id, author_name, author_email, body, is_approved)
VALUES ((SELECT id FROM posts WHERE slug = 'getting-started-with-sql'), 'Sam Reader', 'sam@example.com', 'Great intro article! Very helpful.', 1);

INSERT INTO comments (post_id, author_name, author_email, body, is_approved)
VALUES ((SELECT id FROM posts WHERE slug = 'getting-started-with-sql'), 'Tina Learner', 'tina@example.com', 'Could you also cover JOINs in detail?', 1);

COMMIT;
