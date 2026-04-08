#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}} on port 4000..."
mix phx.server
