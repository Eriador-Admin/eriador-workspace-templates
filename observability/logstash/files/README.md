# {{PROJECT_NAME}}

A standalone [Logstash](https://www.elastic.co/logstash) setup for data ingestion, transformation, and routing.

## Getting Started

```bash
bash init.sh    # start Logstash + Elasticsearch via Docker
bash run.sh     # send test events
bash stop.sh    # stop all containers
```

## Prerequisites

- Docker & Docker Compose

## Project Structure

```
docker-compose.yml              # Logstash + Elasticsearch containers
logstash/
  logstash.yml                  # Logstash settings
  pipelines.yml                 # Pipeline definitions (multiple pipelines)
  pipeline/
    main.conf                   # Main pipeline — stdin/beats to ES
    syslog.conf                 # Syslog pipeline — UDP 5140 to ES
```

## Ports

| Service | Port | Protocol |
|---------|------|----------|
| Logstash Beats input | 5044 | TCP |
| Logstash syslog input | 5140 | UDP |
| Logstash HTTP input | 8080 | HTTP |
| Elasticsearch | 9200 | HTTP |

## How It Works

1. **Input** — Logstash accepts data from Beats (port 5044), syslog (port 5140), or HTTP (port 8080)
2. **Filter** — Parses, transforms, enriches events (grok, mutate, date, geoip)
3. **Output** — Routes processed events to Elasticsearch

## Pipelines

- **main** — General-purpose pipeline accepting Beats and HTTP input
- **syslog** — Dedicated syslog listener with RFC5424 parsing

## Testing

Send a test event via HTTP input:
```bash
curl -X POST http://localhost:8080 -H 'Content-Type: application/json' -d '{"message": "test event", "level": "info"}'
```

Verify in Elasticsearch:
```bash
curl http://localhost:9200/logstash-*/_search?pretty
```
