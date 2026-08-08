# Local database foundation

**Scope:** E01-02, synthetic Local/CI use only.

## Start and verify

1. Copy `.env.example` to `.env` and replace the local-only password.
2. Run `make db-up`.
3. Re-run `make db-up` to prove migrations are idempotent.
4. Run `make db-verify` for `DB-MIG-001..004`.

The database binds only to `127.0.0.1`. Flyway validates migration names, retries while PostgreSQL becomes healthy, and has `clean` disabled.

## Stop and reset

- `make db-down` stops services and preserves the named volume.
- `CONFIRM_DATABASE_RESET=streetsherlock-local make db-reset` removes only this Compose project's local volume.

Reset is intentionally explicit and destructive. Never use broad Docker prune commands for this project.

## Evidence contract

| Test | Evidence |
|---|---|
| DB-MIG-001 | PostgreSQL is healthy and reachable inside Compose |
| DB-MIG-002 | PostGIS and pgvector extensions exist |
| DB-MIG-003 | both Flyway migrations are successful |
| DB-MIG-004 | a repeated migrate reports no pending migration |
| CLONE-002 | clean-clone commands work or fail with an actionable safe error |

Record commit SHA, environment, commands, expected/actual results, and limitations when executing integration evidence. Static contract evidence does not equal production, backup, performance, privacy, or security approval.
