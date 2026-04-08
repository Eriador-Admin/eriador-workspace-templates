# Agent Instructions — {{PROJECT_NAME}}

This is an ELK Stack (Elasticsearch, Logstash, Kibana) observability project.

## Tech Stack
- **Log Storage/Search**: Elasticsearch
- **Log Ingestion**: Logstash
- **Visualization**: Kibana
- **App Logger**: Winston with Logstash transport
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Logger in `src/logger.ts` ships JSON logs to Logstash
- Logstash pipeline config in `logstash/pipeline/logstash.conf`
- ELK runs via Docker Compose
- Kibana at port 5601, Elasticsearch at 9200
