#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Building MapReduce project..."
mvn clean package -q
echo "Build complete. Run bash run.sh to execute the job."
