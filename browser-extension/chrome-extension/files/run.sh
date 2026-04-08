#!/bin/bash
echo "Opening Chrome extensions page..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  open "chrome://extensions/"
elif [[ "$OSTYPE" == "linux"* ]]; then
  xdg-open "chrome://extensions/" 2>/dev/null || echo "Open chrome://extensions/ manually"
else
  echo "Open chrome://extensions/ in your browser"
fi
