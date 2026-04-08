#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

# Check for Unity Hub
if ! command -v unity-hub &>/dev/null && ! [ -d "/Applications/Unity Hub.app" ] && ! [ -d "$HOME/Applications/Unity Hub.app" ]; then
  echo "Warning: Unity Hub not found. Install from https://unity.com/download"
  echo "You can still open this project manually from Unity Hub."
fi

echo ""
echo "To open this project:"
echo "  1. Open Unity Hub"
echo "  2. Click 'Add' and select this project folder"
echo "  3. Unity will import assets and generate Library/"
echo ""
echo "Or from command line (macOS):"
echo '  /Applications/Unity/Hub/Editor/2022.3.*/Unity.app/Contents/MacOS/Unity -projectPath "$(pwd)"'
echo ""
echo "Done!"
