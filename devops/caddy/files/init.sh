#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
docker compose up -d --build
echo ""
echo "Done!"
echo "  HTTP:    http://localhost"
echo "  API:     http://localhost/api/"
echo "  Admin:   http://localhost:${CADDY_ADMIN_PORT:-2019}/config/"
