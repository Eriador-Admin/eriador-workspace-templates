#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v java &>/dev/null; then
  echo "Error: JDK is not installed. Install JDK 17+."
  exit 1
fi

echo "Opening project in Android Studio..."
if command -v studio &>/dev/null; then
  studio .
elif [ -d "/Applications/Android Studio.app" ]; then
  open -a "Android Studio" .
else
  echo "Android Studio not found. Open this directory manually in Android Studio."
fi
echo "Setup complete."
