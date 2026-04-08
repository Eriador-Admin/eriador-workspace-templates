#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
npm install
echo ""
echo "Setup complete!"
echo "1. Copy .env.example to .env and set your Lemon Squeezy credentials"
echo "2. Run 'bash run.sh' to start"
