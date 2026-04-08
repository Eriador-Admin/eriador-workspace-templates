# Agent Instructions — {{PROJECT_NAME}}

This is a Docker containerization project.

## Tech Stack
- **Container**: Docker with multi-stage builds
- **Orchestration**: Docker Compose
- **Sample App**: Express + TypeScript

## Key Conventions
- `Dockerfile` — production multi-stage build
- `Dockerfile.dev` — development with hot reload
- `docker-compose.yml` — production services
- `docker-compose.dev.yml` — development overrides
- `.dockerignore` — context exclusions
- Health checks defined in compose files
