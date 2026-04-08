#!/bin/bash
set -e
echo "Building {{PROJECT_NAME}} Docker images..."
docker compose build
echo "Done!"
