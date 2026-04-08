#!/bin/bash
set -e
go build -o {{CLI_NAME}} .
echo "Running {{CLI_NAME}}..."
./{{CLI_NAME}} greet --name "World"
