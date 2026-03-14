-- {{APP_NAME}} Seed Data — MySQL

-- Instructors
INSERT INTO instructors (email, name, bio) VALUES
    ('prof.smith@university.edu', 'Prof. Smith',  'Computer Science professor with 15 years of experience.'),
    ('dr.jones@academy.com',     'Dr. Jones',     'Data scientist and machine learning researcher.');

-- Courses
INSERT INTO courses (instructor_id, title, slug, description, difficulty, status, price) VALUES
    ((SELECT id FROM instructors WHERE email = 'prof.smith@university.edu'),
     'Introduction to SQL', 'intro-to-sql',
     'Learn the fundamentals of relational databases and SQL queries.',
     'beginner', 'published', 29.99),
    ((SELECT id FROM instructors WHERE email = 'dr.jones@academy.com'),
     'Machine Learning Fundamentals', 'ml-fundamentals',
     'Build your first ML models with Python and scikit-learn.',
     'intermediate', 'published', 49.99);

-- Modules
INSERT INTO modules (course_id, title, sort_order) VALUES
    ((SELECT id FROM courses WHERE slug = 'intro-to-sql'), 'Getting Started',    1),
    ((SELECT id FROM courses WHERE slug = 'intro-to-sql'), 'SELECT Queries',     2),
    ((SELECT id FROM courses WHERE slug = 'intro-to-sql'), 'Joins & Subqueries', 3),
    ((SELECT id FROM courses WHERE slug = 'ml-fundamentals'), 'Python Refresher',  1),
    ((SELECT id FROM courses WHERE slug = 'ml-fundamentals'), 'Supervised Learning', 2);

-- Lessons
INSERT INTO lessons (module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    ((SELECT id FROM modules WHERE title = 'Getting Started' AND course_id = (SELECT id FROM courses WHERE slug = 'intro-to-sql')),
     'What is a Database?', 'video', 12, 1, TRUE),
    ((SELECT id FROM modules WHERE title = 'Getting Started' AND course_id = (SELECT id FROM courses WHERE slug = 'intro-to-sql')),
     'Installing PostgreSQL', 'text', NULL, 2, TRUE),
    ((SELECT id FROM modules WHERE title = 'SELECT Queries' AND course_id = (SELECT id FROM courses WHERE slug = 'intro-to-sql')),
     'Your First SELECT', 'video', 18, 1, FALSE),
    ((SELECT id FROM modules WHERE title = 'Python Refresher' AND course_id = (SELECT id FROM courses WHERE slug = 'ml-fundamentals')),
     'Python Basics Review', 'video', 25, 1, TRUE);

-- Students
INSERT INTO students (email, name) VALUES
    ('alice@student.com', 'Alice Learner'),
    ('bob@student.com',   'Bob Scholar');

-- Enrollments
INSERT INTO enrollments (student_id, course_id, status, progress) VALUES
    ((SELECT id FROM students WHERE email = 'alice@student.com'),
     (SELECT id FROM courses WHERE slug = 'intro-to-sql'), 'active', 33.33),
    ((SELECT id FROM students WHERE email = 'bob@student.com'),
     (SELECT id FROM courses WHERE slug = 'intro-to-sql'), 'active', 0.00),
    ((SELECT id FROM students WHERE email = 'alice@student.com'),
     (SELECT id FROM courses WHERE slug = 'ml-fundamentals'), 'active', 50.00);

-- Quizzes
INSERT INTO quizzes (lesson_id, title, pass_score) VALUES
    ((SELECT id FROM lessons WHERE title = 'Your First SELECT'), 'SELECT Basics Quiz', 70.00);

-- Quiz questions
INSERT INTO quiz_questions (quiz_id, question, options, correct_idx, sort_order) VALUES
    ((SELECT id FROM quizzes WHERE title = 'SELECT Basics Quiz'),
     'Which keyword retrieves data from a table?',
     '["INSERT", "SELECT", "UPDATE", "DELETE"]', 1, 1),
    ((SELECT id FROM quizzes WHERE title = 'SELECT Basics Quiz'),
     'What does WHERE do?',
     '["Sorts results", "Filters rows", "Groups results", "Joins tables"]', 1, 2);

-- Quiz attempt
INSERT INTO quiz_attempts (student_id, quiz_id, score, passed, answers) VALUES
    ((SELECT id FROM students WHERE email = 'alice@student.com'),
     (SELECT id FROM quizzes WHERE title = 'SELECT Basics Quiz'),
     100.00, TRUE, '[1, 1]');
