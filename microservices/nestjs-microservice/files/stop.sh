#!/bin/bash
echo "Stopping {{SERVICE_NAME}}..."
pkill -f "nest start" 2>/dev/null || true
echo "{{SERVICE_NAME}} stopped."
