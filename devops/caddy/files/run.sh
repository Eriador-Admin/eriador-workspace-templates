#!/bin/bash
set -e
echo "Following Caddy logs..."
docker compose logs -f caddy
