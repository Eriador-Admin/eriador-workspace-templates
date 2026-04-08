#!/bin/bash
echo "Jenkins is running at http://localhost:8080"
echo "Login: admin / admin"
open http://localhost:8080 2>/dev/null || xdg-open http://localhost:8080 2>/dev/null || echo "Open http://localhost:8080 in your browser"
