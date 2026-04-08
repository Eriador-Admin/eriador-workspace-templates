#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PID=$(pgrep -f "StreamProcessor" 2>/dev/null || true)
if [ -n "$PID" ]; then
  kill "$PID" 2>/dev/null
  echo "Stopped Kafka Streams process (PID: $PID)"
else
  echo "No running Kafka Streams process found"
fi
