#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."
npm install
npx hardhat compile
echo ""
echo "Installing frontend dependencies..."
cd frontend && npm install && cd ..
echo ""
echo "Done! Run 'bash run.sh' to start local node + frontend."
