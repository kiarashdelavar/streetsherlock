#!/usr/bin/env bash
set -euo pipefail

required=(
  .tool-versions .nvmrc .node-version .python-version .sdkmanrc
  package.json pnpm-lock.yaml pnpm-workspace.yaml
  scripts/versions.env scripts/verify-tools.sh scripts/bootstrap.sh
  apps/web/README.md apps/api/README.md apps/vision/README.md
)

for path in "${required[@]}"; do
  [[ -f "$path" ]] || { printf 'Missing required workspace file: %s\n' "$path" >&2; exit 1; }
done

grep -q '"private": true' package.json
grep -q 'pnpm@10.13.1' package.json
printf 'ARCH-TOOL-001: workspace structure passed.\n'

