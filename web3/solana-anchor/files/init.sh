#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

# Install Node.js dependencies (for tests)
npm install

# Install frontend dependencies
cd app && npm install && cd ..

# Check for required tools
command -v solana >/dev/null 2>&1 || { echo "Error: solana CLI not found. Install from https://docs.solana.com/cli/install-solana-cli-tools"; exit 1; }
command -v anchor >/dev/null 2>&1 || { echo "Error: anchor CLI not found. Install from https://www.anchor-lang.com/docs/installation"; exit 1; }

# Configure Solana for local development
solana config set --url localhost

# Generate a keypair if one doesn't exist
if [ ! -f ~/.config/solana/id.json ]; then
  echo "Generating new Solana keypair..."
  solana-keygen new --no-bip39-passphrase
fi

# Build the Anchor program
echo "Building Anchor program..."
anchor build

# Get the program ID and display it
PROGRAM_ID=$(anchor keys list | grep counter | awk '{print $NF}')
echo ""
echo "Program ID: $PROGRAM_ID"
echo "Update declare_id!() in programs/counter/src/lib.rs"
echo "Update [programs.localnet] in Anchor.toml"
echo ""
echo "Done! Run 'bash run.sh' to start the validator and run tests."
