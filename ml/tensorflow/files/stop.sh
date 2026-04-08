#!/bin/bash
echo "Stopping training..."
pkill -f "python train.py" 2>/dev/null || true
echo "Stopped."
