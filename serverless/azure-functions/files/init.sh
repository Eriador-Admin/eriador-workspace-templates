#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Building TypeScript..."
npm run build
echo "Done! Run 'bash run.sh' to start the local Functions runtime."
