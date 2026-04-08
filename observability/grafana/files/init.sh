#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
cp -n .env.example .env 2>/dev/null || true
docker compose up -d
echo "Waiting for Grafana to be ready..."
until curl -sf http://localhost:3000/api/health > /dev/null 2>&1; do
  sleep 2
done
echo ""
echo "Grafana is ready at http://localhost:3000"
echo "Login: admin / admin"
