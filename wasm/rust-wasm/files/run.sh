#!/bin/bash
set -e
echo "Building WASM..."
wasm-pack build --target web
echo "Starting demo server on port {{DEV_PORT}}..."
cd www
python3 -m http.server {{DEV_PORT}}
