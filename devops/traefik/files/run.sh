#!/bin/bash
set -e
echo "Services are running (started via init.sh)."
echo "  Dashboard: http://localhost:${TRAEFIK_DASHBOARD_PORT:-8080}"
echo "  API:       http://api.localhost"
echo "  Web:       http://web.localhost"
echo ""
echo "Follow logs:"
docker compose logs -f
