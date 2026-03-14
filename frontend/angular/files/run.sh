#!/usr/bin/env bash
set -e
npx ng serve --port "${DEV_PORT:-4200}" --open
