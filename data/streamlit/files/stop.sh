#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "streamlit run" 2>/dev/null || true
echo "App stopped."
