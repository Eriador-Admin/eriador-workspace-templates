#!/bin/bash
set -e
cd "$(dirname "$0")"
echo "Starting MySQL..."
docker compose up -d --wait
echo "Installing dependencies..."
composer install
echo "Setting up environment..."
if [ ! -f .env ]; then
  cp .env.example .env
  php artisan key:generate
fi
echo "Running migrations..."
php artisan migrate
echo "Done!"
