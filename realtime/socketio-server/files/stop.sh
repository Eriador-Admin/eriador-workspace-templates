#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "node src/server.js" 2>/dev/null || true
echo "Server stopped."
