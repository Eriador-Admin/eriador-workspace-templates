#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v deno &> /dev/null; then
  echo "Installing Deno..."
  curl -fsSL https://deno.land/install.sh | sh
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

echo "Caching dependencies..."
deno cache dev.ts

echo "Done! Run 'bash run.sh' to start the dev server."
