#!/usr/bin/env bash
set -euo pipefail

grep -q 'pgvector/pgvector:0.8.0-pg17' infra/database/Dockerfile
grep -q 'postgresql-17-postgis-3' infra/database/Dockerfile
grep -q 'flyway/flyway:11.8.2' compose.yaml
grep -q 'FLYWAY_CLEAN_DISABLED: "true"' compose.yaml
grep -q '127.0.0.1:' compose.yaml
grep -q 'CREATE EXTENSION IF NOT EXISTS postgis' infra/database/migrations/V1__enable_required_extensions.sql
grep -q 'CREATE EXTENSION IF NOT EXISTS vector' infra/database/migrations/V1__enable_required_extensions.sql

if CONFIRM_DATABASE_RESET=wrong bash scripts/database.sh reset >/dev/null 2>&1; then
  printf 'Expected unconfirmed reset to fail.\n' >&2
  exit 1
fi

printf 'CLONE-002: static database contract and safe-reset refusal passed.\n'
