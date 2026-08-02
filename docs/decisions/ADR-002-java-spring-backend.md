# ADR-002 — Use Java 21 and a Pinned Spring Boot 4.1.x Line

## Document control

| Field | Value |
|---|---|
| Status | Accepted |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering |
| Decision date | 2 August 2026 |
| Scope | Authoritative HTTP API and background business processing |
| Depends on | ADR-001 |

## Context

The main backend needs strong validation, authorization, transactions, migrations, OpenAPI contracts, spatial/vector database access, observability and mature test support. The project is also intended to demonstrate market-relevant Dutch enterprise backend engineering.

The version must be reproducible. “Latest” is not an acceptable build input, and exact patch/plugin/container versions must be resolved and locked during Sprint 1 clean-clone work.

## Decision

Use:

- Java 21 LTS as the language/runtime baseline;
- a compatible stable Spring Boot 4.1.x patch, pinned in the build when Sprint 1 begins;
- Spring Security OAuth2 Resource Server for OIDC/JWT verification;
- Bean Validation and RFC 9457-style problem details at the API boundary;
- Spring Data JPA for normal transactional persistence;
- jOOQ or explicit native SQL where PostGIS/pgvector queries are clearer and testable;
- Flyway as schema history;
- springdoc/OpenAPI 3.1 as the generated external contract;
- Testcontainers with real PostgreSQL extensions for integration tests.

Any library that cannot support Java 21/Spring Boot compatibility, maintenance, licensing or reproducible tests must be replaced or separately approved.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Java 21 + Spring Boot | Selected | Mature security/transaction/testing ecosystem and strong portfolio relevance |
| Kotlin + Spring Boot | Deferred | Good fit, but adds language/tooling scope without product benefit for the first release |
| Go | Rejected for main backend | Simple runtime, but less aligned with the approved stack and rich Spring governance/testing controls |
| Node.js backend | Rejected for main backend | Would reduce language count but does not improve the selected enterprise/API boundary |
| Newer Java baseline | Deferred | Reassess only with dependency compatibility and deployment support evidence |

## Consequences

### Positive

- Strong transaction, validation, security and testing support.
- Clear generated API contract for the TypeScript client.
- Good support for modular boundaries and enterprise observability.
- Real database behavior can be tested with Testcontainers.

### Costs and risks

- Larger runtime/build footprint than Go or minimal Node services.
- Framework configuration can obscure behavior without focused tests.
- Major framework-line changes can create migration work.
- ORM use can become inefficient for spatial/vector queries.

## Mandatory controls

1. Pin Java toolchain, Spring Boot patch, plugins and container digests/versions.
2. Generate a dependency lock/BOM strategy and automate controlled updates.
3. Use database constraints and explicit authorization in addition to DTO validation.
4. Keep advanced spatial/vector queries explicit and covered against real extensions.
5. Generate the TypeScript client and fail CI on contract drift.
6. Do not log request bodies, tokens, contact data or restricted media references.
7. Record framework upgrades as dependency decisions with migration evidence.

## Verification evidence

- Clean clone builds with the pinned toolchain.
- Unit, module-boundary and Testcontainers integration tests pass.
- Migration-from-empty succeeds.
- OpenAPI generation is stable and the client has no uncommitted drift.
- Authorization tests cover every protected command.
- Dependency and container scans have reviewed results.

## Reconsider when

- Java 21 leaves vendor/security support for the chosen environments;
- the selected Spring line is incompatible with required maintained dependencies;
- measured performance or memory prevents agreed SLOs after profiling;
- team capability or hosting constraints materially change.

## Not authorized by this ADR

No exact dependency versions are approved until pinned and tested in Sprint 1. No production runtime, hosting provider or compliance claim is selected here.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Accepted | 2 August 2026 | Engineering direction approved; implementation and external assurance remain gated |
| Security/operations reviewer | Unassigned | Pending | — | Required before deployment claims |
