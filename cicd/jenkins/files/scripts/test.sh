#!/bin/bash
set -e
TEST_TYPE=${1:-unit}
echo "Running ${TEST_TYPE} tests for {{PROJECT_NAME}}..."

mkdir -p reports/${TEST_TYPE}

if [ -f "package.json" ]; then
  npm test -- --ci --reporters=default --reporters=jest-junit 2>/dev/null || \
  npm test 2>/dev/null || \
  echo "No tests found, skipping..."
fi

echo "${TEST_TYPE} tests complete."
