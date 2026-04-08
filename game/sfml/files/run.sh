#!/bin/bash
set -e
echo "Building and running {{PROJECT_NAME}}..."

mkdir -p build
cd build
cmake --build . --parallel
./{{PROJECT_NAME}}
