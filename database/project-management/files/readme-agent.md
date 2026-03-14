# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                                              |
| -------- | ------------------------------------------------------------------- |
| Type     | Database schema template                                            |
| Schema   | Project Management (projects, boards, columns, tasks, labels)       |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                                   |

## Tables

| Table             | Purpose                                             |
| ----------------- | --------------------------------------------------- |
| `projects`        | Top-level project containers                        |
| `project_members` | Users assigned to a project with role               |
| `boards`          | Kanban boards within a project                      |
| `columns`         | Lanes within a board (Backlog, In Progress, Done)   |
| `labels`          | Color-coded labels scoped per project               |
| `tasks`           | Work items with priority, assignee, and due date    |
| `task_labels`     | Many-to-many junction between tasks and labels      |
| `task_comments`   | Discussion threads on tasks                         |
| `task_activity`   | Change history log per task                         |

## Task Priority Levels

`critical` > `high` > `medium` > `low` > `none`

## Member Roles

`owner` > `admin` > `member` > `viewer`

## Subtasks

Tasks support one level of nesting via `parent_id` self-reference.

## Project Structure

```
├── postgresql/
│   ├── schema.sql
│   └── seed.sql
├── mysql/
│   ├── schema.sql
│   └── seed.sql
├── sqlite/
│   ├── schema.sql
│   └── seed.sql
├── oracle/
│   ├── schema.sql
│   └── seed.sql
├── init.sh
├── .env.example
├── .gitignore
├── readme-agent.md
└── README.md
```

## Vendor Differences

- **PostgreSQL**: `UUID`, `TIMESTAMPTZ`, `NUMERIC(6,1)` estimates, partial index on due_date
- **MySQL**: `CHAR(36)` UUIDs, `DECIMAL(6,1)`, backtick-escaped `columns` (reserved word)
- **SQLite**: `TEXT` types, `REAL` for estimates, `INTEGER` booleans
- **Oracle**: `RAW(16)` SYS_GUID(), `columns_tbl` name (COLUMNS is reserved), HEXTORAW seed IDs
