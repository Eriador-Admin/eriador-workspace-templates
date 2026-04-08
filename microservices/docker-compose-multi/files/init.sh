#!/bin/bash
set -e
echo "Building all services..."
docker compose build
echo "Done! Run 'bash run.sh' to start all services."
