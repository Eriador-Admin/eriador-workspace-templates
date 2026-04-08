#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting PostgreSQL..."
docker compose up -d
echo "Waiting for PostgreSQL..."
sleep 3
echo "Running migrations..."
npx prisma migrate dev --name init
echo "Seeding database..."
npx prisma db seed
echo "Done!"
