# Agent Instructions — {{PROJECT_NAME}}

This is a multi-service Docker Compose architecture.

## Tech Stack
- **Gateway**: Nginx (reverse proxy / API gateway)
- **Services**: Node.js microservices
- **Orchestration**: Docker Compose

## Key Conventions
- Each service in its own directory with Dockerfile
- Nginx gateway routes by path prefix to services
- Services communicate via Docker network (service names as hostnames)
- Each service is independently deployable
- Shared nothing architecture — no shared databases

## File Patterns
- `docker-compose.yml` → Service orchestration
- `gateway/nginx.conf` → API routing rules
- `services/<name>/` → Individual microservice with its own Dockerfile
- `services/<name>/src/index.js` → Service entry point
