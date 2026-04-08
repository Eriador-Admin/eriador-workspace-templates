#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."

echo "Running tests (starts local validator automatically)..."
anchor test

echo ""
echo "Starting frontend..."
cd app && npm run dev &
APP_PID=$!
echo "Frontend running at http://localhost:3000 (PID: $APP_PID)"
echo $APP_PID > ../.app.pid
