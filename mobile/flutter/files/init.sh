#!/usr/bin/env bash
set -euo pipefail

echo "==> Checking Flutter installation..."
flutter --version

echo "==> Installing dependencies..."
flutter pub get

if [ ! -f .env ]; then
  echo "==> Copying .env.example to .env..."
  cp .env.example .env
fi

echo "==> Running Flutter diagnostics..."
flutter doctor

echo "==> Setup complete! Run ./run.sh to start the app."
