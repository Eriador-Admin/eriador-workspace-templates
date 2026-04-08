#!/bin/bash
echo "Stopping Godot editor..."
pkill -f "godot --editor" 2>/dev/null || true
echo "Stopped."
