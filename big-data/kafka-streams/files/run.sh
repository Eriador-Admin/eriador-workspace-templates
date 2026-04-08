#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env ]; then
  set -a; source .env; set +a
fi

java -jar target/{{ARTIFACT_ID}}-1.0.jar
