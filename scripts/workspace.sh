#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

run_lint() {
  bash -n scripts/*.sh
  bash scripts/test-structure.sh
  docker compose --env-file .env.example config --quiet
}

run_test() {
  bash scripts/test-tooling.sh
  bash scripts/test-database-contract.sh
}

run_build() {
  pnpm install --offline --frozen-lockfile --ignore-scripts
  printf 'Workspace build contract passed; component builds arrive in E01-03..05.\n'
}

case "${1:-}" in
  lint) run_lint ;;
  test) run_test ;;
  build) run_build ;;
  check) run_lint; run_test; run_build ;;
  *) printf 'Usage: %s {lint|test|build|check}\n' "$0" >&2; exit 64 ;;
esac
