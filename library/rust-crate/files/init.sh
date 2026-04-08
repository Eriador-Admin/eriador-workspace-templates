#!/bin/bash
set -e
echo "Checking Rust toolchain..."
rustc --version
cargo --version
echo "Ready!"
