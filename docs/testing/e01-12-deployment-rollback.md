# E01-12 deployment, rollback and environment evidence

| Field | Value |
|---|---|
| Issue | [E01-12 #42](https://github.com/kiarashdelavar/streetsherlock/issues/42) |
| Branch | `agent/e01-12-deployment-rollback-skeletons` |
| Environment | Local/CI/optional Preview/Demo synthetic skeletons |
| Fixture | `FIX-SYN-DEV-001` v1.0.0 |
| Evidence state | Pending pull-request CI and any separately authorized live smoke |

## Automated evidence

| Evidence | Verification |
|---|---|
| `ARCH-ENV-001` | Local, CI, Preview and Demo have explicit non-promotable boundaries |
| `OPS-DEP-001` | only authorized targets have repository-safe plans |
| `OPS-DEP-002` | real data and external side effects remain disabled |
| `OPS-DEP-003` | release manifests require commit, fixture, migration and image digests |
| `OPS-DEP-004` | smoke command checks web, liveness and anonymous denial when a reviewed URL is supplied |
| `OPS-RB-001` | cross-environment rollback is refused |
| `OPS-RB-002` | non-synthetic rollback planning is refused |
| `OPS-RB-003` | migration reversal is refused and routed to forward-fix |
| `OPS-RB-004` | application-only target must differ and retain schema compatibility |

CI executes `scripts/test-deployment-contract.sh`. This validates configuration,
negative paths and the smoke command contract; it does not claim that a hosted
Preview or Demo exists.

## Limitations

- No automatic deployment, registry publication or environment mutation exists.
- No customer, Shadow Pilot or Production environment is authorized.
- Live smoke evidence remains pending until a separately reviewed endpoint exists.
- Backup restore, customer RPO/RTO, provider region, TLS edge, secret manager and
  independent platform/security/privacy review remain open.
