# Agent Instructions — {{PROJECT_NAME}}

This is a Grafana + Prometheus observability stack.

## Tech Stack
- **Dashboards**: Grafana (port 3001)
- **Metrics**: Prometheus (port 9090)
- **App**: Express + prom-client (port 3000)

## Key Conventions
- Entry point: `src/app.ts`
- Custom metrics in `src/metrics.ts`
- Prometheus scrapes /metrics endpoint every 5s
- Grafana auto-provisions datasource + dashboard on startup
- Default Grafana login: admin/admin
