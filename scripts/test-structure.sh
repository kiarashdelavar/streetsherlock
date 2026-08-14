#!/usr/bin/env bash
set -euo pipefail

required=(
  .github/workflows/ci.yml .trivyignore.yaml
  scripts/test-ci-contract.sh
  .tool-versions .nvmrc .node-version .python-version .sdkmanrc
  .env.example compose.yaml package.json pnpm-lock.yaml pnpm-workspace.yaml
  infra/database/Dockerfile
  infra/database/migrations/V1__enable_required_extensions.sql
  infra/database/migrations/V2__create_application_schema.sql
  scripts/versions.env scripts/verify-tools.sh scripts/bootstrap.sh
  scripts/database.sh scripts/verify-database.sh scripts/test-database-contract.sh
  apps/web/README.md apps/api/README.md apps/api/pom.xml
  apps/api/src/main/resources/application.yml
  apps/api/src/main/java/nl/streetsherlock/config/CorrelationIdFilter.java
  apps/api/src/main/java/nl/streetsherlock/config/ProblemResponseFactory.java
  apps/api/src/main/java/nl/streetsherlock/config/ApiProblemHandler.java
  apps/api/src/test/java/nl/streetsherlock/ArchitectureBoundaryTest.java
  apps/api/src/test/java/nl/streetsherlock/ApiSmokeTest.java
  apps/api/src/test/java/nl/streetsherlock/ObservabilityFoundationTest.java
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
grep -q '<version>3.5.12</version>' apps/api/pom.xml
grep -q 'anyRequest().authenticated()' apps/api/src/main/java/nl/streetsherlock/config/SecurityConfiguration.java
grep -q 'oauth2ResourceServer' apps/api/src/main/java/nl/streetsherlock/config/SecurityConfiguration.java
grep -q 'X-Correlation-ID' apps/api/src/main/java/nl/streetsherlock/config/CorrelationIdFilter.java
grep -q 'application/problem+json' apps/api/src/main/resources/application.yml || \
  grep -q 'APPLICATION_PROBLEM_JSON' apps/api/src/main/java/nl/streetsherlock/config/ProblemResponseFactory.java
grep -q 'readinessState' apps/api/src/main/resources/application.yml
grep -q 'fastapi==0.116.1' apps/vision/pyproject.toml
grep -q 'vision_not_implemented' apps/vision/src/streetsherlock_vision/main.py
printf 'ARCH-TOOL-001: workspace structure passed.\n'
