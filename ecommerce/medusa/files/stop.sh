#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "medusa develop" 2>/dev/null || true
echo "Stopped."
