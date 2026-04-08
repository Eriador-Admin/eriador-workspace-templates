#!/bin/bash
set -e
echo "Starting SAM local API on port {{DEV_PORT}}..."
sam local start-api --port {{DEV_PORT}}
