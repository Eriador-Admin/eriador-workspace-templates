#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Expo dev server runs on port 8081 by default
PORT="${EXPO_DEVTOOLS_PORT:-8081}"

PID=$(lsof -ti:"$PORT" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped Expo dev server on port $PORT (PID: $PID)"
else
  echo "No Expo dev server found on port $PORT"
fi
