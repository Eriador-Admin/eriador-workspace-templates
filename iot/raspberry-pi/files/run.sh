#!/bin/bash
set -e
source venv/bin/activate
echo "Running {{PROJECT_NAME}}..."
python src/main.py
