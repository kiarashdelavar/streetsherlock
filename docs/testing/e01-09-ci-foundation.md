# E01-09 CI Foundation Evidence

| Field | Value |
|---|---|
| Document ID | TEST-E01-09 |
| Issue | E01-09 / GitHub Issue #39 |
| Sprint | Sprint 1 |
| Requirements | QR-MAIN-001; QR-PORT-001; QR-SEC-001 |
| Evidence IDs | CI-001..012; SEC-SUPPLY-001..004 |
| Environment | Local Windows validation and GitHub-hosted CI |
| Data classification | Synthetic Local/CI configuration only |
| Source commit | `8aedd70ba7f40025c1e7d6d5ee110e0ce1ba3256` |
| GitHub Actions | [CI run #8](https://github.com/kiarashdelavar/streetsherlock/actions/runs/31795376261) |
| Status | GitHub CI passed; merge and required-check protection pending |
| Last updated | 14 August 2026 |

## 1. Purpose

E01-09 introduces a repeatable CI foundation for StreetSherlock.

The workflow checks the backend, frontend, Vision service, OpenAPI contract,
database migrations and supply-chain security before changes are merged.

This document records what has been implemented, what has passed locally and
what still requires evidence from GitHub Actions.

## 2. Implemented CI jobs

The workflow contains separate jobs for:

- repository structure and CI policy checks;
- Spring Boot backend tests;
- Next.js lint, tests and production build;
- OpenAPI generated-client drift detection;
- FastAPI Vision lint and tests;
- migration from an empty PostgreSQL database;
- dependency review for pull requests;
- filesystem vulnerability, secret and configuration scanning.

## 3. CI security controls

The workflow applies the following controls:

- repository permissions are read-only by default;
- third-party GitHub Actions use full commit SHAs;
- `pull_request_target` is forbidden;
- every job has an explicit timeout;
- duplicate workflow runs are cancelled;
- dependency changes with high-severity findings block CI;
- high and critical filesystem findings block CI;
- database resources are removed after success or failure;
- only synthetic Local/CI configuration is used;
- no production secrets or municipal data are included.

## 4. Automated evidence

| Evidence ID | Check | Expected result | Current result |
|---|---|---|---|
| CI-001 | Workflow structure and least-privilege policy | Static policy test passes | Passed locally |
| CI-002 | Backend test job | Maven verification passes | Passed — CI run #8 |
| CI-003 | Web lint, test and build | All frontend checks pass | Passed — CI run #8 |
| CI-004 | Vision lint and tests | Ruff and Pytest pass | Passed — CI run #8 |
| CI-005 | Migration from an empty database | All migrations apply successfully | Passed — CI run #8 |
| CI-006 | OpenAPI contract-drift check | Generated types match the reviewed contract | Passed — CI run #8 |
| CI-007 | Database cleanup | Containers and volumes are removed after every run | Passed — CI run #8 |
| CI-008 | Concurrency handling | Older duplicate runs are cancelled | Observed during branch updates |
| CI-009 | Job timeout policy | Every job has a defined timeout | Passed by policy check — CI run #8 |
| CI-010 | Compose validation | Docker Compose configuration is valid | Passed — CI run #8 |
| CI-011 | Complete clean-clone execution | All CI jobs pass from a clean checkout | Passed — CI run #8 |
| CI-012 | Required-check merge protection | Failed required checks prevent merging | Pending repository configuration |
| SEC-SUPPLY-001 | Action pinning | Every external Action uses a full commit SHA | Passed locally |
| SEC-SUPPLY-002 | Dependency review | High/critical locked dependencies block the PR | Passed — CI run #8 |
| SEC-SUPPLY-003 | Filesystem security scan | Vulnerabilities, secrets and misconfiguration are scanned | Passed — CI run #8 |
| SEC-SUPPLY-004 | Blocking severity policy | High and critical findings return a failed result | Passed — CI run #8 |

## 5. Local validation

The following commands provide repeatable local checks:

```bash
bash scripts/test-structure.sh
bash scripts/test-database-contract.sh
bash scripts/test-ci-contract.sh
```

Expected output includes:

```text
ARCH-TOOL-001: workspace structure passed.
CLONE-002: static database contract and safe-reset refusal passed.
CI-001: workflow structure and least-privilege policy passed.
SEC-SUPPLY-001: action pinning and blocking scan policy passed.
```

The GitHub Actions workflow was also validated locally with
`actionlint 1.7.7`.

## 6. Failure and recovery behaviour

If a CI check fails:

1. The affected job returns a failed result.
2. The pull request must not be treated as verified.
3. The developer reviews the safe CI logs.
4. The problem is fixed on the same feature branch.
5. The workflow is run again.
6. Evidence is updated only after the new run succeeds.

The database job uses an empty database and versioned migrations. Cleanup runs
with `if: always()` so containers and volumes are removed even when migration
or verification fails.

No failed security result may be silently ignored.

## 7. Privacy and authority boundaries

The CI workflow uses synthetic configuration only.

It does not include:

- real citizen reports;
- names, addresses or contact information;
- municipal production data;
- real identity-provider credentials;
- production secrets;
- images or external datasets.

CI, workflow automation, security scanners and infrastructure do not become
the StreetSherlock business source of truth. They do not make official
municipal decisions.

## 8. Limitations

This evidence does not claim:

- production readiness;
- certification or regulatory compliance;
- penetration testing;
- independent security review;
- complete privacy approval;
- availability or recovery guarantees;
- municipal acceptance.

A configured CI job is not recorded as passed until its GitHub Actions run
succeeds for the relevant commit.

Branch protection and required checks must be configured separately after the
workflow names are available in GitHub.

## 9. Current conclusion

The E01-09 CI foundation is implemented. Its local policy checks and all seven
jobs in GitHub Actions CI run #8 passed.

The implementation remains **in progress** until:

- the latest documentation-only commit is checked;
- required-check protection is configured or documented as pending;
- the pull request is reviewed and merged.