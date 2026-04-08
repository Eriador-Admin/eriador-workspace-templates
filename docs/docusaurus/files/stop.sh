#!/bin/bash
echo "Stopping Docusaurus dev server..."
pkill -f "docusaurus start" 2>/dev/null || true
echo "Server stopped."
