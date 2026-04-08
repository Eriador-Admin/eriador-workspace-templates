#!/bin/bash
echo "Kibana is running at http://localhost:5601"
open http://localhost:5601 2>/dev/null || xdg-open http://localhost:5601 2>/dev/null || echo "Open http://localhost:5601 in your browser"
