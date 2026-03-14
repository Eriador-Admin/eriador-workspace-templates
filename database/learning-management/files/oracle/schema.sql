-- {{APP_NAME}} Learning Management Schema — Oracle

-- Instructors
CREATE TABLE instructors (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email      VARCHAR2(255) NOT NULL UNIQUE,
    name       VARCHAR2(200) NOT NULL,
    bio        CLOB,
    avatar_url VARCHAR2(500),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_instructors_updated
BEFORE UPDATE ON instructors FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Courses
CREATE TABLE courses (
    id            RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    instructor_id RAW(16) NOT NULL REFERENCES instructors (id),
    title         VARCHAR2(300) NOT NULL,
    slug          VARCHAR2(320) NOT NULL UNIQUE,
    description   CLOB,
    difficulty    VARCHAR2(15) DEFAULT 'beginner' NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    status        VARCHAR2(15) DEFAULT 'draft' NOT NULL CHECK (status IN ('draft', 'published', 'archived')),
    price         NUMBER(10,2) DEFAULT 0.00 NOT NULL,
    thumbnail_url VARCHAR2(500),
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at    TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_courses_instructor ON courses (instructor_id);
CREATE INDEX idx_courses_status ON courses (status);

CREATE OR REPLACE TRIGGER trg_courses_updated
BEFORE UPDATE ON courses FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Modules
CREATE TABLE modules (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    course_id  RAW(16) NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    title      VARCHAR2(300) NOT NULL,
    sort_order NUMBER(5) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_modules_course ON modules (course_id);

-- Lessons
CREATE TABLE lessons (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    module_id    RAW(16) NOT NULL REFERENCES modules (id) ON DELETE CASCADE,
    title        VARCHAR2(300) NOT NULL,
    content_type VARCHAR2(10) DEFAULT 'video' NOT NULL CHECK (content_type IN ('video', 'text', 'quiz')),
    content_url  VARCHAR2(500),
    content_text CLOB,
    duration_min NUMBER(5),
    sort_order   NUMBER(5) DEFAULT 0 NOT NULL,
    is_free      NUMBER(1) DEFAULT 0 NOT NULL,
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_lessons_module ON lessons (module_id);

-- Students
CREATE TABLE students (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    email      VARCHAR2(255) NOT NULL UNIQUE,
    name       VARCHAR2(200) NOT NULL,
    avatar_url VARCHAR2(500),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER trg_students_updated
BEFORE UPDATE ON students FOR EACH ROW
BEGIN :NEW.updated_at := SYSTIMESTAMP; END;
/

-- Enrollments
CREATE TABLE enrollments (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    student_id   RAW(16) NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    course_id    RAW(16) NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    status       VARCHAR2(15) DEFAULT 'active' NOT NULL CHECK (status IN ('active', 'completed', 'cancelled')),
    progress     NUMBER(5,2) DEFAULT 0.00 NOT NULL,
    enrolled_at  TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    completed_at TIMESTAMP WITH TIME ZONE,
    CONSTRAINT uq_enrollment UNIQUE (student_id, course_id)
);

CREATE INDEX idx_enrollments_student ON enrollments (student_id);
CREATE INDEX idx_enrollments_course ON enrollments (course_id);

-- Lesson progress
CREATE TABLE lesson_progress (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    student_id   RAW(16) NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    lesson_id    RAW(16) NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    is_completed NUMBER(1) DEFAULT 0 NOT NULL,
    completed_at TIMESTAMP WITH TIME ZONE,
    CONSTRAINT uq_lesson_progress UNIQUE (student_id, lesson_id)
);

-- Quizzes
CREATE TABLE quizzes (
    id         RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    lesson_id  RAW(16) NOT NULL REFERENCES lessons (id) ON DELETE CASCADE,
    title      VARCHAR2(300) NOT NULL,
    pass_score NUMBER(5,2) DEFAULT 70.00 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

-- Quiz questions
CREATE TABLE quiz_questions (
    id          RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    quiz_id     RAW(16) NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    question    CLOB NOT NULL,
    options     CLOB DEFAULT '[]' NOT NULL,
    correct_idx NUMBER(5) NOT NULL,
    sort_order  NUMBER(5) DEFAULT 0 NOT NULL
);

CREATE INDEX idx_quiz_questions_quiz ON quiz_questions (quiz_id);

-- Quiz attempts
CREATE TABLE quiz_attempts (
    id           RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    student_id   RAW(16) NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    quiz_id      RAW(16) NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    score        NUMBER(5,2) NOT NULL,
    passed       NUMBER(1) NOT NULL,
    answers      CLOB DEFAULT '[]' NOT NULL,
    attempted_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE INDEX idx_quiz_attempts_student ON quiz_attempts (student_id);
