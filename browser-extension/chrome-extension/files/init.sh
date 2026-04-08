#!/bin/bash
echo "No build step needed for this extension."
echo "Load as unpacked extension in Chrome:"
echo "  1. Open chrome://extensions/"
echo "  2. Enable Developer mode"
echo "  3. Click 'Load unpacked' and select this directory"
echo ""
echo "Note: You'll need to add icon files to the icons/ directory."
echo "Placeholder icons can be any PNG at 16x16, 48x48, and 128x128."
mkdir -p icons
