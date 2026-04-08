#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "remix vite:dev" 2>/dev/null || true
echo "Dev server stopped."
