#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Done! Copy .env.example to .env and add your OAuth credentials."
echo "Generate AUTH_SECRET: npx auth secret"
