# StreetSherlock

StreetSherlock is in Sprint 1 engineering-foundation work. E01-01 provides the deterministic monorepo shell, E01-02 adds the synthetic local spatial database foundation, and E01-03 adds the Spring Boot modular-monolith shell. Real data, a public demo, pilot, and production use remain unauthorized.

## Prerequisites

Supported development environments are Linux, macOS, and WSL2. Windows users can run service commands in PowerShell.

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

Database (Docker Desktop must be running):

```bash
cp .env.example .env
make db-up
make db-verify
```

Backend (Docker is not required for the E01-03 shell):

```bash
export APP_ENVIRONMENT=local
make api-test
make api-run
```

Health is available at `http://127.0.0.1:8080/actuator/health`. The Next.js frontend is planned for E01-04 and cannot be run yet.

Windows PowerShell equivalents are documented in [local API operations](docs/operations/local-api.md). Database reset is guarded; see [local database operations](docs/operations/local-database.md).

## Root commands

| Command | Purpose |
|---|---|
| `make doctor` | verify pinned runtimes and container tooling |
| `make bootstrap` | verify tools and perform locked pnpm installation |
| `make lint` | validate shell, workspace and Compose structure |
| `make test` | run workspace contract tests |
| `make build` | prove the workspace resolves offline |
| `make check` | run lint, test and build |
| `make db-up` / `make db-verify` | start/migrate and verify the spatial database |
| `make db-down` | stop services while preserving the volume |
| `make api-test` / `make api-run` | test or run the Spring Boot shell |

## Monorepo boundary

- `apps/web` — reserved for the E01-04 Next.js shell.
- `apps/api` — Spring Boot modular-monolith shell.
- `apps/vision` — reserved for the E01-05 FastAPI contract stub.
- `packages/contracts` — reserved for generated/versioned contracts.
- `infra/database` — database image and versioned migrations.

PostgreSQL is the future authoritative business-state store. Workflow, AI, telemetry, and workspace tooling are never business sources of truth.

## Current evidence and limitations

- `ARCH-TOOL-001` validates workspace structure.
- `CLONE-001..002` cover tooling and static database contracts.
- `ARCH-MOD-001..004` verify Java package boundaries.
- `API-SMOKE-001` verifies minimal health and deny-by-default behavior.
- Docker-backed `DB-MIG-001..004` must be executed locally and must not be inferred from static checks.
- No real, personal, municipal, KLIC, or unverified third-party data is included.
- No production, compliance, availability, security, privacy, backup, or accessibility claim is made.
