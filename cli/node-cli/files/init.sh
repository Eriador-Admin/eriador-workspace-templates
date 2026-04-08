#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Building CLI..."
npm run build
echo "Linking CLI globally..."
npm link
echo "Done! Run '{{CLI_NAME}} --help' or 'bash run.sh' to test."
