# StreetSherlock

StreetSherlock is in Sprint 1 engineering-foundation work. E01-01 provides the deterministic Local/CI monorepo shell, and E01-02 adds a synthetic local spatial database foundation. The repository does not authorize real data, a public demo, pilot, or production use.

## Prerequisites

Supported development environments are Linux, macOS, and WSL2 with:

| Tool | Required version |
|---|---|
| Node.js | 22.18.0 |
| pnpm | 10.13.1 via Corepack |
| Java | JDK 21 (`.sdkmanrc` pins Temurin 21.0.7) |
| Python | 3.12.11 |
| Docker client | 27.0.0 or newer |
| Docker Compose | v2.29.0 or newer |

The exact toolchain is recorded in `.tool-versions` and `scripts/versions.env`.

## Clean-clone bootstrap

```bash
git clone https://github.com/kiarashdelavar/streetsherlock.git
cd streetsherlock
make bootstrap
make check
cp .env.example .env
make db-up
make db-verify
```

Replace the example local password before starting the database. `make db-up` starts PostgreSQL 17, enables PostGIS and pgvector through Flyway, and verifies the empty application schema. Re-running it is safe and proves idempotency.

## Root commands

| Command | Purpose |
|---|---|
| `make doctor` | verify pinned runtimes and minimum container tooling |
| `make bootstrap` | verify tools and perform locked pnpm installation |
| `make lint` | validate shell, workspace and Compose structure |
| `make test` | run CLONE-001 and CLONE-002 contract tests |
| `make build` | prove the current workspace resolves offline |
| `make check` | run lint, test and build |
| `make db-up` | build/start the local database, migrate and verify |
| `make db-verify` | verify extensions, migration history and schema |
| `make db-down` | stop services while preserving the named volume |
| `make db-reset` | guarded removal of only the project database volume |

See [local database operations](docs/operations/local-database.md) for reset safety and evidence requirements.

## Monorepo boundary

- `apps/web` — reserved for the E01-04 Next.js shell.
- `apps/api` — reserved for the E01-03 Spring Boot modular monolith.
- `apps/vision` — reserved for the E01-05 FastAPI contract stub.
- `packages/contracts` — reserved for generated/versioned contracts.
- `infra/database` — E01-02 database image and versioned migrations.
- `scripts` — repository-level, fail-fast developer interfaces.
- `docs` — controlled planning and delivery evidence.

PostgreSQL is the future authoritative business-state store. Workflow, AI, telemetry, and workspace tooling are never business sources of truth.

## Current evidence and limitations

- `ARCH-TOOL-001` validates the workspace structure.
- `CLONE-001` exercises supported prerequisites and unsupported-runtime failure.
- `CLONE-002` validates the static Compose contract and safe-reset refusal.
- `DB-MIG-001..004` require an actual Docker execution and must not be claimed from static checks alone.
- No real, personal, municipal, KLIC, or unverified third-party data is included.
- No production, compliance, availability, security, privacy, backup, or accessibility claim is made.
