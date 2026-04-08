#!/bin/bash
echo "Stopping Hugo dev server..."
pkill -f "hugo server" 2>/dev/null || true
echo "Server stopped."
