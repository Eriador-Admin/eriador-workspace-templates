#!/bin/bash
set -e
ENVIRONMENT=${1:-staging}
echo "Deploying {{PROJECT_NAME}} to ${ENVIRONMENT}..."

case $ENVIRONMENT in
  dev)
    echo "Deploying to development..."
    ;;
  staging)
    echo "Deploying to staging..."
    ;;
  production)
    echo "Deploying to production..."
    ;;
  *)
    echo "Unknown environment: ${ENVIRONMENT}"
    exit 1
    ;;
esac

echo "Deployment to ${ENVIRONMENT} complete."
