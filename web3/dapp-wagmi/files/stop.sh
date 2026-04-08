#!/bin/bash
echo "Stopping dev server..."
pkill -f "vite" 2>/dev/null || true
echo "Stopped."
