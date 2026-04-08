#!/bin/bash
set -e
echo "Starting Temporal worker..."
npm run dev:worker &
sleep 2
echo "Starting {{PROJECT_NAME}} API..."
npm run dev:api
