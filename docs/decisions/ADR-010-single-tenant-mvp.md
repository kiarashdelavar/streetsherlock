# ADR-010 — Build a Single-Tenant Engineering MVP

## Document control

| Field | Value |
|---|---|
| Status | Accepted |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Product / Engineering |
| Decision date | 2 August 2026 |
| Scope | Portfolio demo, local/CI and controlled preview |
| Depends on | Approved synthetic-data and system-context boundaries |

## Context

A production municipal SaaS would need tenant-bound identity, authorization, storage, keys, logs, backups, integrations, operations and verified isolation. Implementing generic multi-tenancy before a municipality, hosting model and identity contract exist would create security-sensitive abstraction work based on guesses.

The portfolio still needs data models and contracts that do not make future municipal scoping impossible.

## Decision

Deliver the first engineering MVP as **single-tenant** with one configured synthetic municipality context.

The synthetic Deventer scenario is demo context only. It does not claim Deventer as customer, validator or pilot.

Preserve an explicit `municipality_id` (or equivalent approved scope identifier) in business records, events, cache keys and object metadata where future scope matters. In MVP, the backend derives the allowed municipality context from controlled configuration/identity—not from an untrusted client field.

Do not market row keys as production tenant isolation. Before any multi-municipality or real-data tier, create a superseding ADR covering identity mapping, authorization, storage/object paths, encryption/key strategy, query enforcement, backups/restores, telemetry, support and isolation tests.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Single-tenant MVP with future scope key | Selected | Honest, deliverable and avoids unvalidated security architecture |
| Full shared-schema multi-tenancy now | Rejected | High isolation risk without real identity/hosting requirements |
| Database per municipality now | Deferred | Operational cost and provisioning assumptions are unknown |
| Separate deployment per municipality | Deferred | May fit later procurement/security needs but is not yet validated |
| No municipality scope field | Rejected | Creates avoidable migration/traceability problems |

## Consequences

### Positive

- Smaller authorization and operations surface for the first vertical slice.
- Honest scope and fewer false production claims.
- Future municipality context remains traceable.
- Clean synthetic fixtures are easier to test.

### Costs and risks

- MVP cannot safely host multiple municipalities.
- Some future isolation changes may require migrations.
- Developers may mistake scope keys for complete security.
- Portfolio wording must repeat the limitation.

## Mandatory controls

1. Only synthetic/approved fixture data in current tier.
2. Server derives the active scope; clients cannot select arbitrary municipality IDs.
3. Repositories/commands still require explicit scope to prevent future accidental global queries.
4. Object keys, events and audit records carry approved scope context.
5. Admin/demo shortcuts cannot be reused as pilot authentication.
6. Tests deny cross-scope IDs even in fixtures where practical.
7. UI/docs label the environment synthetic and single-tenant.
8. No real integration credentials or live write-back.

## Verification evidence

- Seeded single synthetic municipality and roles.
- Negative tests for an unknown/different municipality identifier.
- Repository/query review for explicit scope.
- Object/event/audit examples carrying the same context.
- Documentation/marketing scan for production or customer overclaims.
- Clean-clone test with no real credentials or data.

## Reconsider when

- a verified pilot or second municipality is approved;
- identity/hosting/procurement rules are known;
- data residency or isolation demands separate databases/deployments;
- support/backup/restore boundaries require tenant-specific operations.

## Not authorized by this ADR

No multi-tenancy, customer relationship, real municipal data, production isolation, hosting or pilot is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Accepted | 2 August 2026 | Engineering direction approved; implementation and external assurance remain gated |
| Municipal/security/privacy/operations reviewers | Unassigned | Pending | — | Required before any real or multi-municipality tier |
