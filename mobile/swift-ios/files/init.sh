#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v xcodebuild &>/dev/null; then
  echo "Error: Xcode is not installed. Install from the Mac App Store."
  exit 1
fi

echo "Opening project in Xcode..."
open Package.swift
echo "Setup complete. Use Xcode to build and run, or bash run.sh."
