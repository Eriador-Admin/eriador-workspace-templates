#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "node --require ./src/tracing.js" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
