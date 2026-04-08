#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Shutting down iOS Simulator..."
xcrun simctl shutdown all 2>/dev/null || true
echo "Simulator stopped."
