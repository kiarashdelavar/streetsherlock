# StreetSherlock Architecture Decision Register

## Document control

| Field | Value |
|---|---|
| Requirement | S0-ARCH-02 |
| Owner | Kiarash Delavar, Engineering / Product Owner |
| Version | 0.1 |
| Status | Proposed |
| Last updated | 2 August 2026 |
| Target decision review | 3 August 2026 |
| Controlled baseline | Master Project Specification v2.0 and approved S0-ARCH-01 diagrams |
| Scope | Portfolio demo and engineering MVP |

## Purpose

This register controls the ten architecture decisions required before StreetSherlock application scaffolding may begin. It records what is proposed, why it fits the product boundary, how it will be verified, and which facts would force reconsideration.

Approval of an ADR authorizes the stated engineering direction only. It does not authorize real municipal data, live system write-back, citizen notifications, contractor decisions, a pilot, production deployment, or a compliance claim.

## Decision register

| ID | Decision | Status | Owner | Target review | Key dependency |
|---|---|---|---|---|---|
| ADR-001 | Modular monolith for the main backend | Proposed | Engineering | 3 Aug 2026 | Approved container diagram |
| ADR-002 | Java 21 and pinned Spring Boot 4.1.x line | Proposed | Engineering | 3 Aug 2026 | ADR-001 |
| ADR-003 | Stateless Python/FastAPI vision boundary | Proposed | Engineering / AI-data | 3 Aug 2026 | ADR-001, later InfraProof scope |
| ADR-004 | PostgreSQL with PostGIS and pgvector | Proposed | Engineering / Data | 3 Aug 2026 | Domain ERD |
| ADR-005 | Local AI behind a replaceable provider interface | Proposed | Engineering / AI-data | 3 Aug 2026 | Privacy flow, ADR-004 |
| ADR-006 | n8n limited to delivery automation | Proposed | Engineering / Operations | 3 Aug 2026 | Transactional outbox design |
| ADR-007 | S3-compatible object storage with classified media zones | Proposed | Engineering / Privacy / Security | 3 Aug 2026 | Data-flow baseline |
| ADR-008 | Human authority for every official decision | Proposed | Product / Domain | 3 Aug 2026 | Charter, glossary, state machines |
| ADR-009 | Versioned APIs/events, idempotency, and optimistic concurrency | Proposed | Engineering | 3 Aug 2026 | ADR-001, ADR-004 |
| ADR-010 | Single-tenant engineering MVP | Proposed | Product / Engineering / Security | 3 Aug 2026 | Synthetic demo boundary |

## Cross-decision invariants

1. PostgreSQL is the only authoritative business-state store.
2. Each Report remains preserved even when linked to an Incident.
3. AI, computer vision, and duplicate/priority logic produce evidence or recommendations only.
4. An authorized human makes every official municipal, repair, inspection, warranty, liability, and enforcement decision.
5. n8n and external providers cannot write domain state directly.
6. Restricted originals are never public objects; public/derived media is a separate controlled representation.
7. Provider failure preserves the Report and exposes a manual recovery path.
8. Architecture truth consists of accepted ADRs, current diagrams, code, migrations, and executable boundary tests.
9. Deventer data is synthetic; open Dutch data is source-labelled and licence-reviewed.
10. Single-tenant MVP does not imply production-grade tenant isolation.

## Status rules

- **Proposed:** drafted and reviewable; not implementation authority.
- **Accepted:** Product Owner/engineering decision recorded, with specialist gates still visible.
- **Superseded:** replaced by another ADR; history remains.
- **Rejected:** evaluated but not selected.
- **Deprecated:** no longer recommended for new work but retained for history.

No ADR may be silently changed from Accepted. A material change requires a superseding ADR or a dated amendment that explains the compatibility and migration impact.

## Review gates still outside this package

- municipal domain validation;
- privacy/lawful-basis, retention, data-subject and processor review;
- security/threat-model and deployment-boundary review;
- accessibility review;
- source/model/licence review;
- operations, backup/restore and incident-response review;
- pilot procurement, identity, hosting and network approval.

## Acceptance checklist

- [x] Exactly ten stable ADR IDs are reserved.
- [x] Each ADR contains context, alternatives, consequences, controls, verification and reversal triggers.
- [x] Decisions align with the approved product/domain and architecture baselines.
- [x] No application service, database, infrastructure or runtime is scaffolded.
- [ ] Product Owner decision recorded before merge.
- [ ] Issue #16 acceptance checklist completed.
