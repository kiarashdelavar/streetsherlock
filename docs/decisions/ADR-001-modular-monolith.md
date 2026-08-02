# ADR-001 — Use a Modular Monolith for the Main Backend

## Document control

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering |
| Target review | 3 August 2026 |
| Scope | StreetPulse MVP and shared InfraProof domain backend |
| Depends on | Approved container, domain ERD and state-machine baselines |

## Context

StreetSherlock has coupled transactional rules across Reports, Incidents, assessments, human decisions, audit, media metadata and notification intents. It is currently delivered by one developer and must prove one reliable vertical slice before scaling organizational boundaries.

Independent microservices would add distributed transactions, event consistency, deployment, authentication, observability and recovery work before there is evidence that those costs solve a real scaling or ownership problem. A single unstructured monolith would be simpler initially but would allow domain rules and persistence access to spread without enforceable boundaries.

The Python vision runtime is materially different and is handled separately by ADR-003.

## Decision

Use one Java/Spring Boot **modular monolith** as the authoritative business backend.

Modules own their domain model, application services and persistence boundary. Cross-module access occurs through explicit application services or versioned domain events—not by importing another module's repositories or modifying its tables directly.

Initial module groups are:

- foundation: identity, municipalities and audit;
- StreetPulse: reports, privacy, incidents, assessments, duplicates, priority and media;
- later InfraProof: assets, streetworks, repairs, inspections and warranties;
- boundaries: AI, integrations, workflows, notifications and analytics.

Use Spring Modulith and/or ArchUnit tests where they materially enforce dependency rules. In-process domain events do not create a second source of truth; transactional state remains in PostgreSQL.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Modular monolith | Selected | Strong transactions, explicit boundaries, simple solo delivery and clean future extraction points |
| Layered unstructured monolith | Rejected | Lower setup cost but weak domain ownership and high coupling risk |
| Microservices from Sprint 1 | Rejected | Operational/distributed complexity without measured scaling or team-ownership need |
| Serverless functions per capability | Rejected | Fragmented transactions, contracts and local reproducibility for the core workflow |

## Consequences

### Positive

- One deployable business service and one transaction boundary.
- Easier clean-clone, integration testing, migrations and local debugging.
- Domain boundaries remain visible and testable.
- Outbox events can be written atomically with business changes.
- A module can later be extracted using measured evidence.

### Costs and risks

- A defect or resource spike can affect the whole Java process.
- Boundaries can decay without tests and code review.
- Scaling is initially coarse-grained.
- The repository can become large if modules do not own clear contracts.

## Mandatory controls

1. Each module has an explicit public API and dependency direction.
2. Cross-module repository access is forbidden.
3. Module-boundary tests run in CI.
4. No domain rule is implemented in Next.js, n8n or database triggers as a second authority.
5. The transactional outbox is owned by the backend.
6. Python vision remains stateless and cannot own business state.
7. New deployable services require a superseding ADR.

## Verification evidence

- Spring Modulith/ArchUnit dependency test.
- Integration test proving Report-to-Incident changes and audit/outbox records share one transaction.
- Package/module documentation generated or checked in CI.
- Clean-clone startup and migration-from-empty test.
- Failure test showing provider outage does not lose the Report.

## Reconsider when

- independent teams need separate ownership and release cadence;
- one module has measured scaling or isolation requirements;
- deployment frequency, blast radius or compliance boundaries cannot be met in one process;
- an extraction can preserve transactions, idempotency, audit and recovery with a proven contract.

## Not authorized by this ADR

No application scaffolding, cloud deployment, live integration, real data use, multi-tenant claim or production approval.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Pending | — | Proposed direction only |
| Independent architecture reviewer | Unassigned | Pending | — | Self-review is not independent assurance |
