#!/bin/bash
set -e
echo "Checking for Godot..."
if command -v godot &> /dev/null; then
  echo "Godot found: $(godot --version 2>/dev/null || echo 'version check requires GUI')"
else
  echo "Godot not found in PATH. Install from https://godotengine.org/download"
  echo "Or open the project.godot file directly from the Godot editor."
fi
echo "Done!"
