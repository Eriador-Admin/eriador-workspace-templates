#!/bin/bash
set -e
echo "Building {{PROJECT_NAME}}..."

if [ -f "package.json" ]; then
  npm ci
  npm run build 2>/dev/null || echo "No build script found, skipping..."
fi

echo "Build complete."
