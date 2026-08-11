#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

run_lint() {
  bash -n scripts/*.sh
  bash scripts/test-structure.sh
  docker compose --env-file .env.example config --quiet
  pnpm --filter @streetsherlock/web lint
  python -m ruff check apps/vision
}
run_test() {
  bash scripts/test-tooling.sh
  bash scripts/test-database-contract.sh
  bash scripts/contracts.sh check
  pnpm --filter @streetsherlock/web test
  python -m pytest apps/vision
}
run_build() {
  pnpm install --offline --frozen-lockfile --ignore-scripts
  pnpm --filter @streetsherlock/web build
  python -m pip wheel --no-deps --no-build-isolation --wheel-dir /tmp/streetsherlock-vision-wheel apps/vision
}

case "${1:-}" in
  lint) run_lint ;;
  test) run_test ;;
  build) run_build ;;
  check) run_lint; run_test; run_build ;;
  *) printf 'Usage: %s {lint|test|build|check}\n' "$0" >&2; exit 64 ;;
esac
