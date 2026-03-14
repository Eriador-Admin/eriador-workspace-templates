#!/usr/bin/env bash
PORT="${DEV_PORT:-4200}"
PID=$(lsof -ti:"$PORT" 2>/dev/null)
if [ -n "$PID" ]; then
  kill "$PID" && echo "Stopped Angular dev server (port $PORT)"
else
  echo "No process on port $PORT"
fi
