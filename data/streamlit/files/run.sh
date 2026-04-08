#!/bin/bash
set -e
source venv/bin/activate 2>/dev/null || true
echo "Starting {{PROJECT_NAME}}..."
streamlit run app.py --server.port {{DEV_PORT}}
