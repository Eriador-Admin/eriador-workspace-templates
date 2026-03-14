# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item     | Detail                                                     |
| -------- | ---------------------------------------------------------- |
| Type     | Database schema template                                   |
| Schema   | Blog / CMS (posts, authors, tags, comments, media)         |
| Vendors  | PostgreSQL, MySQL, SQLite, Oracle                          |

## Tables

| Table        | Purpose                                         |
| ------------ | ----------------------------------------------- |
| `authors`    | Content authors with credentials and profiles   |
| `categories` | Post categories (supports nesting via parent_id)|
| `posts`      | Blog posts with status workflow and excerpts    |
| `tags`       | Flat tag list for flexible labeling             |
| `post_tags`  | Many-to-many junction between posts and tags    |
| `comments`   | Reader comments with threaded replies           |
| `media`      | Uploaded files (images, documents, etc.)        |

## Post Status Flow

`draft` → `published` → `archived`

## Comment Threading

Comments support one level of threading via `parent_id` self-reference.

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

## Environment Variables

Same structure as other database templates — see `.env.example` for per-vendor connection details.

## Vendor Differences

- **PostgreSQL**: `TEXT` body, `TIMESTAMPTZ`, `JSONB`-ready, partial indexes for published/featured posts
- **MySQL**: `LONGTEXT` body, `InnoDB` + `utf8mb4`, `ON UPDATE CURRENT_TIMESTAMP`
- **SQLite**: `TEXT` types, `INTEGER` booleans, `randomblob` UUIDs, `AFTER UPDATE` triggers
- **Oracle**: `CLOB` body, `RAW(16)` SYS_GUID() UUIDs, `NUMBER(1)` booleans, `BEFORE UPDATE` triggers
