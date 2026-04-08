# {{PROJECT_NAME}}

A multi-service architecture with Docker Compose and Nginx API gateway.

## Architecture

```
                ┌──────────┐
  Client ──────►│  Nginx   │
                │ Gateway  │
                └────┬─────┘
                     │
            ┌────────┴────────┐
            ▼                 ▼
      ┌──────────┐     ┌──────────┐
      │ Users    │     │ Products │
      │ Service  │     │ Service  │
      └──────────┘     └──────────┘
```

## Getting Started

```bash
bash init.sh    # build all services
bash run.sh     # start all services
bash stop.sh    # stop all services
```

## Services

| Service  | Internal Port | Path          |
|----------|--------------|---------------|
| Gateway  | {{GATEWAY_PORT}} | /         |
| Users    | 3001         | /api/users    |
| Products | 3002         | /api/products |

## Requirements

- Docker & Docker Compose
