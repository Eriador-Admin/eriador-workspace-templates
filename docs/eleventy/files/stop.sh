#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "eleventy --serve" 2>/dev/null || true
echo "Stopped."
