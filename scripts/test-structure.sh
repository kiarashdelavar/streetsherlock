#!/usr/bin/env bash
set -euo pipefail

required=(
  .tool-versions .nvmrc .node-version .python-version .sdkmanrc
  .env.example compose.yaml package.json pnpm-lock.yaml pnpm-workspace.yaml
  infra/database/Dockerfile
  infra/database/migrations/V1__enable_required_extensions.sql
  infra/database/migrations/V2__create_application_schema.sql
  scripts/versions.env scripts/verify-tools.sh scripts/bootstrap.sh
  scripts/database.sh scripts/verify-database.sh scripts/test-database-contract.sh
  apps/web/README.md apps/api/README.md apps/api/pom.xml
  apps/api/src/main/resources/application.yml
  apps/api/src/test/java/nl/streetsherlock/ArchitectureBoundaryTest.java
  apps/api/src/test/java/nl/streetsherlock/ApiSmokeTest.java
  apps/vision/README.md apps/vision/pyproject.toml
  apps/vision/src/streetsherlock_vision/main.py
  apps/vision/tests/test_contract.py
  docs/operations/local-vision.md
)

for path in "${required[@]}"; do
  [[ -f "$path" ]] || { printf 'Missing required workspace file: %s\n' "$path" >&2; exit 1; }
done

grep -q '"private": true' package.json
grep -q 'pnpm@10.13.1' package.json
grep -q '<version>3.5.4</version>' apps/api/pom.xml
grep -q 'anyRequest().denyAll()' apps/api/src/main/java/nl/streetsherlock/config/SecurityConfiguration.java
grep -q 'fastapi==0.116.1' apps/vision/pyproject.toml
grep -q 'vision_not_implemented' apps/vision/src/streetsherlock_vision/main.py
printf 'ARCH-TOOL-001: workspace structure passed.\n'
