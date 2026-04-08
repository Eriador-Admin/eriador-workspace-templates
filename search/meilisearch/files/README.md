# {{PROJECT_NAME}}

Full-text search powered by [Meilisearch](https://www.meilisearch.com/).

## Getting Started

```bash
bash init.sh    # install deps + start Meilisearch
bash run.sh     # start the search API + seed data
bash stop.sh    # stop everything
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/search?q=term` | Search across all indexed documents |
| POST | `/index` | Index a new document |
| GET | `/health` | Health check |
| — | `http://localhost:7700` | Meilisearch dashboard |

## Project Structure

```
src/
  app.ts            # Express search API
  client.ts         # Meilisearch client setup
  seed.ts           # Seed sample data
  data/
    movies.json     # Sample dataset
docker-compose.yml  # Meilisearch container
```

## Requirements

- Node.js 18+
- Docker
