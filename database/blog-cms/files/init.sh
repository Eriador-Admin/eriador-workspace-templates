#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "==> Copying .env.example to .env..."
  cp .env.example .env
  echo "==> Please edit .env with your database credentials, then re-run this script."
  exit 0
fi

source .env

VENDOR="${DB_VENDOR:-postgresql}"

echo "==> Running schema for vendor: $VENDOR"

case "$VENDOR" in
  postgresql)
    PGPASSWORD="$PG_PASSWORD" psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" -f postgresql/schema.sql
    echo "==> Seeding data..."
    PGPASSWORD="$PG_PASSWORD" psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" -f postgresql/seed.sql
    ;;
  mysql)
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < mysql/schema.sql
    echo "==> Seeding data..."
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < mysql/seed.sql
    ;;
  sqlite)
    sqlite3 "$SQLITE_FILE" < sqlite/schema.sql
    echo "==> Seeding data..."
    sqlite3 "$SQLITE_FILE" < sqlite/seed.sql
    ;;
  oracle)
    echo "==> Run with: sqlplus $ORACLE_USER/$ORACLE_PASSWORD@$ORACLE_HOST:$ORACLE_PORT/$ORACLE_SERVICE @oracle/schema.sql"
    echo "==> Then seed: sqlplus $ORACLE_USER/$ORACLE_PASSWORD@$ORACLE_HOST:$ORACLE_PORT/$ORACLE_SERVICE @oracle/seed.sql"
    ;;
  *)
    echo "ERROR: Unknown vendor '$VENDOR'. Expected: postgresql, mysql, sqlite, oracle"
    exit 1
    ;;
esac

echo "==> Done!"
