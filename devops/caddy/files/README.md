# {{PROJECT_NAME}}

[Caddy](https://caddyserver.com/) web server with automatic HTTPS, reverse proxy, and load balancing.

## Getting Started

```bash
bash init.sh    # build and start everything
bash run.sh     # follow logs
bash stop.sh    # stop all services
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| Caddy | `http://localhost` | Main entry (auto-redirects to HTTPS in production) |
| API proxy | `http://localhost/api/*` | Load balanced to API backends |
| Static | `http://localhost/` | File server for static assets |
| Metrics | `http://localhost:2019/metrics` | Caddy admin API |

## Why Caddy?

- **Automatic HTTPS** — obtains and renews Let's Encrypt certs with zero config
- **Simple config** — Caddyfile is human-readable, no YAML/XML
- **HTTP/3** — supported out of the box
- **Zero downtime reloads** — `caddy reload` swaps config live

## Project Structure

```
Caddyfile                # Caddy configuration
caddy/
  Caddyfile.production   # Production config with real domains
services/
  api/Dockerfile         # Sample API backend
static/
  index.html             # Sample static page
docker-compose.yml
```

## Production Setup

Replace `localhost` in `caddy/Caddyfile.production` with your domain:

```
example.com {
    reverse_proxy /api/* api:3000
    file_server
}
```

Caddy will automatically obtain an SSL certificate from Let's Encrypt.

## Requirements

- Docker
- Docker Compose
