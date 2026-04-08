#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

ENV="${1:-dev}"
cd "environments/$ENV"

echo "Planning infrastructure for $ENV..."
terraform plan -out=tfplan

read -rp "Apply this plan? (y/N) " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  terraform apply tfplan
  echo "Infrastructure applied."
else
  echo "Apply cancelled."
fi
