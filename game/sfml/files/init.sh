#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

# Check for cmake
if ! command -v cmake &> /dev/null; then
    echo "Error: cmake is required. Install it first."
    echo "  macOS:   brew install cmake"
    echo "  Ubuntu:  sudo apt install cmake"
    exit 1
fi

# Check for SFML
echo "Checking for SFML..."
if pkg-config --exists sfml-all 2>/dev/null; then
    echo "SFML found via pkg-config."
else
    echo "SFML not found locally — CMake FetchContent will download it during build."
fi

mkdir -p build
cd build
cmake ..
echo ""
echo "Setup complete! Run 'bash run.sh' to build and play."
