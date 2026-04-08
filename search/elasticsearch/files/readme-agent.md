# Agent Instructions — {{PROJECT_NAME}}

This is a search service using Elasticsearch with Express/TypeScript.

## Tech Stack
- **Language**: TypeScript
- **Server**: Express
- **Search**: Elasticsearch 8.x
- **Client**: @elastic/elasticsearch

## Key Conventions
- Elasticsearch client singleton in `src/services/elastic.ts`
- Index management: create with explicit mappings, avoid dynamic mapping in production
- Use `text` type for full-text search fields, `keyword` for exact match / aggregations
- Search with `match` (full-text), `term` (exact), `bool` (compound queries)
- Aggregations: `terms`, `avg`, `sum`, `date_histogram` for analytics
- Bulk API for indexing many documents at once — much faster than individual calls
- Document IDs: let ES auto-generate or provide your own
- Use `_source` filtering to return only needed fields
- Pagination: `from` + `size` params (default max 10,000 deep)
- Docker Compose runs single-node ES with security disabled for dev
