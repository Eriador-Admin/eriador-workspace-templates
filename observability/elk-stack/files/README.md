# {{PROJECT_NAME}}

Log aggregation and search with the [ELK Stack](https://www.elastic.co/elastic-stack) (Elasticsearch, Logstash, Kibana).

## Getting Started

```bash
bash init.sh    # install deps + start ELK containers
bash run.sh     # start the Node.js app
bash stop.sh    # stop everything
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| App | `http://localhost:3000` | Express app that ships logs |
| Kibana | `http://localhost:5601` | Log visualization dashboard |
| Elasticsearch | `http://localhost:9200` | Search & analytics engine |
| Logstash | `localhost:5044` | Log ingestion pipeline |

## Project Structure

```
src/
  app.ts            # Express app with structured logging
  logger.ts         # Winston logger → Logstash transport
logstash/
  pipeline/
    logstash.conf   # Logstash pipeline config
docker-compose.yml  # Elasticsearch + Logstash + Kibana
```

## Requirements

- Node.js 18+
- Docker with 4GB+ RAM (Elasticsearch needs memory)
