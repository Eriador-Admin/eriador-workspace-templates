#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} on port ${PORT:-8080}..."
npm run dev
