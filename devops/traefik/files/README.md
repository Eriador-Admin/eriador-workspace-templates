# {{PROJECT_NAME}}

[Traefik](https://traefik.io/) reverse proxy with Docker auto-discovery and sample backend services.

## Getting Started

```bash
bash init.sh    # start Traefik + sample services
bash run.sh     # (services already started by init)
bash stop.sh    # stop everything
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| Traefik Dashboard | `http://localhost:8080` | Routers, services, middlewares |
| API Service | `http://api.localhost` | Sample backend API |
| Web Service | `http://web.localhost` | Sample web service |

## Features

- Docker container auto-discovery via labels
- Path-based and host-based routing
- Rate limiting middleware
- Health checks
- Let's Encrypt TLS (production config included)

## Project Structure

```
traefik/
  traefik.yml         # Static config
  dynamic.yml         # Dynamic config (middlewares, TLS)
services/
  api/Dockerfile      # Sample API service
  web/Dockerfile      # Sample web service
docker-compose.yml    # Full stack
```

## Adding a New Service

Add Docker labels to auto-register with Traefik:

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.myapp.rule=Host(`myapp.localhost`)"
  - "traefik.http.services.myapp.loadbalancer.server.port=3000"
```

## Requirements

- Docker
- Docker Compose
