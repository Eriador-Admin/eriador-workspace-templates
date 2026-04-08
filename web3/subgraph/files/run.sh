#!/bin/bash
set -e

echo "Creating subgraph on local node..."
npx graph create --node http://localhost:8020/ {{PROJECT_NAME}} 2>/dev/null || true

echo "Deploying subgraph..."
npx graph deploy --node http://localhost:8020/ --ipfs http://localhost:5001 --version-label v0.0.1 {{PROJECT_NAME}}

echo ""
echo "Subgraph deployed!"
echo "Query at: http://localhost:8000/subgraphs/name/{{PROJECT_NAME}}"
