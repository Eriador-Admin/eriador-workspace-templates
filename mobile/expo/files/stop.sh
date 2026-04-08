#!/bin/bash
echo "Stopping Expo dev server..."
pkill -f "expo start" 2>/dev/null || true
echo "Expo dev server stopped."
