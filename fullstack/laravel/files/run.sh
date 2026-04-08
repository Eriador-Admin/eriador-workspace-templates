#!/bin/bash
set -e
echo "Starting {{PROJECT_NAME}}..."
php artisan serve --port={{DEV_PORT}}
