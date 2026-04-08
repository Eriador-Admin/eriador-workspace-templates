#!/bin/bash
set -e
source venv/bin/activate
echo "Starting MkDocs dev server on port {{DEV_PORT}}..."
mkdocs serve -a 0.0.0.0:{{DEV_PORT}}
