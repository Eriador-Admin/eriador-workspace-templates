#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Prometheus and Grafana..."
docker compose up -d
echo "Done! Prometheus: http://localhost:9090 | Grafana: http://localhost:3001 (admin/admin)"
