#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PORT="${JUPYTER_PORT:-8888}"
if [ -f .env ]; then
  PORT=$(grep -E '^JUPYTER_PORT=' .env | cut -d= -f2 || echo "$PORT")
fi

PID=$(lsof -ti:"$PORT" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped Jupyter on port $PORT (PID: $PID)"
else
  echo "No Jupyter process found on port $PORT"
fi
