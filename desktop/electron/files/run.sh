#!/bin/bash
set -e
echo "Starting {{APP_NAME}} in development mode..."
NODE_ENV=development npm run dev
