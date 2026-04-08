#!/bin/bash
# Send deployment notification
# Usage: bash notify.sh "Deployed to staging"
MESSAGE="${1:-Deployment complete}"
echo "Notification: $MESSAGE"
echo "Project: $CI_PROJECT_NAME"
echo "Commit: $CI_COMMIT_SHORT_SHA"
echo "Pipeline: $CI_PIPELINE_URL"

# Uncomment to send webhook notification:
# curl -X POST "$SLACK_WEBHOOK_URL" \
#   -H "Content-Type: application/json" \
#   -d "{\"text\": \"$MESSAGE — $CI_PROJECT_NAME ($CI_COMMIT_SHORT_SHA)\"}"
