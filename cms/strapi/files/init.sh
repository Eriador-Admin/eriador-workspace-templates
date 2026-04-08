#!/bin/bash
set -e
echo "Installing dependencies..."
npm install
echo "Done! Copy .env.example to .env and update the secret keys."
