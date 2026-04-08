#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} (Traefik + services)..."
docker compose up -d --build
echo "Done!"
echo "  Dashboard: http://localhost:${TRAEFIK_DASHBOARD_PORT:-8080}"
echo "  API:       http://api.localhost"
echo "  Web:       http://web.localhost"
