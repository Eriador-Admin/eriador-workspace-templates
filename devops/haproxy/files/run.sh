#!/bin/bash
set -e
echo "Following HAProxy logs..."
docker compose logs -f haproxy
