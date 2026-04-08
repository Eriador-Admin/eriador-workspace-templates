#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Installing Playwright browsers..."
npx playwright install
echo "Done! Run 'bash run.sh' to execute tests."
