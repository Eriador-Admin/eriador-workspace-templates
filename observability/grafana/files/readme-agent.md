# Agent Instructions — {{PROJECT_NAME}}

This is a standalone Grafana dashboard setup.

## Tech Stack
- **Dashboard Platform**: Grafana 10.x
- **Infrastructure**: Docker Compose

## Key Conventions
- Grafana runs on port 3000, default login admin/admin
- Datasources auto-provisioned from `grafana/provisioning/datasources/datasources.yml`
- Dashboards auto-provisioned from JSON files in `grafana/provisioning/dashboards/`
- `grafana.ini` controls server settings (auth, SMTP, paths)
- Grafana data persisted in Docker volume `grafana-data`
- To add a new datasource: add entry to datasources.yml, restart container
- To add a new dashboard: export JSON from Grafana UI, place in dashboards folder
- For production, change default admin password and enable proper auth
- Supported datasources: Prometheus, Elasticsearch, PostgreSQL, MySQL, InfluxDB, Loki, and others
