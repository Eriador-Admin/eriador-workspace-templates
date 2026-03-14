#!/usr/bin/env bash
set -euo pipefail

source .venv/bin/activate

PORT="${PORT:-8000}"

echo "==> Starting Django development server on port $PORT..."
python manage.py runserver "0.0.0.0:$PORT"
