#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

command -v dotnet >/dev/null 2>&1 || { echo "Error: .NET SDK not found. Install from https://dotnet.microsoft.com/download"; exit 1; }

echo "Installing MonoGame templates..."
dotnet new install MonoGame.Templates.CSharp 2>/dev/null || true

echo "Restoring packages..."
dotnet restore

echo ""
echo "Done! Run 'bash run.sh' to start the game."
