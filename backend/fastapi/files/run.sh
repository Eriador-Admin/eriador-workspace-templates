#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -d venv ]; then
  source venv/bin/activate
fi

uvicorn main:app --reload --host 0.0.0.0 --port "${PORT:-8000}"
