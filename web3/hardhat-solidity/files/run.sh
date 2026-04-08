#!/bin/bash
set -e
echo "Compiling contracts..."
npx hardhat compile
echo "Running tests..."
npx hardhat test
