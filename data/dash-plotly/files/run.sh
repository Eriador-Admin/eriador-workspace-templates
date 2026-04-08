#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} on port 8050..."

if [ -d "venv" ]; then
    source venv/bin/activate
fi

python3 app.py
