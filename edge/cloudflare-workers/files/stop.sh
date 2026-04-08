#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "wrangler.*dev" 2>/dev/null || true
echo "Stopped."
