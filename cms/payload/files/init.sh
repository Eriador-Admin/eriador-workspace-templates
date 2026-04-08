#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting MongoDB..."
docker compose up -d
sleep 3
echo "Done! Run 'bash run.sh' to start Payload CMS."
