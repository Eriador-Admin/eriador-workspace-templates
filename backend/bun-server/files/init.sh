#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v bun &> /dev/null; then
  echo "Bun not found. Installing..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi

bun install
echo ""
echo "Setup complete! Run 'bash run.sh' to start."
