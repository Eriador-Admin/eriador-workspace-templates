#!/bin/bash
set -e
echo "Starting gRPC server on port {{GRPC_PORT}}..."
node src/server.js
