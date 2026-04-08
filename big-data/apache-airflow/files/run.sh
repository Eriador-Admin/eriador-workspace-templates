#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env ]; then
  set -a; source .env; set +a
fi

docker compose up -d airflow-webserver airflow-scheduler
echo "Airflow running at http://localhost:${AIRFLOW_PORT:-8080}"
echo "Login: admin / admin"
