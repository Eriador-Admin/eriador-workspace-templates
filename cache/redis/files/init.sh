#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Redis..."
docker compose up -d
echo "Done! Redis running on port 6379."
