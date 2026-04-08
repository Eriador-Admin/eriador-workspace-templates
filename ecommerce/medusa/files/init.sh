#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Copy .env.example to .env and update DATABASE_URL if needed."
echo "Start PostgreSQL and Redis (docker compose up -d) before running db:migrate."
