#!/bin/bash
set -e
echo "Starting MongoDB..."
docker compose up -d
echo "Installing backend dependencies..."
cd backend && npm install && cd ..
echo "Installing frontend dependencies..."
cd frontend && npm install && cd ..
echo "Done! Run 'bash run.sh' to start."
