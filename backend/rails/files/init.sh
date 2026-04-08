#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if ! command -v bundle &>/dev/null; then
  gem install bundler
fi

bundle install
bundle exec rails db:create db:migrate
echo "Setup complete. Run bash run.sh to start the dev server."
