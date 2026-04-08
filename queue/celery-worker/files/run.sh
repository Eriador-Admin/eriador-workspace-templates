#!/bin/bash
set -e
source venv/bin/activate 2>/dev/null || true
echo "Starting {{PROJECT_NAME}}..."

celery -A app.celery_app worker --loglevel=info &
WORKER_PID=$!

celery -A app.celery_app flower --port={{DEV_PORT}} &
FLOWER_PID=$!

echo "Worker running. Flower: http://localhost:{{DEV_PORT}}"
wait $WORKER_PID $FLOWER_PID
