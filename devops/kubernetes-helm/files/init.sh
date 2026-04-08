#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v helm &>/dev/null; then
  echo "Error: helm is not installed. Install from https://helm.sh/docs/intro/install/"
  exit 1
fi

helm lint ./chart
echo "Chart linted successfully. Run bash run.sh to deploy."
