#!/bin/bash
set -e
echo "Installing {{PROJECT_NAME}} dependencies..."
npm install
echo ""
echo "Done! Configure your Supabase keys in .env before running."
echo "Then run the SQL in supabase/migrations/001_init.sql in your Supabase SQL editor."
