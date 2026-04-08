# Agent Instructions — {{PROJECT_NAME}}

This is a Prometheus observability project with Node.js metrics.

## Tech Stack
- **Metrics**: Prometheus via prom-client
- **Visualization**: Grafana
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Metrics definitions in `src/metrics.ts`
- `/metrics` endpoint for Prometheus scraping
- Prometheus config in `prometheus/prometheus.yml`
- Grafana at port 3001, Prometheus at port 9090
