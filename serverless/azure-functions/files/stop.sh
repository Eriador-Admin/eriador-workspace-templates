#!/bin/bash
echo "Stopping Azure Functions runtime..."
pkill -f "func start" 2>/dev/null || true
echo "Azure Functions runtime stopped."
