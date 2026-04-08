#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v node &> /dev/null; then
    echo "Error: Node.js is required."
    exit 1
fi

npm install

echo ""
echo "Setup complete! Run 'bash run.sh' to start."
