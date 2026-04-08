#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v dotnet &>/dev/null; then
  echo "Error: .NET SDK is not installed. Install from https://dotnet.microsoft.com/download"
  exit 1
fi

dotnet restore
echo "Setup complete. Run bash run.sh to start the dev server."
