#!/bin/bash
echo "Grafana is running at http://localhost:3000"
open http://localhost:3000 2>/dev/null || xdg-open http://localhost:3000 2>/dev/null || echo "Open http://localhost:3000 in your browser"
