#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PID=$(pgrep -f "pyflink" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped Flink process (PID: $PID)"
else
  echo "No running Flink process found"
fi
