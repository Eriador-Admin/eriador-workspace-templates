#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Library projects do not run a persistent process."
echo "Use 'npm run dev' for watch mode, or Ctrl+C to stop."
