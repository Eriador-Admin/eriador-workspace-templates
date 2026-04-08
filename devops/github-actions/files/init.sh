#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

echo "GitHub Actions workflows are in .github/workflows/"
echo "Copy the .github/ directory to your repository root."
echo "No local installation needed — workflows run on GitHub."
