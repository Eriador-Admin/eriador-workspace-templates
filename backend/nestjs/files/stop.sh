#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-3000}"

echo "==> Stopping NestJS server on port $PORT..."
PID=$(lsof -ti :"$PORT" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID"
  echo "==> Server stopped (PID $PID)."
else
  echo "==> No server running on port $PORT."
fi
