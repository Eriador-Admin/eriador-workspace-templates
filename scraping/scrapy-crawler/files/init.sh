#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required."
    exit 1
fi

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

mkdir -p output

echo ""
echo "Setup complete! Run 'bash run.sh' to crawl."
