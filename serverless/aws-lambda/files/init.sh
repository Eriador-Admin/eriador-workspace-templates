#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Building SAM application..."
sam build 2>/dev/null || echo "SAM CLI not found — install with: brew install aws-sam-cli"
echo "Done! Run 'bash run.sh' to start the local API."
