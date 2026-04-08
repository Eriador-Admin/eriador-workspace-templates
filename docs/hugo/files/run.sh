#!/bin/bash
set -e
echo "Starting Hugo dev server on port {{DEV_PORT}}..."
hugo server --port {{DEV_PORT}} --bind 0.0.0.0 -D
