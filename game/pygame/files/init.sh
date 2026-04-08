#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo ""
echo "Done! Run 'bash run.sh' to start the game."
