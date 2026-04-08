#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Temporal server..."
docker compose up -d
echo "Waiting for Temporal..."
sleep 5
echo "Done!"
echo "  Temporal UI: http://localhost:8233"
