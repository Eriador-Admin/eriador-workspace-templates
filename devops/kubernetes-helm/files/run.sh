#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

NAMESPACE="${NAMESPACE:-default}"

helm upgrade --install {{CHART_NAME}} ./chart \
  --namespace "$NAMESPACE" \
  --create-namespace

echo "Release {{CHART_NAME}} deployed to namespace $NAMESPACE."
