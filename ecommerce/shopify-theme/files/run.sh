#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} dev server..."
shopify theme dev --store "$SHOPIFY_FLAG_STORE"
