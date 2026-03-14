#!/usr/bin/env bash
set -e
npm install
[ ! -f .env ] && cp .env.example .env
echo "Angular project initialized. Run: bash run.sh"
