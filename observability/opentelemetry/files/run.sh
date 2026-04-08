#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} with tracing..."
node --require ./src/tracing.js src/app.js
