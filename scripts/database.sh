#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

compose=(docker compose --env-file "${ENV_FILE:-.env}")

case "${1:-}" in
  up)
    "${compose[@]}" up -d --build database
    "${compose[@]}" --profile tools run --rm flyway migrate
    bash scripts/verify-database.sh
    ;;
  verify)
    bash scripts/verify-database.sh
    ;;
  down)
    "${compose[@]}" down
    ;;
  reset)
    if [[ "${CONFIRM_DATABASE_RESET:-}" != "streetsherlock-local" ]]; then
      printf 'Refusing to delete the local database volume. Run with CONFIRM_DATABASE_RESET=streetsherlock-local.\n' >&2
      exit 64
    fi
    "${compose[@]}" down --volumes
    ;;
  *)
    printf 'Usage: %s {up|verify|down|reset}\n' "$0" >&2
    exit 64
    ;;
esac
