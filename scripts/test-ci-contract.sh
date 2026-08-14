#!/usr/bin/env bash
set -euo pipefail

workflow=".github/workflows/ci.yml"

[[ -f "$workflow" ]] || {
  printf 'Missing CI workflow: %s\n' "$workflow" >&2
  exit 1
}

required_jobs=(
  backend
  web-and-contracts
  vision
  migration-from-empty
  dependency-review
  filesystem-scan
)

for job in "${required_jobs[@]}"; do
  grep -q "^  ${job}:" "$workflow" || {
    printf 'Missing required CI job: %s\n' "$job" >&2
    exit 1
  }
done

grep -q '^permissions:$' "$workflow"
grep -q '^  contents: read$' "$workflow"

if grep -q 'pull_request_target:' "$workflow"; then
  printf 'Unsafe pull_request_target trigger is not allowed.\n' >&2
  exit 1
fi

unpinned_actions="$(
  grep -E '^[[:space:]]+uses:' "$workflow" |
    grep -Ev '@[0-9a-f]{40}([[:space:]]+#.*)?$' || true
)"

if [[ -n "$unpinned_actions" ]]; then
  printf 'Every GitHub Action must use a full commit SHA:\n%s\n' \
    "$unpinned_actions" >&2
  exit 1
fi

grep -q 'fail-on-severity: high' "$workflow"
grep -q 'severity: HIGH,CRITICAL' "$workflow"
grep -q 'exit-code: "1"' "$workflow"

printf 'CI-001: workflow structure and least-privilege policy passed.\n'
printf 'SEC-SUPPLY-001: action pinning and blocking scan policy passed.\n'