#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Starting Jaeger..."
docker compose up -d
echo "Done! Jaeger UI: http://localhost:16686"
