#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

echo "Building Kafka Streams project..."
mvn clean package -q
echo "Build complete. Run bash run.sh to start the stream processor."
