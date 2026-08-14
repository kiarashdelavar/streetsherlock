#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
compose=(docker compose --env-file "${ENV_FILE:-.env}")
db="${POSTGRES_DB:-streetsherlock}"
user="${POSTGRES_USER:-streetsherlock}"

query() {
  "${compose[@]}" exec -T database psql -v ON_ERROR_STOP=1 -U "$user" -d "$db" -Atqc "$1"
}

[[ "$(query "SELECT extname FROM pg_extension WHERE extname = 'postgis';")" == "postgis" ]]
[[ "$(query "SELECT extname FROM pg_extension WHERE extname = 'vector';")" == "vector" ]]
[[ "$(query "SELECT COUNT(*) FROM public.flyway_schema_history WHERE success;")" -eq 4 ]]
[[ "$(query "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name = 'streetsherlock';")" -eq 1 ]]

printf 'DB-MIG-001..004: extensions, migration history and application schema verified.\n'
