#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
docker compose up -d
echo "Waiting for Kibana to be ready..."
until curl -sf http://localhost:5601/api/status > /dev/null 2>&1; do
  sleep 3
done
echo "Seeding sample data..."
bash scripts/seed-data.sh
echo ""
echo "Kibana is ready at http://localhost:5601"
