#!/bin/bash
set -e
echo "Starting Firebase emulators..."
npm run emulators &
sleep 3
echo "Starting {{PROJECT_NAME}} API..."
npm run dev
