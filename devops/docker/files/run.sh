#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."
docker compose up -d
echo "Running at http://localhost:3000"
