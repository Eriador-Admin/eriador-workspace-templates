# Agent Instructions — {{PROJECT_NAME}}

This is a Caddy web server project.

## Tech Stack
- **Web Server**: Caddy v2
- **Backend**: Sample Node.js API containers
- **Infrastructure**: Docker Compose

## Key Conventions
- Config in `Caddyfile` (not JSON/YAML)
- Caddy auto-provisions HTTPS with Let's Encrypt in production
- Use `localhost` for local dev (uses self-signed cert)
- Admin API on port 2019 (localhost only)
- `caddy reload` for zero-downtime config changes
- Reverse proxy uses `reverse_proxy` directive
- File server uses `file_server` directive
