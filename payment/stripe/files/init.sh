#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo ""
echo "Done! Configure your Stripe keys in .env before running."
echo "Get test keys at: https://dashboard.stripe.com/test/apikeys"
