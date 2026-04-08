#!/bin/bash
echo "Stopping OpenAI API server..."
pkill -f "uvicorn src.server:app" 2>/dev/null || true
echo "Server stopped."
