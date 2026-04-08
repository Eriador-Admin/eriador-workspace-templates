#!/bin/bash
set -e

echo "Starting Hardhat node..."
npx hardhat node &
NODE_PID=$!
sleep 2

echo "Deploying contract to localhost..."
npx hardhat run scripts/deploy.ts --network localhost

echo "Starting frontend on http://localhost:5173..."
cd frontend && npx vite &
FRONTEND_PID=$!

trap "kill $NODE_PID $FRONTEND_PID 2>/dev/null; exit" SIGINT SIGTERM
wait
