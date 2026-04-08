#!/bin/bash
set -e
echo "Starting Redis..."
docker compose up -d
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate
echo "Installing dependencies..."
pip install -r requirements.txt
echo "Done! Copy .env.example to .env if needed."
