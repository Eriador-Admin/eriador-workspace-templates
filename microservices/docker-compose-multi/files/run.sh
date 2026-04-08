#!/bin/bash
set -e
echo "Starting all services..."
docker compose up -d
echo "Gateway available at http://localhost:{{GATEWAY_PORT}}"
echo "  - Users:    http://localhost:{{GATEWAY_PORT}}/api/users"
echo "  - Products: http://localhost:{{GATEWAY_PORT}}/api/products"
echo "  - Health:   http://localhost:{{GATEWAY_PORT}}/health"
