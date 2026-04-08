#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting Neo4j..."
docker compose up -d
echo "Waiting for Neo4j..."
sleep 10
echo "Seeding graph data..."
npm run seed
echo "Done!"
echo "  Neo4j Browser: http://localhost:7474"
