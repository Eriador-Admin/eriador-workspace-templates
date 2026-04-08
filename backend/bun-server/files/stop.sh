#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "bun.*server.ts" 2>/dev/null || true
echo "Stopped."
