#!/bin/bash
echo "Stopping MkDocs dev server..."
pkill -f "mkdocs serve" 2>/dev/null || true
echo "Server stopped."
