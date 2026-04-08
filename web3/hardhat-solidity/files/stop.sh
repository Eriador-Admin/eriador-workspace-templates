#!/bin/bash
echo "Stopping local Hardhat node..."
pkill -f "hardhat node" 2>/dev/null || true
echo "Stopped."
