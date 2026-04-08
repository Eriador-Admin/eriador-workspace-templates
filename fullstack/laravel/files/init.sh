#!/bin/bash
set -e
echo "Starting MySQL..."
docker compose up -d
echo "Installing dependencies..."
composer install
echo "Setting up environment..."
cp .env.example .env
php artisan key:generate
echo "Running migrations..."
php artisan migrate
echo "Done!"
