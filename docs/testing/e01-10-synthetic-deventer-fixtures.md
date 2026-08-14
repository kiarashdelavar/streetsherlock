# E01-10 synthetic Deventer fixture evidence

| Field | Value |
|---|---|
| Issue | [E01-10 #40](https://github.com/kiarashdelavar/streetsherlock/issues/40) |
| Pull request | [PR #62](https://github.com/kiarashdelavar/streetsherlock/pull/62) |
| Fixture | `FIX-SYN-DEV-001` |
| Fixture version | `1.0.0` |
| Source ID | `SRC-SYN-DEV` |
| Data SHA-256 | `26b54ced5b0b58d58535d7ae436ea2835fecdaf798b447ce7c7c1a1f878c8f13` |
| Environment | GitHub Actions Ubuntu runner with a clean Docker Compose database |
| Evidence state | Pending the passing PR #62 CI run |

## Scope

E01-10 provides one resettable, deterministic and clearly fictional municipality
fixture. It seeds one municipality, two provenance records, one Report, one Incident
and one explicit Report–Incident link. Report and Incident remain separate records.

The required label is:

> Synthetic Deventer demo data — not a real municipal case

The fixture contains no real citizen, municipal, contractor or restricted data.
Its coordinates describe a fictional test location and are not evidence of a real event,
municipal partnership or production readiness.

## Automated verification

| Evidence | Verification |
|---|---|
| `FIXTURE-001` | versioned manifest and data file exist and agree on identity/version |
| `FIXTURE-002` | required synthetic identity roles and link actor exist in the dev realm |
| `FIXTURE-003` | privacy boundary rejects prohibited contact-data keys and verifies the synthetic label |
| `FIXTURE-004` | deterministic synthetic municipality and provenance persist after clean migration |
| `FIXTURE-005` | Report and Incident persist as distinct UUID records with SRID 4326 |
| `FIXTURE-006` | only the explicit Report–Incident link establishes their relationship |
| `API-SEED-001` | the application database seed is reproducible and queryable after V1–V4 migration |

Run the verifier against a migrated database:

```bash
ENV_FILE=.env.example bash scripts/verify-synthetic-fixture.sh
```

CI runs the same verifier in the `migration-from-empty` job after Flyway migrate,
Flyway validate and the database foundation checks.

## Limitations

- `API-SEED-001` verifies the application seed contract at the database boundary;
  E01-10 does not introduce or claim a public HTTP API endpoint.
- Passing automation does not establish municipal accuracy, legal approval, privacy
  approval, production readiness or acceptance.
- The final evidence state and exact workflow-run link must be updated only after the
  PR run completes successfully.
