#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
docker compose up -d --build
echo ""
echo "Done!"
echo "  HTTP:   http://localhost"
echo "  API:    http://localhost/api/"
echo "  Stats:  http://localhost:${HAPROXY_STATS_PORT:-8404}/stats"
