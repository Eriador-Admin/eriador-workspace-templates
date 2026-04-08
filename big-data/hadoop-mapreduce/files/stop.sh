#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PID=$(pgrep -f "WordCountDriver" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped MapReduce process (PID: $PID)"
else
  echo "No running MapReduce process found"
fi
