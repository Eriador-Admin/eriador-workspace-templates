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

echo ""
echo "Setup complete!"
echo "1. Copy .env.example to .env and set your TELEGRAM_BOT_TOKEN"
echo "2. Run 'bash run.sh' to start the bot"
