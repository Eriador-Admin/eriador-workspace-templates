#!/bin/bash
set -e
echo "Opening project in Godot editor..."
if command -v godot &> /dev/null; then
  godot --editor project.godot &
else
  echo "Godot not found. Open project.godot from the Godot editor manually."
fi
