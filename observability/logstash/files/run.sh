#!/bin/bash
echo "Sending test event to Logstash HTTP input..."
curl -s -X POST http://localhost:8080 \
  -H 'Content-Type: application/json' \
  -d '{"message": "test event from run.sh", "level": "info", "service": "test"}'
echo ""
echo "Event sent. Check Elasticsearch:"
echo "  curl http://localhost:9200/logstash-*/_search?pretty"
