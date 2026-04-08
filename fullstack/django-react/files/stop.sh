#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "manage.py runserver" 2>/dev/null || true
pkill -f "vite" 2>/dev/null || true
echo "Stopped."
