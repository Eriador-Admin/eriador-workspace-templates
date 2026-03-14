-- {{APP_NAME}} Seed Data — SQLite

-- Instructors
INSERT INTO instructors (id, email, name, bio) VALUES
    ('i0000001-0000-4000-a000-000000000001', 'prof.smith@university.edu', 'Prof. Smith',  'Computer Science professor with 15 years of experience.'),
    ('i0000001-0000-4000-a000-000000000002', 'dr.jones@academy.com',     'Dr. Jones',     'Data scientist and machine learning researcher.');

-- Courses
INSERT INTO courses (id, instructor_id, title, slug, description, difficulty, status, price) VALUES
    ('co000001-0000-4000-a000-000000000001',
     'i0000001-0000-4000-a000-000000000001',
     'Introduction to SQL', 'intro-to-sql',
     'Learn the fundamentals of relational databases and SQL queries.',
     'beginner', 'published', 29.99),
    ('co000001-0000-4000-a000-000000000002',
     'i0000001-0000-4000-a000-000000000002',
     'Machine Learning Fundamentals', 'ml-fundamentals',
     'Build your first ML models with Python and scikit-learn.',
     'intermediate', 'published', 49.99);

-- Modules
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    ('m0000001-0000-4000-a000-000000000001', 'co000001-0000-4000-a000-000000000001', 'Getting Started',    1),
    ('m0000001-0000-4000-a000-000000000002', 'co000001-0000-4000-a000-000000000001', 'SELECT Queries',     2),
    ('m0000001-0000-4000-a000-000000000003', 'co000001-0000-4000-a000-000000000001', 'Joins & Subqueries', 3),
    ('m0000001-0000-4000-a000-000000000004', 'co000001-0000-4000-a000-000000000002', 'Python Refresher',   1),
    ('m0000001-0000-4000-a000-000000000005', 'co000001-0000-4000-a000-000000000002', 'Supervised Learning', 2);

-- Lessons
INSERT INTO lessons (id, module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    ('l0000001-0000-4000-a000-000000000001', 'm0000001-0000-4000-a000-000000000001', 'What is a Database?',    'video', 12, 1, 1),
    ('l0000001-0000-4000-a000-000000000002', 'm0000001-0000-4000-a000-000000000001', 'Installing PostgreSQL',  'text', NULL, 2, 1),
    ('l0000001-0000-4000-a000-000000000003', 'm0000001-0000-4000-a000-000000000002', 'Your First SELECT',      'video', 18, 1, 0),
    ('l0000001-0000-4000-a000-000000000004', 'm0000001-0000-4000-a000-000000000004', 'Python Basics Review',   'video', 25, 1, 1);

-- Students
INSERT INTO students (id, email, name) VALUES
    ('s0000001-0000-4000-a000-000000000001', 'alice@student.com', 'Alice Learner'),
    ('s0000001-0000-4000-a000-000000000002', 'bob@student.com',   'Bob Scholar');

-- Enrollments
INSERT INTO enrollments (student_id, course_id, status, progress) VALUES
    ('s0000001-0000-4000-a000-000000000001', 'co000001-0000-4000-a000-000000000001', 'active', 33.33),
    ('s0000001-0000-4000-a000-000000000002', 'co000001-0000-4000-a000-000000000001', 'active', 0.00),
    ('s0000001-0000-4000-a000-000000000001', 'co000001-0000-4000-a000-000000000002', 'active', 50.00);

-- Quizzes
INSERT INTO quizzes (id, lesson_id, title, pass_score) VALUES
    ('q0000001-0000-4000-a000-000000000001', 'l0000001-0000-4000-a000-000000000003', 'SELECT Basics Quiz', 70.00);

-- Quiz questions
INSERT INTO quiz_questions (quiz_id, question, options, correct_idx, sort_order) VALUES
    ('q0000001-0000-4000-a000-000000000001', 'Which keyword retrieves data from a table?', '["INSERT", "SELECT", "UPDATE", "DELETE"]', 1, 1),
    ('q0000001-0000-4000-a000-000000000001', 'What does WHERE do?', '["Sorts results", "Filters rows", "Groups results", "Joins tables"]', 1, 2);

-- Quiz attempt
INSERT INTO quiz_attempts (student_id, quiz_id, score, passed, answers) VALUES
    ('s0000001-0000-4000-a000-000000000001', 'q0000001-0000-4000-a000-000000000001', 100.00, 1, '[1, 1]');
