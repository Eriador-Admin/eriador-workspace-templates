#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
docker compose down 2>/dev/null || true
echo "Stopped."
