#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

manifest="fixtures/synthetic-deventer/v1/manifest.json"
data="fixtures/synthetic-deventer/v1/data.json"
realm="infra/identity/streetsherlock-dev-realm.json"

[[ -f "$manifest" ]]
[[ -f "$data" ]]
[[ -f "$realm" ]]

expected_hash="$(
  python - "$manifest" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as file:
    manifest = json.load(file)

print(manifest["data_sha256"])
PY
)"

actual_hash="$(sha256sum "$data" | awk '{print $1}')"

if [[ "$actual_hash" != "$expected_hash" ]]; then
  printf 'Fixture hash mismatch. Expected %s, received %s.\n' \
    "$expected_hash" "$actual_hash" >&2
  exit 1
fi

python - "$manifest" "$data" "$realm" <<'PY'
import json
import sys

manifest_path, data_path, realm_path = sys.argv[1:]

with open(manifest_path, encoding="utf-8") as file:
    manifest = json.load(file)

with open(data_path, encoding="utf-8") as file:
    data = json.load(file)

with open(realm_path, encoding="utf-8") as file:
    realm = json.load(file)

assert manifest["classification"] == "synthetic"
assert manifest["source_id"] == "SRC-SYN-DEV"
assert manifest["fixture_version"] == data["fixture_version"]
assert manifest["scenario_clock"] == data["scenario_clock"]
assert manifest["required_label"] == data["municipality"]["fixture_label"]
assert data["municipality"]["is_synthetic"] is True

expected_counts = {
    "municipality": 1,
    "source_provenance": 2,
    "report": 1,
    "incident": 1,
    "report_incident_link": 1,
}
assert manifest["record_counts"] == expected_counts

realm_roles = {
    role["name"]
    for role in realm["roles"]["realm"]
}
required_roles = set(manifest["required_identity_roles"])
assert required_roles <= realm_roles

realm_users = {
    user["username"]
    for user in realm["users"]
}
assert data["report_incident_link"]["linked_by_subject"] in realm_users

serialized = json.dumps(data, ensure_ascii=False).lower()
for prohibited_key in (
    "reporter_name",
    "email",
    "phone",
    "address",
    "licence_plate",
):
    assert prohibited_key not in serialized

assert data["report"]["id"] != data["incident"]["id"]
assert data["report_incident_link"]["report_id"] == data["report"]["id"]
assert data["report_incident_link"]["incident_id"] == data["incident"]["id"]

print("FIXTURE-001..003: manifest, roles and privacy boundary passed.")
PY

compose=(docker compose --env-file "${ENV_FILE:-.env}")
db="${POSTGRES_DB:-streetsherlock}"
user="${POSTGRES_USER:-streetsherlock}"

query() {
  "${compose[@]}" exec -T database \
    psql -v ON_ERROR_STOP=1 -U "$user" -d "$db" -Atqc "$1"
}

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.municipality
  WHERE code = 'SYN-DEV'
    AND is_synthetic
    AND fixture_label LIKE 'Synthetic Deventer%';
")" -eq 1 ]]

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.source_provenance
  WHERE source_id = 'SRC-SYN-DEV'
    AND snapshot_id = 'FIX-SYN-DEV-001'
    AND content_sha256 = '$expected_hash'
    AND classification = 'synthetic'
    AND synthetic;
")" -eq 2 ]]

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.report
  WHERE id = '00000000-0000-4000-8000-000000000020'
    AND municipality_id = '00000000-0000-4000-8000-000000000001'
    AND ST_SRID(location) = 4326;
")" -eq 1 ]]

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.incident
  WHERE id = '00000000-0000-4000-8000-000000000030'
    AND municipality_id = '00000000-0000-4000-8000-000000000001'
    AND ST_SRID(location) = 4326;
")" -eq 1 ]]

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.report_incident_link
  WHERE report_id = '00000000-0000-4000-8000-000000000020'
    AND incident_id = '00000000-0000-4000-8000-000000000030'
    AND link_status = 'confirmed'
    AND linked_by_subject = 'demo-intake';
")" -eq 1 ]]

[[ "$(query "
  SELECT COUNT(*)
  FROM streetsherlock.report AS report
  JOIN streetsherlock.incident AS incident
    ON report.id = incident.id;
")" -eq 0 ]]

printf 'FIXTURE-004..006: persisted Report, Incident and provenance passed.\n'
printf 'API-SEED-001: deterministic database seed verification passed.\n'