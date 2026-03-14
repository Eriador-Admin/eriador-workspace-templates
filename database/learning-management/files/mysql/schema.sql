-- {{APP_NAME}} Learning Management Schema — MySQL

-- Instructors
CREATE TABLE instructors (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    bio        TEXT,
    avatar_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Courses
CREATE TABLE courses (
    id            CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    instructor_id CHAR(36) NOT NULL,
    title         VARCHAR(300) NOT NULL,
    slug          VARCHAR(320) NOT NULL UNIQUE,
    description   TEXT,
    difficulty    ENUM('beginner', 'intermediate', 'advanced') NOT NULL DEFAULT 'beginner',
    status        ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    price         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    thumbnail_url VARCHAR(500),
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES instructors (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_courses_instructor ON courses (instructor_id);
CREATE INDEX idx_courses_status ON courses (status);

-- Modules
CREATE TABLE modules (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    course_id  CHAR(36) NOT NULL,
    title      VARCHAR(300) NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_modules_course ON modules (course_id);

-- Lessons
CREATE TABLE lessons (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    module_id    CHAR(36) NOT NULL,
    title        VARCHAR(300) NOT NULL,
    content_type ENUM('video', 'text', 'quiz') NOT NULL DEFAULT 'video',
    content_url  VARCHAR(500),
    content_text TEXT,
    duration_min INTEGER,
    sort_order   INTEGER NOT NULL DEFAULT 0,
    is_free      BOOLEAN NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (module_id) REFERENCES modules (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_lessons_module ON lessons (module_id);

-- Students
CREATE TABLE students (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email      VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(200) NOT NULL,
    avatar_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Enrollments
CREATE TABLE enrollments (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    student_id   CHAR(36) NOT NULL,
    course_id    CHAR(36) NOT NULL,
    status       ENUM('active', 'completed', 'cancelled') NOT NULL DEFAULT 'active',
    progress     DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    enrolled_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_enrollments_student ON enrollments (student_id);
CREATE INDEX idx_enrollments_course ON enrollments (course_id);

-- Lesson progress
CREATE TABLE lesson_progress (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    student_id   CHAR(36) NOT NULL,
    lesson_id    CHAR(36) NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    completed_at TIMESTAMP NULL,
    UNIQUE (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Quizzes
CREATE TABLE quizzes (
    id         CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    lesson_id  CHAR(36) NOT NULL,
    title      VARCHAR(300) NOT NULL,
    pass_score DECIMAL(5,2) NOT NULL DEFAULT 70.00,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lesson_id) REFERENCES lessons (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Quiz questions
CREATE TABLE quiz_questions (
    id          CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    quiz_id     CHAR(36) NOT NULL,
    question    TEXT NOT NULL,
    options     JSON NOT NULL,
    correct_idx INTEGER NOT NULL,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_quiz_questions_quiz ON quiz_questions (quiz_id);

-- Quiz attempts
CREATE TABLE quiz_attempts (
    id           CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    student_id   CHAR(36) NOT NULL,
    quiz_id      CHAR(36) NOT NULL,
    score        DECIMAL(5,2) NOT NULL,
    passed       BOOLEAN NOT NULL,
    answers      JSON NOT NULL,
    attempted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_quiz_attempts_student ON quiz_attempts (student_id);
