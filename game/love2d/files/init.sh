#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v love &>/dev/null; then
  echo "LOVE not found. Install it:"
  echo "  macOS:   brew install love"
  echo "  Linux:   sudo apt install love"
  echo "  Windows: https://love2d.org/"
  exit 1
fi

echo "LOVE version: $(love --version 2>&1 | head -1)"
echo "Done! Run 'bash run.sh' to start the game."
