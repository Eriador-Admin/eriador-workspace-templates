#!/bin/bash
echo "Stopping Nx processes..."
pkill -f "nx serve" 2>/dev/null || true
echo "Stopped."
