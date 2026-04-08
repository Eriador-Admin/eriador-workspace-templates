#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
docker compose up -d
echo "Waiting for Logstash to be ready..."
sleep 15
echo ""
echo "Logstash is ready."
echo "  HTTP input: http://localhost:8080"
echo "  Beats input: localhost:5044"
echo "  Syslog input: localhost:5140 (UDP)"
echo "  Elasticsearch: http://localhost:9200"
