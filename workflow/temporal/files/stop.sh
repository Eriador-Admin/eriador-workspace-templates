#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "tsx.*src/worker" 2>/dev/null || true
pkill -f "tsx.*src/api" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
