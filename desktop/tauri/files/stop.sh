#!/bin/bash
echo "Stopping {{APP_NAME}}..."
pkill -f "tauri dev" 2>/dev/null || true
pkill -f "vite --port" 2>/dev/null || true
echo "{{APP_NAME}} stopped."
