#!/bin/bash
set -e
echo "Starting Cloud Functions local server on port {{DEV_PORT}}..."
npx @google-cloud/functions-framework --target=helloWorld --port={{DEV_PORT}}
