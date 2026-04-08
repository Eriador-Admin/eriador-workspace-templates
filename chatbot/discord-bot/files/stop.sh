#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "node src/index.js" 2>/dev/null || true
echo "Bot stopped."
