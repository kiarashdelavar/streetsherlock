# StreetSherlock

StreetSherlock is in Sprint 1 engineering-foundation work. E01-01 provides the deterministic monorepo shell, E01-02 adds the synthetic local spatial database foundation, E01-03 adds the Spring Boot modular-monolith shell, E01-04 adds the accessible Next.js shell, E01-05 adds the disabled FastAPI vision contract, E01-06 adds the deny-by-default OIDC/dev identity boundary, E01-07 adds privacy-safe observability, E01-08 adds the generated OpenAPI/TypeScript contract boundary, E01-09 adds the least-privilege CI matrix, E01-10 adds deterministic synthetic Deventer fixtures with separate Report and Incident records, E01-11 adds an authorized privacy-safe API with equivalent spatial and accessible list views, and E01-12 adds non-mutating deployment, smoke and forward-only rollback skeletons. Real data, a public demo, pilot, AI processing, production identity provider selection, and production use remain unauthorized.

## Prerequisites

| Tool | Required version |
|---|---|
| Node.js | 22.18.0 |
| pnpm | 10.13.1 via Corepack |
| Java | JDK 21 |
| Maven | 3.9.11 |
| Python | 3.12.11 |
| Docker client | 27.0.0 or newer |
| Docker Compose | v2.29.0 or newer |

## Run the current project

Database:

```bash
cp .env.example .env
make db-up
make db-verify
```

Backend and local dev identity:

```bash
docker compose --profile identity up -d identity
export APP_ENVIRONMENT=local
make api-test
make api-run
```

Frontend:

```bash
corepack enable
pnpm install --frozen-lockfile
make web-test
make web-run
```

Vision contract:

```bash
python -m venv apps/vision/.venv
source apps/vision/.venv/bin/activate
python -m pip install -e "apps/vision[dev]"
export VISION_ENVIRONMENT=local
export VISION_INTERNAL_TOKEN=replace-with-a-local-only-token
make vision-test
make vision-run
```

Open `http://127.0.0.1:3000`; API health is at `http://127.0.0.1:8080/actuator/health`; local identity is at `http://127.0.0.1:8180`; vision liveness is at `http://127.0.0.1:8001/v1/health/live`. These foundations run independently and no cross-service business flow is claimed.

The persisted synthetic Report/Incident path is documented in [local public-view operations](docs/operations/local-public-view.md). Deployment planning and rollback refusal rules are in [deployment and rollback operations](docs/operations/deployment-and-rollback.md).

Windows PowerShell commands are in [local web operations](docs/operations/local-web.md), [local API operations](docs/operations/local-api.md), [local database operations](docs/operations/local-database.md), and [local vision operations](docs/operations/local-vision.md).

## Root commands

| Command | Purpose |
|---|---|
| `make doctor` / `make bootstrap` | verify pinned tooling and install locked packages |
| `make lint` / `make test` / `make build` / `make check` | validate the workspace foundations |
| `make db-up` / `make db-verify` / `make db-down` | operate the synthetic spatial database |
| `make api-test` / `make api-run` | test or run the Spring Boot shell |
| `make contracts-generate` / `make contracts-check` | generate API types or fail on contract drift |
| `make web-test` / `make web-build` / `make web-run` | test, build, or run the Next.js shell |
| `make vision-lint` / `make vision-test` / `make vision-run` | lint, test, or run the disabled FastAPI contract |

## Monorepo boundary

- `apps/web` — Next.js accessible shell.
- `apps/api` — Spring Boot modular-monolith and OIDC authorization boundary.
- `apps/vision` — FastAPI health/readiness and disabled contract stub.
- `packages/contracts` — reviewed OpenAPI contract and generated TypeScript API types.
- `infra/database` — database image and versioned migrations.
- `infra/identity` — synthetic local-only Keycloak realm; never a production IdP configuration.

PostgreSQL is the future authoritative business-state store. Workflow, AI, telemetry, vision tooling, identity infrastructure, and workspace tooling are never business sources of truth.

## Evidence and limitations
- `CI-001..012` and `SEC-SUPPLY-001..004` cover the CI and supply-chain
  foundation; see [E01-09 CI evidence](docs/testing/e01-09-ci-foundation.md).
- `FIXTURE-001..006` and `API-SEED-001` cover the versioned synthetic Deventer
  fixture, provenance hash, role boundary, separate Report/Incident records and clean
  database persistence; see [E01-10 fixture evidence](docs/testing/e01-10-synthetic-deventer-fixtures.md).
- `AT-S1-001`, `AUTH-PUB-001`, `A11Y-PUB-001` and `API-READ-001` cover
  the authorized persisted public projection and equivalent filtered views; see
  [E01-11 evidence](docs/testing/e01-11-accessible-public-view.md).
- `ARCH-ENV-001`, `OPS-DEP-001..004` and `OPS-RB-001..004` cover
  synthetic environment plans, immutable manifests, smoke-command behavior and
  rollback refusals; see [E01-12 evidence](docs/testing/e01-12-deployment-rollback.md).
- `ARCH-TOOL-001`, `CLONE-001..002`, `ARCH-MOD-001..004`, and `API-SMOKE-001` cover the earlier foundation slices.
- `A11Y-SHELL-001..006` and `WEB-SMOKE-001` cover semantic shell behavior and rendering.
- `API-VISION-001..004` and `ARCH-AUTH-002` cover versioned health, fail-closed readiness, strict refusal, and authorization denial.
- `AUTH-MATRIX-001`, `AUTH-IDOR-001..008`, and `SEC-CONFIG-001` cover the synthetic OIDC role boundary; see [E01-06 authorization evidence](docs/testing/e01-06-authorization.md).
- `API-ERR-001..006`, `PRIV-TEL-001..006`, and `RES-HEALTH-001` cover the observability foundation.
- `CONTRACT-001..006` cover backend OpenAPI truth, generated TypeScript error types, and drift detection; see [E01-08 contract evidence](docs/testing/e01-08-openapi-contract.md).
- Docker-backed identity/database evidence and manual keyboard/browser checks must be run in their stated environments; neither is inferred from static checks.
- No real, personal, municipal, KLIC, image, model, or unverified third-party data is included.
- No production, compliance, availability, AI, security, privacy, backup, identity-provider, or accessibility-conformance claim is made.
