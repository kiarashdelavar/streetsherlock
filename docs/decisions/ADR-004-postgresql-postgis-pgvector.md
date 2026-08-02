# ADR-004 — Use PostgreSQL as System of Record with PostGIS and pgvector

## Document control

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering / Data |
| Target review | 3 August 2026 |
| Scope | Transactional business data, spatial queries and semantic candidate retrieval |
| Depends on | Approved domain ERD and data-flow baseline |

## Context

StreetSherlock needs reliable transactions and history across Reports, Incidents, links, assessments, human decisions, audit and notification intents. It also needs spatial filtering and optional semantic similarity for duplicate candidates. Separate operational, GIS and vector databases would add synchronization and recovery problems before scale requires them.

Binary originals and PDFs have different storage/access requirements and are covered by ADR-007.

## Decision

Use PostgreSQL as the only authoritative business-state store.

Enable:

- PostGIS for geometries, distance, intersection, buffers, nearest-object and bounding-box queries;
- pgvector for versioned report/incident embeddings used in candidate retrieval;
- Flyway for every schema/extension/seed change;
- database constraints, foreign keys, optimistic version fields and transactional outbox tables.

Spatial/time/municipality/category filters constrain candidate retrieval before any final ranking. A vector result is evidence only and never merges Reports.

Use JPA for routine transactional work and explicit SQL/jOOQ where advanced PostGIS/pgvector behavior is clearer.

## Options considered

| Option | Result | Reason |
|---|---|---|
| PostgreSQL + extensions | Selected | One transactional recovery boundary with mature GIS/vector support |
| PostgreSQL plus separate vector DB | Rejected initially | Adds synchronization, backup and consistency work without measured need |
| Document database | Rejected | Weaker fit for relational integrity, audit and spatial transactional rules |
| Dedicated GIS platform as source of truth | Rejected | StreetSherlock business state must remain independent and portable |
| In-memory/demo data | Rejected | Cannot prove migrations, transactions, recovery or realistic queries |

## Consequences

### Positive

- Atomic Report/Incident/audit/outbox operations.
- One migration and backup/restore boundary for business data.
- Spatial and semantic retrieval can be tested against the real engine.
- Simpler local and CI environment.

### Costs and risks

- Extensions constrain available hosting products.
- Vector indexes and spatial queries require tuning and specialist knowledge.
- Database can become overloaded by analytics or poorly bounded searches.
- Backup/restore must preserve extensions and schema compatibility.

## Mandatory controls

1. Every table that carries municipal context includes the approved scope key.
2. Geometry type and SRID are explicit; coordinate conversion is tested.
3. Embeddings store model/version/dimension and are rebuildable from approved minimized text.
4. Vector and spatial scores never become official decisions.
5. Queries have municipality, status, time and category bounds where applicable.
6. Flyway migrations are append-only after application.
7. Backups are encrypted/access-controlled and restore-tested.
8. Media bytes, secrets and log payloads are not stored as convenience fields.

## Verification evidence

- Migration from empty and previous release snapshot.
- Testcontainers with the same major PostgreSQL/PostGIS/pgvector versions.
- Repository tests for radius, intersection, nearest, bounding box and vector retrieval.
- Concurrency test preventing lost human decisions.
- Transaction test covering business change, audit and outbox.
- Restore exercise with row, geometry, extension and audit checks.

## Reconsider when

- approved hosting cannot support maintained extension versions;
- measured vector/search scale needs independent infrastructure;
- legal/operational rules require stronger physical separation;
- analytics workloads threaten transactional SLOs.

## Not authorized by this ADR

No production database, cloud vendor, retention period, real dataset or tenant-isolation claim is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Pending | — | Proposed system-of-record direction |
| Data/security/operations reviewers | Unassigned | Pending | — | Required before deployment or real data |
