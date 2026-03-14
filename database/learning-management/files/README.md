# {{APP_NAME}}

Learning Management database schema for **{{DB_VENDOR}}**.

## Quick Start

```bash
bash init.sh
```

## Tables

| Table | Purpose |
|-------|---------|
| instructors | Course creators / teachers |
| courses | Course catalogue with pricing |
| modules | Sections within a course |
| lessons | Individual content items (video, text, quiz) |
| students | Enrolled learners |
| enrollments | Student ↔ Course with progress tracking |
| lesson_progress | Per-lesson completion tracking |
| quizzes | Assessments linked to lessons |
| quiz_questions | Multiple-choice questions with JSON options |
| quiz_attempts | Student quiz results and answers |

## Course Lifecycle

`draft` → `published` → `archived`

## Difficulty Levels

beginner · intermediate · advanced
