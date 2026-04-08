#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Grafana + Prometheus..."
docker compose up -d
echo "Done!"
echo "  Grafana: http://localhost:${GRAFANA_PORT:-3001} (admin/admin)"
echo "  Prometheus: http://localhost:9090"
