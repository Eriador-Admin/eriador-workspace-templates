#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."

cd backend
source venv/bin/activate 2>/dev/null || true
python manage.py runserver {{DEV_PORT}} &
DJANGO_PID=$!
cd ..

cd frontend
npm run dev &
VITE_PID=$!
cd ..

echo "Backend: http://localhost:{{DEV_PORT}}/api/"
echo "Frontend: http://localhost:5173"
wait $DJANGO_PID $VITE_PID
