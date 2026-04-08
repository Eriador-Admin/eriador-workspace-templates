#!/bin/bash
set -e
echo "Starting WordPress on port {{DEV_PORT}}..."
docker compose up -d
echo "WordPress available at http://localhost:{{DEV_PORT}}"
