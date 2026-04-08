#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."

# Try to open with Defold editor
if [ -d "/Applications/Defold.app" ]; then
  open -a Defold "$(pwd)/game.project"
else
  echo "Defold editor not found at /Applications/Defold.app"
  echo "Open game.project from the Defold editor manually."
fi
