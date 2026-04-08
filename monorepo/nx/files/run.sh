#!/bin/bash
set -e
echo "Building all projects..."
npx nx run-many -t build
echo "Running app..."
npx nx serve my-app
