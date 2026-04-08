#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "node.*server.js" 2>/dev/null || true
echo "Stopped."
