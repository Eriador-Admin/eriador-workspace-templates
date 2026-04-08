#!/bin/bash
set -e
echo "Installing Shopify CLI..."
npm install -g @shopify/cli @shopify/theme
echo "Done! Copy .env.example to .env and set your store URL."
