#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
echo "Setup complete. Run bash run.sh to start Jupyter."
