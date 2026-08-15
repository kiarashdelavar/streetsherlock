#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

for target in local ci preview demo; do
  bash scripts/deployment.sh plan "$target" >/dev/null
done

if bash scripts/deployment.sh plan production >/dev/null 2>&1; then
  printf 'Production planning must remain approval-gated.\n' >&2
  exit 1
fi

if grep -R -E '(BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY|gho_[A-Za-z0-9]+|sk-[A-Za-z0-9]{20,})' \
    deploy/environments deploy/release-manifest.example.json; then
  printf 'Deployment skeleton contains a secret-like value.\n' >&2
  exit 1
fi

bash scripts/deployment.sh validate-manifest \
  deploy/release-manifest.example.json >/dev/null

temporary="$(mktemp -d)"
trap 'rm -rf "$temporary"' EXIT

python - deploy/release-manifest.example.json "$temporary" <<'PY'
import json
import pathlib
import sys

with open(sys.argv[1], encoding="utf-8") as source:
    current = json.load(source)

current["release_id"] = "preview-current"
current["source_commit"] = "1" * 40
target = dict(current)
target["release_id"] = "preview-target"
target["source_commit"] = "2" * 40

root = pathlib.Path(sys.argv[2])
(root / "current.json").write_text(json.dumps(current), encoding="utf-8")
(root / "target.json").write_text(json.dumps(target), encoding="utf-8")

older = dict(target)
older["migration_version"] = current["migration_version"] - 1
(root / "older.json").write_text(json.dumps(older), encoding="utf-8")
PY

bash scripts/deployment.sh rollback-plan \
  "$temporary/current.json" "$temporary/target.json" >/dev/null

if bash scripts/deployment.sh rollback-plan \
    "$temporary/current.json" "$temporary/older.json" >/dev/null 2>&1; then
  printf 'Database migration reversal must be refused.\n' >&2
  exit 1
fi

grep -q 'read_only: true' deploy/preview.compose.yaml
grep -q 'cap_drop: \[ALL\]' deploy/preview.compose.yaml
grep -q 'no-new-privileges:true' deploy/preview.compose.yaml
grep -q 'pull_policy: never' deploy/preview.compose.yaml
grep -q 'ALLOW_REAL_DATA=false' deploy/environments/demo.env.example
grep -q 'EXTERNAL_SIDE_EFFECTS=disabled' deploy/environments/demo.env.example

printf 'ARCH-ENV-001: Local/CI/Preview/Demo boundaries passed.\n'
printf 'OPS-DEP-001..004: plan, manifest, secret and smoke contracts passed.\n'
printf 'OPS-RB-001..004: rollback refusal and forward-fix policy passed.\n'
