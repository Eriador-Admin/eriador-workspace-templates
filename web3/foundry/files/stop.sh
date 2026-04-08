#!/bin/bash
echo "Stopping Anvil..."
pkill -f anvil 2>/dev/null || true
echo "Stopped."
