#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

# Generate self-signed SSL cert for dev
mkdir -p nginx/ssl
if [ ! -f nginx/ssl/cert.pem ]; then
  echo "Generating self-signed SSL certificate..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/key.pem \
    -out nginx/ssl/cert.pem \
    -subj "/CN=localhost" 2>/dev/null
fi

docker compose up -d --build
echo ""
echo "Done!"
echo "  HTTP:   http://localhost"
echo "  API:    http://localhost/api/"
echo "  Health: http://localhost/health"
