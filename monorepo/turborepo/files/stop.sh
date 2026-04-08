#!/bin/bash
echo "Stopping all dev servers..."
pkill -f "turbo run dev" 2>/dev/null || true
echo "Servers stopped."
