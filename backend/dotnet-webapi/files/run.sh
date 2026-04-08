#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PORT="${DEV_PORT:-5000}"
ASPNETCORE_URLS="http://0.0.0.0:$PORT" dotnet run
