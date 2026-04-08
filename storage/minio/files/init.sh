#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting MinIO..."
docker compose up -d
echo "Waiting for MinIO..."
sleep 3
echo "Done!"
echo "  MinIO Console: http://localhost:9001 (minioadmin/minioadmin)"
