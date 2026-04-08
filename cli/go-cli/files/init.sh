#!/bin/bash
set -e
echo "Downloading Go dependencies..."
go mod tidy
echo "Building {{CLI_NAME}}..."
go build -o {{CLI_NAME}} .
echo "Done! Run './{{CLI_NAME}} --help' or 'bash run.sh'."
