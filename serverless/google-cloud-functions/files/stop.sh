#!/bin/bash
echo "Stopping local functions server..."
pkill -f "functions-framework" 2>/dev/null || true
echo "Local functions server stopped."
