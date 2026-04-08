#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

NAMESPACE="${NAMESPACE:-default}"

helm uninstall {{CHART_NAME}} --namespace "$NAMESPACE" 2>/dev/null \
  && echo "Release {{CHART_NAME}} uninstalled." \
  || echo "Release {{CHART_NAME}} not found."
