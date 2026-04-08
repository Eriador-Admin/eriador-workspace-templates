#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo ""
if ! command -v firebase &> /dev/null; then
  echo "Installing Firebase CLI..."
  npm install -g firebase-tools
fi
echo "Done! Start emulators with: npm run emulators"
