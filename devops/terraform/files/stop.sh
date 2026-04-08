#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

ENV="${1:-dev}"
cd "environments/$ENV"

echo "Destroying infrastructure for $ENV..."
terraform destroy
