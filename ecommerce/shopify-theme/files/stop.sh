#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "shopify theme dev" 2>/dev/null || true
echo "Dev server stopped."
