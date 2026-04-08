#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
docker compose up -d
npm install
echo "Done! Mosquitto broker running on port 1883."
echo "Run 'bash run.sh' to start the demo."
