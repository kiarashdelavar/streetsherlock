# StreetSherlock

StreetSherlock is currently in Sprint 1 engineering-foundation work. E01-01 provides a deterministic Local/CI monorepo shell; it does not yet contain application services or authorize real data, a public demo, pilot, or production use.

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

The exact toolchain is recorded in `.tool-versions` and `scripts/versions.env`. Docker is checked now because the dependent Sprint 1 services require it; E01-01 does not start containers.

## Clean-clone bootstrap

```bash
git clone https://github.com/kiarashdelavar/streetsherlock.git
cd streetsherlock
make bootstrap
make check
```

`make bootstrap` first verifies every prerequisite and returns actionable errors before installing the locked empty workspace. It does not download application dependencies or access external data sources.

## Root commands

| Command | Purpose |
|---|---|
| `make doctor` | verify pinned runtimes and minimum container tooling |
| `make bootstrap` | verify tools and perform locked pnpm installation |
| `make lint` | validate shell syntax and workspace structure |
| `make test` | run CLONE-001 prerequisite success/failure tests |
| `make build` | prove the current empty workspace resolves offline |
| `make check` | run lint, test, and build in order |

Equivalent commands are available through `pnpm doctor`, `pnpm lint`, `pnpm test`, `pnpm build`, and `pnpm check` after bootstrap.

## Monorepo boundary

- `apps/web` — reserved for the E01-04 Next.js shell.
- `apps/api` — reserved for the E01-03 Spring Boot modular monolith.
- `apps/vision` — reserved for the E01-05 FastAPI contract stub.
- `packages/contracts` — reserved for generated/versioned contracts.
- `scripts` — repository-level, fail-fast developer interfaces.
- `docs` — controlled Sprint 0 and delivery evidence.

Authoritative business state will belong to PostgreSQL in later issues. Workflow, AI, telemetry, and workspace tooling are never business sources of truth.

## Current evidence and limitations

- `ARCH-TOOL-001` validates the required workspace structure.
- `CLONE-001` exercises both supported prerequisites and an unsupported-runtime failure.
- Full QA-CLONE-001 remains Not Run until the dependent services exist.
- No real, personal, municipal, KLIC, or unverified third-party data is included.
- No production, compliance, availability, security, privacy, or accessibility claim is made.

