#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "{{PROJECT_NAME}}" 2>/dev/null || true
echo "Stopped."
