#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Done! Run 'bash run.sh' to start the local dev server."
