#!/bin/bash
echo "Stopping Gatsby dev server..."
pkill -f "gatsby develop" 2>/dev/null || true
echo "Stopped."
