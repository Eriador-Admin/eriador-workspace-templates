#!/bin/bash
set -e
echo "Validating {{PROJECT_NAME}} GitLab CI config..."
if command -v gitlab-ci-lint > /dev/null 2>&1; then
  gitlab-ci-lint .gitlab-ci.yml
else
  echo "Tip: Install gitlab-ci-lint for local validation"
  echo "Pipeline files are ready. Push to GitLab to run."
fi
