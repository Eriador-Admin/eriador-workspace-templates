#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

command -v java >/dev/null 2>&1 || { echo "Error: Java not found. Install JDK 17+."; exit 1; }

echo "Building with Gradle..."
./gradlew build 2>/dev/null || chmod +x gradlew && ./gradlew build

echo ""
echo "Done! Run 'bash run.sh' to start the game."
