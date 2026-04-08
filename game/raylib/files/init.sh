#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

command -v cmake >/dev/null 2>&1 || { echo "Error: cmake not found. Install via brew/apt."; exit 1; }

mkdir -p build && cd build
cmake ..
make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu)

echo ""
echo "Done! Run 'bash run.sh' to start the game."
