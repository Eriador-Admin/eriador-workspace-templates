#!/bin/bash
echo "Stopping gRPC server..."
pkill -f "node src/server.js" 2>/dev/null || true
echo "gRPC server stopped."
