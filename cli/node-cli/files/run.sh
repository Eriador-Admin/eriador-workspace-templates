#!/bin/bash
set -e
npm run build
echo "Running {{CLI_NAME}}..."
node dist/index.js greet --name "World"
