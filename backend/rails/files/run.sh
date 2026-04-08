#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PORT="${DEV_PORT:-3000}"
bundle exec rails server -p "$PORT"
