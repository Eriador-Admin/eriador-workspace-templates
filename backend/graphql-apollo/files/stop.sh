#!/bin/bash
echo "Stopping GraphQL server..."
pkill -f "tsx watch" 2>/dev/null || true
echo "GraphQL server stopped."
