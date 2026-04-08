#!/bin/bash
echo "Stopping SAM local API..."
pkill -f "sam local" 2>/dev/null || true
echo "SAM local API stopped."
