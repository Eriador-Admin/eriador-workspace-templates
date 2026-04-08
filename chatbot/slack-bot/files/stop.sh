#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "node src/app.js" 2>/dev/null || true
echo "Bot stopped."
