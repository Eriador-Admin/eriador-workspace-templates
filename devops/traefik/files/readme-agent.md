# Agent Instructions — {{PROJECT_NAME}}

This is a Traefik reverse proxy project.

## Tech Stack
- **Proxy**: Traefik v3
- **Infrastructure**: Docker Compose
- **Sample Services**: Node.js containers

## Key Conventions
- Static config: `traefik/traefik.yml`
- Dynamic config: `traefik/dynamic.yml`
- Services register via Docker labels
- Dashboard at port 8080 (insecure mode for dev)
- Host-based routing: `*.localhost` resolves locally
