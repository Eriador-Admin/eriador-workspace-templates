-- {{APP_NAME}} Learning Management Schema — SQLite

-- Instructors
CREATE TABLE instructors (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    email      TEXT NOT NULL UNIQUE,
    name       TEXT NOT NULL,
    bio        TEXT,
    avatar_url TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_instructors_updated AFTER UPDATE ON instructors
BEGIN UPDATE instructors SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Courses
CREATE TABLE courses (
    id            TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    instructor_id TEXT NOT NULL REFERENCES instructors (id),
    title         TEXT NOT NULL,
    slug          TEXT NOT NULL UNIQUE,
    description   TEXT,
    difficulty    TEXT NOT NULL DEFAULT 'beginner' CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    status        TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
    price         REAL NOT NULL DEFAULT 0.00,
    thumbnail_url TEXT,
    created_at    TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_courses_instructor ON courses (instructor_id);
CREATE INDEX idx_courses_status ON courses (status);

CREATE TRIGGER trg_courses_updated AFTER UPDATE ON courses
BEGIN UPDATE courses SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Modules
CREATE TABLE modules (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    course_id  TEXT NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    title      TEXT NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_modules_course ON modules (course_id);

-- Lessons
CREATE TABLE lessons (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    module_id    TEXT NOT NULL REFERENCES modules (id) ON DELETE CASCADE,
    title        TEXT NOT NULL,
    content_type TEXT NOT NULL DEFAULT 'video' CHECK (content_type IN ('video', 'text', 'quiz')),
    content_url  TEXT,
    content_text TEXT,
    duration_min INTEGER,
    sort_order   INTEGER NOT NULL DEFAULT 0,
    is_free      INTEGER NOT NULL DEFAULT 0,
    created_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_lessons_module ON lessons (module_id);

-- Students
CREATE TABLE students (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    email      TEXT NOT NULL UNIQUE,
    name       TEXT NOT NULL,
    avatar_url TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TRIGGER trg_students_updated AFTER UPDATE ON students
BEGIN UPDATE students SET updated_at = datetime('now') WHERE id = NEW.id; END;

-- Enrollments
CREATE TABLE enrollments (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    student_id   TEXT NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    course_id    TEXT NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    status       TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'cancelled')),
    progress     REAL NOT NULL DEFAULT 0.00,
    enrolled_at  TEXT NOT NULL DEFAULT (datetime('now')),
    completed_at TEXT,
    UNIQUE (student_id, course_id)
);

CREATE INDEX idx_enrollments_student ON enrollments (student_id);
CREATE INDEX idx_enrollments_course ON enrollments (course_id);

-- Lesson progress
CREATE TABLE lesson_progress (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    student_id   TEXT NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    lesson_id    TEXT NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    is_completed INTEGER NOT NULL DEFAULT 0,
    completed_at TEXT,
    UNIQUE (student_id, lesson_id)
);

-- Quizzes
CREATE TABLE quizzes (
    id         TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    lesson_id  TEXT NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    title      TEXT NOT NULL,
    pass_score REAL NOT NULL DEFAULT 70.00,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Quiz questions
CREATE TABLE quiz_questions (
    id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    quiz_id     TEXT NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    question    TEXT NOT NULL,
    options     TEXT NOT NULL DEFAULT '[]',
    correct_idx INTEGER NOT NULL,
    sort_order  INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_quiz_questions_quiz ON quiz_questions (quiz_id);

-- Quiz attempts
CREATE TABLE quiz_attempts (
    id           TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    student_id   TEXT NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    quiz_id      TEXT NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    score        REAL NOT NULL,
    passed       INTEGER NOT NULL,
    answers      TEXT NOT NULL DEFAULT '[]',
    attempted_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_quiz_attempts_student ON quiz_attempts (student_id);
