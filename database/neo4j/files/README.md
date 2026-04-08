# {{PROJECT_NAME}}

[Neo4j](https://neo4j.com/) graph database with Cypher queries and a social network example.

## Getting Started

```bash
bash init.sh    # install deps + start Neo4j + seed data
bash run.sh     # start the API
bash stop.sh    # stop everything
```

## Services

| Service | URL | Credentials |
|---------|-----|-------------|
| API | `http://localhost:3000` | - |
| Neo4j Browser | `http://localhost:7474` | neo4j / password |

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/people` | List all people |
| POST | `/people` | Create a person |
| POST | `/people/:name/follows/:target` | Create a FOLLOWS relationship |
| GET | `/people/:name/followers` | Get followers |
| GET | `/people/:name/recommendations` | Friend-of-friend suggestions |
| GET | `/health` | Health check |

## Project Structure

```
src/
  app.ts        # Express API
  neo4j.ts      # Neo4j driver setup
  seed.ts       # Seed script with sample social graph
docker-compose.yml
```

## Requirements

- Node.js 18+
- Docker
