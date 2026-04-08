# Agent Instructions — {{PROJECT_NAME}}

This is an Nginx reverse proxy and load balancer project.

## Tech Stack
- **Web Server**: Nginx (official Docker image)
- **Backend**: Sample Node.js API containers
- **Infrastructure**: Docker Compose

## Key Conventions
- Main config: `nginx/nginx.conf`
- Server blocks: `nginx/conf.d/*.conf`
- Upstream backends defined in `nginx/conf.d/default.conf`
- Static files served from `/usr/share/nginx/html`
- SSL certs in `nginx/ssl/` (self-signed for dev)
- Logs in Docker stdout/stderr
- Rate limiting via `limit_req_zone` directive
