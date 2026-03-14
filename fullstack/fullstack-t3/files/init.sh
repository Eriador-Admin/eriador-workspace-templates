#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

npm install
npx prisma generate
npx prisma db push
echo "Setup complete. Run bash run.sh to start the dev server."
