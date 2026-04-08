#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "tsx.*server" 2>/dev/null || true
pkill -f "vite" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
