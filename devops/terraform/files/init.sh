#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v terraform &>/dev/null; then
  echo "Error: terraform is not installed. Install from https://developer.hashicorp.com/terraform/downloads"
  exit 1
fi

cd environments/dev
terraform init
echo "Terraform initialized. Run bash run.sh to plan and apply."
