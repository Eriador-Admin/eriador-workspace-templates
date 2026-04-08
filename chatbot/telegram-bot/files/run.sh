#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."

if [ -d "venv" ]; then
    source venv/bin/activate
fi

python3 main.py
