#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Meilisearch..."
docker compose up -d
echo "Waiting for Meilisearch..."
until curl -s http://localhost:7700/health > /dev/null 2>&1; do
  sleep 1
done
echo "Seeding sample data..."
npm run seed
echo "Done! Meilisearch: http://localhost:7700"
