# Deployment and rollback skeleton operations

This document covers Local, CI, optional Preview and Demo planning only. It does
not authorize or deploy a customer, Shadow Pilot or Production environment.

## Plan an authorized environment

```bash
bash scripts/deployment.sh plan local
bash scripts/deployment.sh plan ci
bash scripts/deployment.sh plan preview
bash scripts/deployment.sh plan demo
```

The planner validates explicit environment identity, synthetic-only data,
disabled external side effects and repository-safe configuration. The Preview
plan also validates the locked-down Compose configuration without pulling or
starting images.

These commands must refuse:

```bash
bash scripts/deployment.sh plan shadow-pilot
bash scripts/deployment.sh plan production
```

## Release manifest

Copy the example, then replace the release ID, reviewed 40-character source
commit and image references with immutable registry digests:

```bash
cp deploy/release-manifest.example.json deploy/release-manifest.local.json
bash scripts/deployment.sh validate-manifest deploy/release-manifest.local.json
```

Do not commit the populated local manifest when it reveals private registry or
environment information. A reviewed release record must identify the fixture,
migration version, exact source and exact images.

## Secret handling

Repository files contain names and synthetic placeholders only. Database
credentials, OIDC endpoints, short-lived demo tokens and registry credentials
must come from the selected environment's managed secret store.

Never place secrets in Git, `.env.example`, PR text, screenshots, command
history, logs, telemetry, fixtures or release evidence.

## Preview option

`deploy/preview.compose.yaml` is an optional configuration skeleton. It:

- accepts only digest-pinned API and web images;
- never builds or pulls code automatically;
- binds preview ports to loopback by default;
- uses read-only filesystems, dropped capabilities and no-new-privileges;
- requires managed database, identity and short-lived synthetic token values;
- has no database migration or external side-effect service.

Actual preview hosting, access control, TLS, region and secret manager remain
open platform/security/privacy decisions.

## Smoke checks

After a separately reviewed Preview or Demo deployment:

```bash
bash scripts/deployment.sh smoke \
  https://reviewed-web.example \
  https://reviewed-api.example
```

The smoke command checks the web page, API liveness and anonymous 401 denial.
It does not test production readiness, load, backup recovery or accessibility
conformance.

## Rollback and forward-fix

Create current and target manifests, then produce a read-only plan:

```bash
bash scripts/deployment.sh rollback-plan current.json target.json
```

Rules:

1. Cross-environment rollback is refused.
2. Only synthetic Preview/Demo planning is authorized.
3. Database migrations are forward-only. A migration-version difference requires
   a new reviewed forward-fix migration.
4. Application images may roll back only when the migration version is identical
   and compatibility was reviewed.
5. The operator deploys exact digests, runs smoke checks and preserves evidence.
6. No command in this Sprint 1 skeleton mutates a deployment.

If a release fails before migration, keep the existing environment unchanged.
If it fails after migration, preserve the database and create a forward-fix or
deploy a schema-compatible application digest. Never run Flyway clean or delete
volumes as a deployment rollback.
