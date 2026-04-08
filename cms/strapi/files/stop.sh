#!/bin/bash
echo "Stopping Strapi..."
pkill -f "strapi develop" 2>/dev/null || true
echo "Server stopped."
