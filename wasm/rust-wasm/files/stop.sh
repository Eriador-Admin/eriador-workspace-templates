#!/bin/bash
echo "Stopping demo server..."
pkill -f "http.server {{DEV_PORT}}" 2>/dev/null || true
echo "Stopped."
