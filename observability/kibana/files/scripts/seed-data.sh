#!/bin/bash
set -e
echo "Seeding sample data into Elasticsearch..."

ES_URL="${ELASTICSEARCH_URL:-http://localhost:9200}"

# Wait for ES
until curl -sf "$ES_URL/_cluster/health" > /dev/null 2>&1; do
  echo "Waiting for Elasticsearch..."
  sleep 2
done

# Create sample index and seed documents
curl -sf -X PUT "$ES_URL/logs-sample" -H 'Content-Type: application/json' -d '{
  "mappings": {
    "properties": {
      "@timestamp": { "type": "date" },
      "level": { "type": "keyword" },
      "message": { "type": "text" },
      "service": { "type": "keyword" }
    }
  }
}' > /dev/null

# Bulk insert sample logs
curl -sf -X POST "$ES_URL/logs-sample/_bulk" -H 'Content-Type: application/x-ndjson' -d '
{"index":{}}
{"@timestamp":"2025-01-01T10:00:00Z","level":"info","message":"Application started","service":"api"}
{"index":{}}
{"@timestamp":"2025-01-01T10:01:00Z","level":"warn","message":"High memory usage detected","service":"api"}
{"index":{}}
{"@timestamp":"2025-01-01T10:02:00Z","level":"error","message":"Database connection timeout","service":"db"}
{"index":{}}
{"@timestamp":"2025-01-01T10:03:00Z","level":"info","message":"Request processed in 120ms","service":"api"}
{"index":{}}
{"@timestamp":"2025-01-01T10:04:00Z","level":"info","message":"Cache hit ratio: 94%","service":"cache"}
' > /dev/null

echo "Sample data seeded. Open Kibana at http://localhost:5601"
