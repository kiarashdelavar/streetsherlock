#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

bash scripts/verify-tools.sh
corepack enable
pnpm install --frozen-lockfile

printf '\nBootstrap complete. Run: pnpm check\n'

