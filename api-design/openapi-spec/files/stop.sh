#!/bin/bash
echo "Stopping Swagger UI server..."
pkill -f "node serve.js" 2>/dev/null || true
echo "Stopped."
