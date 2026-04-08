#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

mkdir -p plugins logs
echo "Initializing Airflow database and admin user..."
docker compose up airflow-init
echo "Setup complete. Run bash run.sh to start Airflow."
