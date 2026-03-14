-- {{APP_NAME}} Seed Data — Oracle

-- Instructors
INSERT INTO instructors (id, email, name, bio) VALUES
    (HEXTORAW('1A00000100004000A000000000000001'), 'prof.smith@university.edu', 'Prof. Smith', 'Computer Science professor with 15 years of experience.');
INSERT INTO instructors (id, email, name, bio) VALUES
    (HEXTORAW('1A00000100004000A000000000000002'), 'dr.jones@academy.com', 'Dr. Jones', 'Data scientist and machine learning researcher.');

-- Courses
INSERT INTO courses (id, instructor_id, title, slug, description, difficulty, status, price) VALUES
    (HEXTORAW('2A00000100004000A000000000000001'),
     HEXTORAW('1A00000100004000A000000000000001'),
     'Introduction to SQL', 'intro-to-sql',
     'Learn the fundamentals of relational databases and SQL queries.',
     'beginner', 'published', 29.99);
INSERT INTO courses (id, instructor_id, title, slug, description, difficulty, status, price) VALUES
    (HEXTORAW('2A00000100004000A000000000000002'),
     HEXTORAW('1A00000100004000A000000000000002'),
     'Machine Learning Fundamentals', 'ml-fundamentals',
     'Build your first ML models with Python and scikit-learn.',
     'intermediate', 'published', 49.99);

-- Modules
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    (HEXTORAW('3A00000100004000A000000000000001'), HEXTORAW('2A00000100004000A000000000000001'), 'Getting Started', 1);
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    (HEXTORAW('3A00000100004000A000000000000002'), HEXTORAW('2A00000100004000A000000000000001'), 'SELECT Queries', 2);
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    (HEXTORAW('3A00000100004000A000000000000003'), HEXTORAW('2A00000100004000A000000000000001'), 'Joins and Subqueries', 3);
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    (HEXTORAW('3A00000100004000A000000000000004'), HEXTORAW('2A00000100004000A000000000000002'), 'Python Refresher', 1);
INSERT INTO modules (id, course_id, title, sort_order) VALUES
    (HEXTORAW('3A00000100004000A000000000000005'), HEXTORAW('2A00000100004000A000000000000002'), 'Supervised Learning', 2);

-- Lessons
INSERT INTO lessons (id, module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    (HEXTORAW('4A00000100004000A000000000000001'), HEXTORAW('3A00000100004000A000000000000001'), 'What is a Database?', 'video', 12, 1, 1);
INSERT INTO lessons (id, module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    (HEXTORAW('4A00000100004000A000000000000002'), HEXTORAW('3A00000100004000A000000000000001'), 'Installing PostgreSQL', 'text', NULL, 2, 1);
INSERT INTO lessons (id, module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    (HEXTORAW('4A00000100004000A000000000000003'), HEXTORAW('3A00000100004000A000000000000002'), 'Your First SELECT', 'video', 18, 1, 0);
INSERT INTO lessons (id, module_id, title, content_type, duration_min, sort_order, is_free) VALUES
    (HEXTORAW('4A00000100004000A000000000000004'), HEXTORAW('3A00000100004000A000000000000004'), 'Python Basics Review', 'video', 25, 1, 1);

-- Students
INSERT INTO students (id, email, name) VALUES
    (HEXTORAW('5B00000100004000A000000000000001'), 'alice@student.com', 'Alice Learner');
INSERT INTO students (id, email, name) VALUES
    (HEXTORAW('5B00000100004000A000000000000002'), 'bob@student.com', 'Bob Scholar');

-- Enrollments
INSERT INTO enrollments (student_id, course_id, status, progress) VALUES
    (HEXTORAW('5B00000100004000A000000000000001'), HEXTORAW('2A00000100004000A000000000000001'), 'active', 33.33);
INSERT INTO enrollments (student_id, course_id, status, progress) VALUES
    (HEXTORAW('5B00000100004000A000000000000002'), HEXTORAW('2A00000100004000A000000000000001'), 'active', 0.00);
INSERT INTO enrollments (student_id, course_id, status, progress) VALUES
    (HEXTORAW('5B00000100004000A000000000000001'), HEXTORAW('2A00000100004000A000000000000002'), 'active', 50.00);

-- Quizzes
INSERT INTO quizzes (id, lesson_id, title, pass_score) VALUES
    (HEXTORAW('6A00000100004000A000000000000001'), HEXTORAW('4A00000100004000A000000000000003'), 'SELECT Basics Quiz', 70.00);

-- Quiz questions
INSERT INTO quiz_questions (quiz_id, question, options, correct_idx, sort_order) VALUES
    (HEXTORAW('6A00000100004000A000000000000001'), 'Which keyword retrieves data from a table?', '["INSERT", "SELECT", "UPDATE", "DELETE"]', 1, 1);
INSERT INTO quiz_questions (quiz_id, question, options, correct_idx, sort_order) VALUES
    (HEXTORAW('6A00000100004000A000000000000001'), 'What does WHERE do?', '["Sorts results", "Filters rows", "Groups results", "Joins tables"]', 1, 2);

-- Quiz attempt
INSERT INTO quiz_attempts (student_id, quiz_id, score, passed, answers) VALUES
    (HEXTORAW('5B00000100004000A000000000000001'), HEXTORAW('6A00000100004000A000000000000001'), 100.00, 1, '[1, 1]');

COMMIT;
