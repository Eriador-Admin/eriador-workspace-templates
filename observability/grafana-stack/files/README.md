# {{PROJECT_NAME}}

Full observability stack: [Grafana](https://grafana.com/) dashboards + [Prometheus](https://prometheus.io/) metrics collection with a sample Node.js app.

## Getting Started

```bash
bash init.sh    # install deps + start Grafana/Prometheus
bash run.sh     # start the app
bash stop.sh    # stop everything
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| App | `http://localhost:3000` | Sample Express app with metrics |
| Prometheus | `http://localhost:9090` | Metrics collection + queries |
| Grafana | `http://localhost:3001` | Dashboards (admin/admin) |

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/` | Hello endpoint (increments counter) |
| GET | `/slow` | Simulated slow endpoint |
| GET | `/metrics` | Prometheus metrics endpoint |
| GET | `/health` | Health check |

## Project Structure

```
src/
  app.ts                # Express app with prom-client
  metrics.ts            # Custom Prometheus metrics
prometheus/
  prometheus.yml        # Scrape config
grafana/
  datasources.yml       # Auto-provision Prometheus datasource
  dashboards.yml        # Dashboard provisioning config
  dashboards/app.json   # Pre-built app dashboard
docker-compose.yml      # Grafana + Prometheus
```

## Requirements

- Node.js 18+
- Docker
