#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."

if [ -f .app.pid ]; then
  kill "$(cat .app.pid)" 2>/dev/null || true
  rm .app.pid
fi

solana-test-validator --kill 2>/dev/null || true
echo "Stopped."
