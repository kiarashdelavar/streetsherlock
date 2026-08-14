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
| Status | Implementation ready; first GitHub CI execution pending |
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
| CI-002 | Backend test job | Maven verification passes | Configured; GitHub run pending |
| CI-003 | Web lint, test and build | All frontend checks pass | Configured; GitHub run pending |
| CI-004 | Vision lint and tests | Ruff and Pytest pass | Configured; GitHub run pending |
| CI-005 | Migration from an empty database | All migrations apply successfully | Configured; GitHub run pending |
| CI-006 | OpenAPI contract-drift check | Generated types match the reviewed contract | Configured; GitHub run pending |
| CI-007 | Database cleanup | Containers and volumes are removed after every run | Configured |
| CI-008 | Concurrency handling | Older duplicate runs are cancelled | Configured |
| CI-009 | Job timeout policy | Every job has a defined timeout | Configured |
| CI-010 | Compose validation | Docker Compose configuration is valid | Configured |
| CI-011 | Complete clean-clone execution | All CI jobs pass from a clean checkout | Pending first PR run |
| CI-012 | Required-check merge protection | Failed required checks prevent merging | Pending repository configuration |
| SEC-SUPPLY-001 | Action pinning | Every external Action uses a full commit SHA | Passed locally |
| SEC-SUPPLY-002 | Dependency review | New high-severity dependencies block the PR | Configured; GitHub run pending |
| SEC-SUPPLY-003 | Filesystem security scan | Vulnerabilities, secrets and misconfiguration are scanned | Configured; GitHub run pending |
| SEC-SUPPLY-004 | Blocking severity policy | High and critical findings return a failed result | Configured; GitHub run pending |

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

The E01-09 CI foundation is implemented and its local static policy checks
pass.

The implementation remains **in progress** until:

- the branch is pushed;
- the pull request workflow completes;
- failures are investigated and resolved;
- the final commit and GitHub Actions run are recorded;
- required-check protection is configured or documented as pending;
- the pull request is reviewed and merged.