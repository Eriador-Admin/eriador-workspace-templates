#!/bin/bash
set -e
source venv/bin/activate
echo "Running {{CLI_NAME}}..."
{{CLI_NAME}} greet "World"
