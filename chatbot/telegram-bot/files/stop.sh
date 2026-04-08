#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "python3 main.py" 2>/dev/null || true
echo "Stopped."
