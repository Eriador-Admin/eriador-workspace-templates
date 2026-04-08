#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."
cd backend && npm run dev &
BACKEND_PID=$!
cd frontend && npm run dev &
FRONTEND_PID=$!
trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null" EXIT
wait
