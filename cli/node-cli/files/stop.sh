#!/bin/bash
echo "Unlinking {{CLI_NAME}}..."
npm unlink 2>/dev/null || true
echo "CLI unlinked."
