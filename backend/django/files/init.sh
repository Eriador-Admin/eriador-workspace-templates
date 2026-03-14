#!/usr/bin/env bash
set -euo pipefail

echo "==> Creating virtual environment..."
python3 -m venv .venv

echo "==> Activating virtual environment..."
source .venv/bin/activate

echo "==> Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

if [ ! -f .env ]; then
  echo "==> Copying .env.example to .env..."
  cp .env.example .env
fi

echo "==> Running migrations..."
python manage.py migrate

echo "==> Setup complete! Run ./run.sh to start the server."
