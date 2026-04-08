#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "tsx.*server.ts" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
