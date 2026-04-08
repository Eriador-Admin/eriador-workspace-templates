# {{PROJECT_NAME}}

A standalone [Kibana](https://www.elastic.co/kibana) setup for data visualization, dashboards, and Elasticsearch exploration.

## Getting Started

```bash
bash init.sh    # start Elasticsearch + Kibana via Docker
bash run.sh     # open Kibana UI
bash stop.sh    # stop all containers
```

## Prerequisites

- Docker & Docker Compose

## Project Structure

```
docker-compose.yml              # Elasticsearch + Kibana containers
kibana/
  kibana.yml                    # Kibana configuration
  saved-objects/
    index-patterns.ndjson       # Pre-built index patterns
scripts/
  seed-data.sh                  # Seed sample data into Elasticsearch
```

## Access

| Service | URL |
|---------|-----|
| Kibana | http://localhost:5601 |
| Elasticsearch | http://localhost:9200 |

## Features

- **Discover** — explore and filter log/event data
- **Visualize** — build charts, tables, metrics from ES data
- **Dashboard** — combine visualizations into dashboards
- **Dev Tools** — run ES queries directly from Kibana console
- Pre-configured index patterns for quick start
- Sample data seeding script
