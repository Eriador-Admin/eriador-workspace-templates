#!/bin/bash
echo "Stopping dev server..."
pkill -f "vite --port" 2>/dev/null || true
echo "Server stopped."
