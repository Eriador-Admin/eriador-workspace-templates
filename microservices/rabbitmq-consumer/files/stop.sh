#!/bin/bash
echo "Stopping consumer..."
pkill -f "node src/consumer.js" 2>/dev/null || true
echo "Stopping RabbitMQ..."
docker compose down
echo "Stopped."
