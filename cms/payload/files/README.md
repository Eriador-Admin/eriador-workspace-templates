# {{PROJECT_NAME}}

[Payload CMS](https://payloadcms.com/) — self-hosted, TypeScript-first headless CMS with admin panel.

## Getting Started

```bash
bash init.sh    # install deps + start MongoDB
bash run.sh     # start Payload
bash stop.sh    # stop everything
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| Admin Panel | `http://localhost:3000/admin` | Visual content editor |
| REST API | `http://localhost:3000/api` | Auto-generated REST endpoints |
| GraphQL | `http://localhost:3000/api/graphql` | GraphQL playground |

## Collections

- **Users**: Auth-enabled collection for admin users
- **Posts**: Blog posts with title, content, status, author
- **Media**: File/image uploads with auto-resizing

## Project Structure

```
src/
  payload.config.ts     # Main Payload config
  server.ts             # Express + Payload init
  collections/
    Users.ts            # Users collection
    Posts.ts            # Posts collection
    Media.ts            # Media collection
docker-compose.yml      # MongoDB
```

## Requirements

- Node.js 18+
- Docker (for MongoDB)
