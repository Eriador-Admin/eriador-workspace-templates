#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "vite" 2>/dev/null || true
echo "Stopped."
