#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting PostgreSQL..."
docker compose up -d
sleep 3
echo "Generating and applying migrations..."
npx drizzle-kit generate
npx drizzle-kit migrate
echo "Seeding database..."
npm run db:seed
echo "Done!"
