#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."
source venv/bin/activate 2>/dev/null || true
python3 main.py
