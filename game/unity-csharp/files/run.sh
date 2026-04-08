#!/bin/bash
set -e
echo "Building {{PROJECT_NAME}}..."

# Find Unity editor
UNITY_PATH=""
if [ -d "/Applications/Unity/Hub/Editor" ]; then
  UNITY_PATH=$(ls -d /Applications/Unity/Hub/Editor/2022.3.*/Unity.app/Contents/MacOS/Unity 2>/dev/null | tail -1)
fi

if [ -z "$UNITY_PATH" ]; then
  echo "Error: Unity Editor not found. Open the project via Unity Hub instead."
  exit 1
fi

echo "Using Unity at: $UNITY_PATH"
"$UNITY_PATH" -quit -batchmode -projectPath "$(pwd)" -buildTarget StandaloneOSX \
  -executeMethod UnityEditor.BuildPlayerWindow.ShowBuildPlayerWindow || true

echo "Build complete! Check Build/ directory."
