# {{PROJECT_NAME}}

Enterprise SSO with [Keycloak](https://www.keycloak.org/) and an Express app using OpenID Connect.

## Getting Started

```bash
bash init.sh    # install deps + start Keycloak
bash run.sh     # start the Express app
bash stop.sh    # stop everything
```

## Services

| URL | Description |
|-----|-------------|
| `http://localhost:3000` | Express app |
| `http://localhost:3000/protected` | Protected route (requires login) |
| `http://localhost:8080` | Keycloak admin console (admin/admin) |

## Project Structure

```
src/
  app.ts            # Express app with OIDC middleware
  auth.ts           # Keycloak OIDC configuration
docker-compose.yml  # Keycloak + PostgreSQL
realm-export.json   # Pre-configured Keycloak realm
```

## Setup

1. Keycloak starts with a pre-imported realm
2. Default test user: `testuser` / `password`
3. Client is pre-configured for `http://localhost:3000/*`

## Requirements

- Node.js 18+
- Docker (4GB+ RAM for Keycloak)
