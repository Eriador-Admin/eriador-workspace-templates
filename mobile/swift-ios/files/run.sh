#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Building and running in iOS Simulator..."
xcodebuild -scheme "{{APP_NAME}}" -destination "platform=iOS Simulator,name=iPhone 16" build 2>&1 | tail -5
echo "Build complete. Open Xcode to run in simulator."
