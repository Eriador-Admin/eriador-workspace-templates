#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Training runs as a foreground process. Use Ctrl+C to stop."
echo "To view TensorBoard: tensorboard --logdir=runs"
