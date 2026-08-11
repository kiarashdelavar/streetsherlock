#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPEC="$ROOT_DIR/packages/contracts/openapi.json"
GENERATED="$ROOT_DIR/packages/contracts/src/generated/api-types.ts"
GENERATOR="openapi-typescript@7.9.1"

generate() {
  mkdir -p "$(dirname "$GENERATED")"
  pnpm --silent dlx "$GENERATOR" "$SPEC" -o "$GENERATED"
}

check() {
  local temp_dir
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' RETURN
  pnpm --silent dlx "$GENERATOR" "$SPEC" -o "$temp_dir/api-types.ts"

  if ! cmp -s "$temp_dir/api-types.ts" "$GENERATED"; then
    printf '%s\n'       'Generated API types are stale.'       'Run: pnpm contracts:generate' >&2
    diff -u "$GENERATED" "$temp_dir/api-types.ts" || true
    return 1
  fi

  printf 'OpenAPI TypeScript client is current.\n'
}

case "${1:-}" in
  generate) generate ;;
  check) check ;;
  *) printf 'Usage: %s {generate|check}\n' "$0" >&2; exit 64 ;;
esac
