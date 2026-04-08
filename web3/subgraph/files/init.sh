#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

npm install

echo "Starting Graph Node (docker compose)..."
docker compose up -d

echo "Waiting for Graph Node to be ready..."
sleep 10

echo "Generating types..."
npx graph codegen

echo "Building subgraph..."
npx graph build

echo ""
echo "Done! Run 'bash run.sh' to deploy the subgraph."
echo "GraphQL playground: http://localhost:8000"
