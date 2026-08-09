# StreetSherlock

StreetSherlock is in Sprint 1 engineering-foundation work. E01-01 provides the deterministic monorepo shell, E01-02 adds the synthetic local spatial database foundation, E01-03 adds the Spring Boot modular-monolith shell, E01-04 adds the accessible Next.js shell, and E01-05 adds the disabled FastAPI vision contract. Real data, a public demo, pilot, AI processing, and production use remain unauthorized.

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

Backend:

```bash
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

Open `http://127.0.0.1:3000`; API health is at `http://127.0.0.1:8080/actuator/health`; vision liveness is at `http://127.0.0.1:8001/v1/health/live`. These foundations run independently and no cross-service business flow is claimed.

Windows PowerShell commands are in [local web operations](docs/operations/local-web.md), [local API operations](docs/operations/local-api.md), [local database operations](docs/operations/local-database.md), and [local vision operations](docs/operations/local-vision.md).

## Root commands

| Command | Purpose |
|---|---|
| `make doctor` / `make bootstrap` | verify pinned tooling and install locked packages |
| `make lint` / `make test` / `make build` / `make check` | validate the workspace foundations |
| `make db-up` / `make db-verify` / `make db-down` | operate the synthetic spatial database |
| `make api-test` / `make api-run` | test or run the Spring Boot shell |
| `make web-test` / `make web-build` / `make web-run` | test, build, or run the Next.js shell |
| `make vision-lint` / `make vision-test` / `make vision-run` | lint, test, or run the disabled FastAPI contract |

## Monorepo boundary

- `apps/web` — Next.js accessible shell.
- `apps/api` — Spring Boot modular-monolith shell.
- `apps/vision` — FastAPI health/readiness and disabled contract stub.
- `packages/contracts` — reserved for generated/versioned contracts.
- `infra/database` — database image and versioned migrations.

PostgreSQL is the future authoritative business-state store. Workflow, AI, telemetry, vision tooling, and workspace tooling are never business sources of truth.

## Evidence and limitations

- `ARCH-TOOL-001`, `CLONE-001..002`, `ARCH-MOD-001..004`, and `API-SMOKE-001` cover the earlier foundation slices.
- `A11Y-SHELL-001..006` and `WEB-SMOKE-001` cover semantic shell behavior and rendering.
- `API-VISION-001..004` and `ARCH-AUTH-002` cover versioned health, fail-closed readiness, strict refusal, and authorization denial.
- Docker-backed database evidence and manual keyboard/browser checks must be run in their stated environments; neither is inferred from static checks.
- No real, personal, municipal, KLIC, image, model, or unverified third-party data is included.
- No production, compliance, availability, AI, security, privacy, backup, or accessibility-conformance claim is made.
