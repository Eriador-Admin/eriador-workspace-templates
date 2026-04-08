# {{PROJECT_NAME}}

Application metrics with [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/).

## Getting Started

```bash
bash init.sh    # install deps + start Prometheus & Grafana
bash run.sh     # start the Node.js app
bash stop.sh    # stop everything
```

## Endpoints

| URL | Description |
|-----|-------------|
| `http://localhost:3000` | App homepage |
| `http://localhost:3000/metrics` | Prometheus metrics |
| `http://localhost:9090` | Prometheus UI |
| `http://localhost:3001` | Grafana (admin/admin) |

## Project Structure

```
src/
  app.ts            # Express app with metrics middleware
  metrics.ts        # Custom Prometheus metrics
prometheus/
  prometheus.yml    # Prometheus scrape config
docker-compose.yml  # Prometheus + Grafana
```

## Custom Metrics

- `http_requests_total` — Counter of HTTP requests by method, path, status
- `http_request_duration_seconds` — Histogram of request durations
- Default Node.js metrics (GC, event loop, memory)

## Requirements

- Node.js 18+
- Docker (for Prometheus and Grafana)
