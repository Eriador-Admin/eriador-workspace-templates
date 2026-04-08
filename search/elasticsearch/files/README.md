# {{PROJECT_NAME}}

A full-text search service built with [Elasticsearch](https://www.elastic.co/elasticsearch/) — the industry-standard distributed search and analytics engine.

## Getting Started

```bash
bash init.sh    # start Elasticsearch via Docker, install deps
bash run.sh     # start API on port 3000
bash stop.sh    # stop API and Elasticsearch
```

## Prerequisites

- Node.js 18+
- Docker & Docker Compose

## Project Structure

```
docker-compose.yml              # Elasticsearch container
src/
  server.ts                     # Express server
  routes/
    search.ts                   # Search endpoints
    documents.ts                # CRUD for documents
    indices.ts                  # Index management
  services/
    elastic.ts                  # Elasticsearch client singleton
    index-service.ts            # Index create/delete/mapping
    document-service.ts         # Document index/get/delete
    search-service.ts           # Search/aggregate queries
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| POST | /api/indices | Create an index with mappings |
| DELETE | /api/indices/:name | Delete an index |
| POST | /api/documents/:index | Index a document |
| GET | /api/documents/:index/:id | Get document by ID |
| DELETE | /api/documents/:index/:id | Delete document |
| POST | /api/documents/:index/_bulk | Bulk index documents |
| GET | /api/search/:index | Full-text search with query params |
| POST | /api/search/:index | Advanced search with DSL body |
| GET | /api/health | Health check |
