#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Building debug APK..."
./gradlew assembleDebug 2>&1 | tail -5 || {
  echo "If gradlew is not executable, run: chmod +x gradlew"
  exit 1
}
echo "APK built at app/build/outputs/apk/debug/"
