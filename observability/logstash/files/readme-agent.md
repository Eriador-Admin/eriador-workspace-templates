# Agent Instructions — {{PROJECT_NAME}}

This is a standalone Logstash data processing pipeline setup.

## Tech Stack
- **Pipeline Engine**: Logstash 8.x
- **Output**: Elasticsearch 8.x
- **Infrastructure**: Docker Compose

## Key Conventions
- Pipeline configs live in `logstash/pipeline/` as `.conf` files
- Each pipeline follows the input → filter → output pattern
- `pipelines.yml` defines which pipeline configs to load (multiple pipeline support)
- `logstash.yml` sets global Logstash settings (node name, monitoring)
- Grok patterns parse unstructured text into structured fields
- Mutate filter renames, converts, or removes fields
- Date filter parses timestamps into `@timestamp`
- Output to Elasticsearch auto-creates daily indices: `logstash-YYYY.MM.dd`
- Security is disabled for local dev — enable xpack.security for production
- Use `stdout { codec => rubydebug }` for debugging pipeline output
