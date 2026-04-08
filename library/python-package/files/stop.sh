#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Library projects do not run a persistent process."
echo "Use pytest to run tests."
