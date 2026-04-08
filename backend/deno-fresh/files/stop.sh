#!/bin/bash
echo "Stopping Fresh dev server..."
pkill -f "deno.*dev.ts" 2>/dev/null || true
echo "Stopped."
