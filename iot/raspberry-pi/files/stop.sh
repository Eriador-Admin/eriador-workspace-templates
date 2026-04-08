#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "python src/main.py" 2>/dev/null || true
echo "Stopped."
