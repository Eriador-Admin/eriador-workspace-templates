#!/usr/bin/env bash
set -euo pipefail

echo "==> Available devices:"
flutter devices

echo ""
echo "==> Starting Flutter app..."
flutter run
