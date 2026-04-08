#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

command -v cargo >/dev/null 2>&1 || { echo "Error: Rust not found. Install from https://rustup.rs/"; exit 1; }

echo "Building (first build may take a while)..."
cargo build

echo ""
echo "Done! Run 'bash run.sh' to start the game."
