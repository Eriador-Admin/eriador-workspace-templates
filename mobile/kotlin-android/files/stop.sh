#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Stopping Gradle daemon..."
./gradlew --stop 2>/dev/null || true
echo "Gradle daemon stopped."
