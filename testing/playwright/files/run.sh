#!/bin/bash
set -e
echo "Running Playwright tests..."
npx playwright test
echo "Opening test report..."
npx playwright show-report
