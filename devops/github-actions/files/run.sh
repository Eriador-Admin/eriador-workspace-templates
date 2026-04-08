#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "GitHub Actions workflows run on GitHub, not locally."
echo "To test locally, install act: https://github.com/nektos/act"
echo ""
if command -v act &>/dev/null; then
  act --list
else
  echo "Install act to run workflows locally: brew install act"
fi
