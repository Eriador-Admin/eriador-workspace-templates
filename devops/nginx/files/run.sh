#!/bin/bash
set -e
echo "Following Nginx logs..."
docker compose logs -f nginx
