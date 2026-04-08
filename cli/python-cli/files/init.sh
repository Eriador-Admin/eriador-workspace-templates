#!/bin/bash
set -e
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate
echo "Installing {{CLI_NAME}} in editable mode..."
pip install -e ".[dev]"
echo "Done! Run 'bash run.sh' or '{{CLI_NAME}} --help'."
