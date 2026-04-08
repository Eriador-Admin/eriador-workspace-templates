# {{PROJECT_NAME}}

[HAProxy](https://www.haproxy.org/) high-performance load balancer with stats dashboard, health checks, and multiple balancing algorithms.

## Getting Started

```bash
bash init.sh    # build and start everything
bash run.sh     # follow logs
bash stop.sh    # stop all services
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| HTTP Frontend | `http://localhost` | Main load-balanced entry |
| Stats Dashboard | `http://localhost:8404/stats` | Real-time HAProxy stats |
| API Backend | proxied | 3 API replicas (round-robin) |
| Web Backend | proxied | 2 Web replicas (least connections) |

## Architecture

```
                      ┌──────────┐
  Client ────────────►│ HAProxy  │
                      │ :80      │
                      └────┬─────┘
                           │
          ┌────────────────┼────────────────┐
          │ /api/*         │ /*             │
          ▼                ▼                │
   ┌─── api_servers ──┐  ┌── web_servers ──┐
   │ api-1  api-2     │  │ web-1  web-2   │
   │ api-3            │  │                │
   │ (round-robin)    │  │ (leastconn)    │
   └──────────────────┘  └────────────────┘
```

## Project Structure

```
haproxy/
  haproxy.cfg           # Main HAProxy configuration
services/
  api/Dockerfile        # Sample API backend
  web/Dockerfile        # Sample Web backend
docker-compose.yml
```

## Configuration Highlights

- **ACL-based routing**: Path-based routing (`/api/` → api_servers, `/` → web_servers)
- **Load balancing**: Round-robin for API, least-connections for Web
- **Health checks**: HTTP checks every 3s with 2-fail/2-rise thresholds
- **Stats dashboard**: Real-time metrics at `:8404/stats`
- **Connection limits**: Max 4096 connections per process
- **Timeouts**: Connect 5s, client 30s, server 30s
- **Logging**: Structured logging to stdout

## Stats Dashboard

Access `http://localhost:8404/stats` to see:
- Backend server status (UP/DOWN)
- Request rates and response times
- Connection counts
- Bytes in/out
- Error rates

## Requirements

- Docker
- Docker Compose
