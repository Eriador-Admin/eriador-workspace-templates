#!/bin/bash
echo "Stopping {{PROJECT_NAME}} watch mode..."
pkill -f "jest --watch" 2>/dev/null || true
echo "Stopped."
