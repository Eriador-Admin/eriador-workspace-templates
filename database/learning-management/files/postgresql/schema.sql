-- {{APP_NAME}} Learning Management Schema — PostgreSQL

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Instructors
CREATE TABLE instructors (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    bio        TEXT,
    avatar_url VARCHAR(500),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Courses
CREATE TABLE courses (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    instructor_id UUID NOT NULL REFERENCES instructors (id),
    title         VARCHAR(300) NOT NULL,
    slug          VARCHAR(320) NOT NULL UNIQUE,
    description   TEXT,
    difficulty    VARCHAR(15) NOT NULL DEFAULT 'beginner' CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    status        VARCHAR(15) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
    price         NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    thumbnail_url VARCHAR(500),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_courses_instructor ON courses (instructor_id);
CREATE INDEX idx_courses_status ON courses (status);

-- Modules (sections within a course)
CREATE TABLE modules (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    course_id  UUID NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    title      VARCHAR(300) NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_modules_course ON modules (course_id);

-- Lessons
CREATE TABLE lessons (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    module_id    UUID NOT NULL REFERENCES modules (id) ON DELETE CASCADE,
    title        VARCHAR(300) NOT NULL,
    content_type VARCHAR(10) NOT NULL DEFAULT 'video' CHECK (content_type IN ('video', 'text', 'quiz')),
    content_url  VARCHAR(500),
    content_text TEXT,
    duration_min INTEGER,
    sort_order   INTEGER NOT NULL DEFAULT 0,
    is_free      BOOLEAN NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_lessons_module ON lessons (module_id);

-- Students
CREATE TABLE students (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    avatar_url VARCHAR(500),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enrollments
CREATE TABLE enrollments (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id  UUID NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    course_id   UUID NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    status      VARCHAR(15) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'cancelled')),
    progress    NUMERIC(5,2) NOT NULL DEFAULT 0.00,
    enrolled_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    UNIQUE (student_id, course_id)
);

CREATE INDEX idx_enrollments_student ON enrollments (student_id);
CREATE INDEX idx_enrollments_course ON enrollments (course_id);

-- Lesson progress
CREATE TABLE lesson_progress (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id  UUID NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    lesson_id   UUID NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    completed_at TIMESTAMPTZ,
    UNIQUE (student_id, lesson_id)
);

-- Quizzes
CREATE TABLE quizzes (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    lesson_id   UUID NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    title       VARCHAR(300) NOT NULL,
    pass_score  NUMERIC(5,2) NOT NULL DEFAULT 70.00,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Quiz questions
CREATE TABLE quiz_questions (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    quiz_id     UUID NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    question    TEXT NOT NULL,
    options     JSONB NOT NULL DEFAULT '[]',
    correct_idx INTEGER NOT NULL,
    sort_order  INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_quiz_questions_quiz ON quiz_questions (quiz_id);

-- Quiz attempts
CREATE TABLE quiz_attempts (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id  UUID NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    quiz_id     UUID NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    score       NUMERIC(5,2) NOT NULL,
    passed      BOOLEAN NOT NULL,
    answers     JSONB NOT NULL DEFAULT '[]',
    attempted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_quiz_attempts_student ON quiz_attempts (student_id);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_instructors_updated BEFORE UPDATE ON instructors FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_courses_updated BEFORE UPDATE ON courses FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_students_updated BEFORE UPDATE ON students FOR EACH ROW EXECUTE FUNCTION update_updated_at();
