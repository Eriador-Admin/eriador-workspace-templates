# {{PROJECT_NAME}}

A standalone [Grafana](https://grafana.com/) setup for building dashboards and visualizing metrics from any datasource.

## Getting Started

```bash
bash init.sh    # start Grafana via Docker
bash run.sh     # open Grafana UI
bash stop.sh    # stop all containers
```

## Prerequisites

- Docker & Docker Compose

## Project Structure

```
docker-compose.yml                # Grafana container
grafana/
  grafana.ini                     # Grafana server configuration
  provisioning/
    datasources/
      datasources.yml             # Auto-provisioned datasources
    dashboards/
      dashboards.yml              # Dashboard provisioning config
      sample-dashboard.json       # Pre-built sample dashboard
```

## Access

| Service | URL | Credentials |
|---------|-----|-------------|
| Grafana | http://localhost:3000 | admin / admin |

## Features

- **Auto-provisioned datasources** — datasources configured on startup via YAML
- **Auto-provisioned dashboards** — JSON dashboard files loaded automatically
- **Persistent storage** — Grafana data persisted in Docker volume
- **Extensible** — add datasources (Prometheus, Elasticsearch, PostgreSQL, etc.) by editing provisioning files
- Sample dashboard included out-of-the-box

## Adding a Datasource

Add a new entry to `grafana/provisioning/datasources/datasources.yml`:

```yaml
- name: My Prometheus
  type: prometheus
  url: http://prometheus:9090
  access: proxy
  isDefault: false
```

## Adding a Dashboard

1. Create your dashboard in Grafana UI
2. Export as JSON (Share → Export → Save to file)
3. Place the JSON file in `grafana/provisioning/dashboards/`
4. The dashboard will auto-load on next Grafana restart
