#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PID=$(pgrep -f "spark.*{{APP_NAME}}" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped Spark process (PID: $PID)"
else
  echo "No running Spark process found"
fi
