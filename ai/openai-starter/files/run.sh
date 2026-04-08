#!/bin/bash
set -e
source venv/bin/activate
echo "Starting OpenAI API server on port {{DEV_PORT}}..."
uvicorn src.server:app --host 0.0.0.0 --port {{DEV_PORT}} --reload
