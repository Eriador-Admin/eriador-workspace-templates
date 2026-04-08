#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Keycloak (may take 30-60s to initialize)..."
docker compose up -d
echo "Waiting for Keycloak..."
until curl -sf http://localhost:8080/realms/master > /dev/null 2>&1; do
  sleep 3
done
echo "Done! Keycloak: http://localhost:8080 (admin/admin)"
echo "Test user: testuser / password"
