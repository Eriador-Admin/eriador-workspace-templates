#!/bin/bash
set -e
echo "Running {{PROJECT_NAME}} — example spider..."

if [ -d "venv" ]; then
    source venv/bin/activate
fi

mkdir -p output
scrapy crawl example -O output/quotes.json
