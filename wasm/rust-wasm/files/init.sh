#!/bin/bash
set -e
echo "Installing wasm-pack..."
if ! command -v wasm-pack &> /dev/null; then
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
fi
echo "Building WASM..."
wasm-pack build --target web
echo "Done!"
