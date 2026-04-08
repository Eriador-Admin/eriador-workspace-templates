#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

echo "Starting Elasticsearch via Docker..."
docker compose up -d

echo "Waiting for Elasticsearch to be ready..."
until curl -s http://localhost:9200 > /dev/null 2>&1; do
  sleep 2
done
echo "Elasticsearch is ready!"

npm install
echo ""
echo "Setup complete! Run 'bash run.sh' to start the API."
