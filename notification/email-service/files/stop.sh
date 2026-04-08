#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "tsx.*src/app" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
