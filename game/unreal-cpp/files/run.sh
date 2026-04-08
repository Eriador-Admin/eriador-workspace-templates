#!/bin/bash
set -e
echo "Opening {{PROJECT_NAME}} in Unreal Editor..."

UPROJECT="$(pwd)/{{PROJECT_NAME}}.uproject"

if [ ! -f "$UPROJECT" ]; then
  echo "Error: {{PROJECT_NAME}}.uproject not found. Run init.sh first."
  exit 1
fi

# Attempt to open via command line
if [ -d "/Users/Shared/Epic Games/UE_5.3" ]; then
  open -a "/Users/Shared/Epic Games/UE_5.3/Engine/Binaries/Mac/UnrealEditor.app" "$UPROJECT"
else
  echo "Unreal Editor not found at expected path."
  echo "Open $UPROJECT from Epic Games Launcher instead."
  open "$UPROJECT" 2>/dev/null || true
fi
