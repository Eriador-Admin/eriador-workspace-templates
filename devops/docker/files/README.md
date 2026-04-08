# {{PROJECT_NAME}}

Production-ready Docker setup with multi-stage builds and Docker Compose.

## Getting Started

```bash
bash init.sh    # build images
bash run.sh     # start all services
bash stop.sh    # stop all services
```

## Project Structure

```
src/
  app.ts            # Sample Express app
Dockerfile          # Multi-stage production build
Dockerfile.dev      # Development build with hot reload
docker-compose.yml  # Production services
docker-compose.dev.yml  # Development override
.dockerignore       # Files excluded from Docker context
```

## Commands

```bash
# Production
docker compose up -d --build

# Development (with hot reload)
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build

# View logs
docker compose logs -f app

# Shell into container
docker compose exec app sh
```

## Requirements

- Docker 24+
- Docker Compose v2
