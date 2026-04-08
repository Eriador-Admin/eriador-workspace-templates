#!/bin/bash
set -e
echo "Installing Hugo theme..."
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke 2>/dev/null || true
echo "Done!"
