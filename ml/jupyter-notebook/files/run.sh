#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

source venv/bin/activate

PORT="${JUPYTER_PORT:-8888}"
if [ -f .env ]; then
  PORT=$(grep -E '^JUPYTER_PORT=' .env | cut -d= -f2 || echo "$PORT")
fi

jupyter lab --port="$PORT" --no-browser
