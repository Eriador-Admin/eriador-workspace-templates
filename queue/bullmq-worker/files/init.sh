#!/bin/bash
set -e
echo "Starting Redis..."
docker compose up -d
echo "Installing dependencies..."
npm install
echo "Done! Copy .env.example to .env if needed."
