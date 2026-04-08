#!/bin/bash
set -e
echo "Installing Node dependencies..."
npm install
echo "Checking Rust toolchain..."
rustc --version || echo "Rust not found — install from https://rustup.rs"
echo "Done! Run 'bash run.sh' to start in dev mode."
