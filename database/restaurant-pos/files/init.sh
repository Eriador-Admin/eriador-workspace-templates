#!/usr/bin/env bash
set -euo pipefail

VENDOR="{{DB_VENDOR}}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Initialising {{APP_NAME}} with $VENDOR schema …"

case "$VENDOR" in
  postgresql)
    psql -f "$SCRIPT_DIR/postgresql/schema.sql"
    psql -f "$SCRIPT_DIR/postgresql/seed.sql"
    ;;
  mysql)
    mysql < "$SCRIPT_DIR/mysql/schema.sql"
    mysql < "$SCRIPT_DIR/mysql/seed.sql"
    ;;
  sqlite)
    sqlite3 "{{APP_NAME}}.db" < "$SCRIPT_DIR/sqlite/schema.sql"
    sqlite3 "{{APP_NAME}}.db" < "$SCRIPT_DIR/sqlite/seed.sql"
    ;;
  oracle)
    sqlplus /nolog @"$SCRIPT_DIR/oracle/schema.sql"
    sqlplus /nolog @"$SCRIPT_DIR/oracle/seed.sql"
    ;;
  *)
    echo "Unknown vendor: $VENDOR" >&2
    exit 1
    ;;
esac

echo "Done."
