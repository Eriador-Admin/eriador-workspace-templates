#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

# Rename .uproject to match project name
if [ -f project.uproject ] && [ ! -f "{{PROJECT_NAME}}.uproject" ]; then
  mv project.uproject "{{PROJECT_NAME}}.uproject"
fi

echo ""
echo "To open this project:"
echo "  1. Open Epic Games Launcher"
echo "  2. Go to Unreal Engine > Library"
echo "  3. Click 'Browse' and select {{PROJECT_NAME}}.uproject"
echo ""
echo "To generate project files (macOS):"
echo '  /Users/Shared/Epic\ Games/UE_5.3/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.sh "$(pwd)/{{PROJECT_NAME}}.uproject" -game'
echo ""
echo "Done!"
