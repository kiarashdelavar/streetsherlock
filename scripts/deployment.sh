#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

usage() {
  printf 'Usage: %s {plan TARGET|validate-manifest FILE|smoke WEB_URL API_URL|rollback-plan CURRENT TARGET}\n' "$0" >&2
  exit 64
}

config_value() {
  local file="$1"
  local key="$2"
  local line
  line="$(grep -E "^${key}=" "$file" | tail -n 1 || true)"
  [[ -n "$line" ]] || {
    printf 'Missing required configuration key %s in %s.\n' "$key" "$file" >&2
    exit 65
  }
  printf '%s' "${line#*=}"
}

require_safe_target() {
  local target="$1"
  case "$target" in
    local|ci|preview|demo) ;;
    shadow-pilot|production|prod|customer)
      printf 'Target %s is not authorized by E01-12. Separate customer approval is required.\n' "$target" >&2
      exit 78
      ;;
    *)
      printf 'Unknown deployment target: %s.\n' "$target" >&2
      exit 64
      ;;
  esac
}

plan() {
  local target="$1"
  require_safe_target "$target"
  local file="deploy/environments/${target}.env.example"

  [[ -f "$file" ]] || {
    printf 'Missing environment skeleton: %s.\n' "$file" >&2
    exit 66
  }

  [[ "$(config_value "$file" APP_ENVIRONMENT)" == "$target" ]]
  [[ "$(config_value "$file" DEPLOYMENT_TARGET)" == "$target" ]]
  [[ "$(config_value "$file" DATA_CLASSIFICATION)" == "synthetic" ]]
  [[ "$(config_value "$file" ALLOW_REAL_DATA)" == "false" ]]
  [[ "$(config_value "$file" EXTERNAL_SIDE_EFFECTS)" == "disabled" ]]

  if [[ "$target" == "preview" ]]; then
    DATABASE_URL='jdbc:postgresql://database.invalid/streetsherlock' \
    POSTGRES_USER='synthetic-contract-user' \
    POSTGRES_PASSWORD='synthetic-contract-placeholder' \
    OIDC_JWK_SET_URI='https://identity.preview.invalid/certs' \
    STREETSHERLOCK_DEMO_BEARER_TOKEN='synthetic-contract-placeholder' \
      docker compose --env-file "$file" -f deploy/preview.compose.yaml config --quiet
  fi

  printf 'ARCH-ENV-001: %s environment boundary is repository-safe.\n' "$target"
  printf 'OPS-DEP-001..002: configuration and side-effect gates passed for %s.\n' "$target"
}

validate_manifest() {
  local file="$1"
  [[ -f "$file" ]] || {
    printf 'Release manifest not found: %s.\n' "$file" >&2
    exit 66
  }

  python - "$file" <<'PY'
import json
import re
import sys

path = sys.argv[1]
with open(path, encoding="utf-8") as source:
    manifest = json.load(source)

required = {
    "schema_version",
    "release_id",
    "source_commit",
    "environment",
    "fixture_id",
    "fixture_version",
    "migration_version",
    "api_image",
    "web_image",
    "data_classification",
    "external_side_effects",
    "created_at",
    "limitations",
}
missing = sorted(required - manifest.keys())
assert not missing, f"missing manifest fields: {missing}"
assert manifest["environment"] in {"preview", "demo"}
assert manifest["fixture_id"] == "FIX-SYN-DEV-001"
assert manifest["fixture_version"] == "1.0.0"
assert manifest["data_classification"] == "synthetic"
assert manifest["external_side_effects"] == "disabled"
assert isinstance(manifest["migration_version"], int)
assert manifest["migration_version"] >= 1
assert re.fullmatch(r"[0-9a-f]{40}", manifest["source_commit"])
digest = r"[^\s]+@sha256:[0-9a-f]{64}"
assert re.fullmatch(digest, manifest["api_image"])
assert re.fullmatch(digest, manifest["web_image"])
assert isinstance(manifest["limitations"], list) and manifest["limitations"]
print("OPS-DEP-003: release manifest and digest pins passed.")
PY
}

smoke() {
  local web_url="$1"
  local api_url="$2"

  [[ "$web_url" =~ ^https?:// ]] || {
    printf 'WEB_URL must use http or https.\n' >&2
    exit 65
  }
  [[ "$api_url" =~ ^https?:// ]] || {
    printf 'API_URL must use http or https.\n' >&2
    exit 65
  }

  curl --fail --silent --show-error --max-time 10 "$web_url/" >/dev/null
  curl --fail --silent --show-error --max-time 10 "$api_url/actuator/health/liveness" >/dev/null

  local unauthorized
  unauthorized="$(curl --silent --output /dev/null --write-out '%{http_code}' \
    --max-time 10 "$api_url/api/public/records")"
  [[ "$unauthorized" == "401" ]] || {
    printf 'Expected anonymous public-record API request to return 401; received %s.\n' "$unauthorized" >&2
    exit 1
  }

  printf 'OPS-DEP-004: web, liveness and anonymous-denial smoke checks passed.\n'
}

rollback_plan() {
  local current="$1"
  local target="$2"

  python - "$current" "$target" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as source:
    current = json.load(source)
with open(sys.argv[2], encoding="utf-8") as source:
    target = json.load(source)

if current["environment"] != target["environment"]:
    raise SystemExit("OPS-RB-001 refusal: cross-environment rollback is prohibited.")
if current["data_classification"] != "synthetic" or target["data_classification"] != "synthetic":
    raise SystemExit("OPS-RB-002 refusal: only synthetic Preview/Demo planning is authorized.")
if target["migration_version"] != current["migration_version"]:
    raise SystemExit(
        "OPS-RB-003 refusal: database migrations are forward-only; create a reviewed forward-fix."
    )
if target["source_commit"] == current["source_commit"]:
    raise SystemExit("OPS-RB-004 refusal: target and current commits are identical.")

print("OPS-RB-001..004: application-only rollback plan passed.")
print(f"current={current['release_id']} target={target['release_id']}")
print("Required human steps: review schema compatibility, deploy digest-pinned images, run smoke, preserve evidence.")
PY
}

[[ $# -ge 1 ]] || usage
command="$1"
shift

case "$command" in
  plan)
    [[ $# -eq 1 ]] || usage
    plan "$1"
    ;;
  validate-manifest)
    [[ $# -eq 1 ]] || usage
    validate_manifest "$1"
    ;;
  smoke)
    [[ $# -eq 2 ]] || usage
    smoke "$1" "$2"
    ;;
  rollback-plan)
    [[ $# -eq 2 ]] || usage
    rollback_plan "$1" "$2"
    ;;
  *)
    usage
    ;;
esac
