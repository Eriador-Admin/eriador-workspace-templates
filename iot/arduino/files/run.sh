#!/bin/bash
set -e
echo "Building and uploading to {{BOARD}}..."
pio run --target upload
echo "Starting serial monitor..."
pio device monitor
