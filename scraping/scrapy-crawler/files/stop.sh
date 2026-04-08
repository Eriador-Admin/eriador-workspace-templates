#!/bin/bash
echo "Stopping {{PROJECT_NAME}}..."
pkill -f "scrapy" 2>/dev/null || true
echo "Stopped."
