#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing dependencies..."
npm install

if [ ! -f .env ]; then
  echo "==> Copying .env.example to .env..."
  cp .env.example .env
fi

echo "==> Building project..."
npm run build

echo "==> Setup complete! Run ./run.sh to start the server."
