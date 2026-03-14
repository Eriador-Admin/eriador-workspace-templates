# {{APP_NAME}} — Learning Management Database

## Agent Guidelines
- This is a **database-only** template (SQL schemas + seed data).
- Vendor chosen at scaffold time: **{{DB_VENDOR}}**.
- Run `bash init.sh` to apply schema and seed data.
- Tables: instructors, courses, modules, lessons, students, enrollments, lesson_progress, quizzes, quiz_questions, quiz_attempts.
- Course lifecycle: draft → published → archived.
- Difficulty levels: beginner, intermediate, advanced.
- Enrollment statuses: active, completed, cancelled.
- Content types: video, text, quiz.
- Quizzes have a configurable pass_score (default 70%).
- Quiz answers stored as JSON arrays.
