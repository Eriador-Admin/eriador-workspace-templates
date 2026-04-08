#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "tsx.*src/app" 2>/dev/null || true
pkill -f "firebase.*emulators" 2>/dev/null || true
echo "Stopped."
