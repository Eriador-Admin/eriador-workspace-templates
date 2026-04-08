#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "next dev" 2>/dev/null || true
echo "Stopped."
