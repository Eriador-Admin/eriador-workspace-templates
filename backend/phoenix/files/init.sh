#!/bin/bash
set -e
echo "Setting up {{PROJECT_NAME}}..."

if ! command -v mix &> /dev/null; then
    echo "Error: Elixir is required. Install it first."
    echo "  macOS:   brew install elixir"
    echo "  Ubuntu:  sudo apt install elixir erlang"
    exit 1
fi

mix local.hex --force
mix local.rebar --force
mix deps.get
mix ecto.create
mix ecto.migrate

echo ""
echo "Setup complete! Run 'bash run.sh' to start the Phoenix server."
