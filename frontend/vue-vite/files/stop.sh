#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PORT="${VITE_DEV_PORT:-5173}"
if [ -f .env ]; then
  PORT=$(grep -E '^VITE_DEV_PORT=' .env | cut -d= -f2 || echo "$PORT")
fi

PID=$(lsof -ti:"$PORT" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped process on port $PORT (PID: $PID)"
else
  echo "No process found on port $PORT"
fi
