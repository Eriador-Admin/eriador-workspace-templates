#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

echo "Starting Jenkins via Docker..."
docker compose up -d --build

echo ""
echo "Jenkins is starting at http://localhost:8080"
echo "Login: admin / admin"
echo "It may take a minute for Jenkins to fully initialize."
