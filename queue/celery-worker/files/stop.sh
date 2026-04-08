#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "celery -A app.celery_app" 2>/dev/null || true
docker compose down 2>/dev/null || true
echo "Stopped."
