#!/bin/bash
set -e
echo "Starting RabbitMQ..."
docker compose up -d
echo "Installing dependencies..."
npm install
echo "Done! RabbitMQ management UI at http://localhost:{{RABBITMQ_MGMT_PORT}}"
