#!/bin/bash
set -e
echo "Running tests..."
forge test -vvv

echo ""
echo "Starting local Anvil node on port 8545..."
anvil
