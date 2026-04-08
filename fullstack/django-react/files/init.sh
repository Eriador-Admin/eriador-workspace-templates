#!/bin/bash
set -e
echo "Setting up backend..."
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
cd ..

echo "Setting up frontend..."
cd frontend
npm install
cd ..

echo "Done! Copy .env.example to .env if needed."
