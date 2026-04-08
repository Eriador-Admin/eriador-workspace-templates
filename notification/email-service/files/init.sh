#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo "Starting MailHog (local SMTP)..."
docker compose up -d
echo "Done! MailHog UI: http://localhost:8025"
