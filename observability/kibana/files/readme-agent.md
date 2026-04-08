# Agent Instructions — {{PROJECT_NAME}}

This is a standalone Kibana + Elasticsearch setup for data visualization.

## Tech Stack
- **Visualization**: Kibana 8.x
- **Search Engine**: Elasticsearch 8.x
- **Infrastructure**: Docker Compose

## Key Conventions
- Kibana connects to Elasticsearch on the internal Docker network
- kibana.yml configures server host, ES hosts, and default settings
- Saved objects (index patterns, dashboards) exported as NDJSON
- Import saved objects via Kibana API or UI (Management → Saved Objects)
- Dev Tools console at `/app/dev_tools#/console` for ad-hoc ES queries
- Index patterns define which ES indices Kibana can visualize
- Kibana runs on port 5601, Elasticsearch on port 9200
- Security is disabled for local dev — enable xpack.security for production
