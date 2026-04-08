#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v forge &> /dev/null; then
  echo "Installing Foundry..."
  curl -L https://foundry.paradigm.xyz | bash
  source ~/.bashrc 2>/dev/null || source ~/.zshrc 2>/dev/null || true
  foundryup
fi

echo "Installing dependencies..."
forge install foundry-rs/forge-std --no-commit 2>/dev/null || true

echo "Building contracts..."
forge build

echo "Running tests..."
forge test

echo "Done! Run 'bash run.sh' to start a local Anvil node."
