#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting ELK stack (this may take a minute)..."
docker compose up -d
echo "Waiting for Elasticsearch to be ready..."
until curl -s http://localhost:9200/_cluster/health > /dev/null 2>&1; do
  sleep 2
done
echo "Done! Kibana: http://localhost:5601 | Elasticsearch: http://localhost:9200"
