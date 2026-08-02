# ADR-009 — Version APIs and Events with Idempotent Commands

## Document control

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering |
| Target review | 3 August 2026 |
| Scope | Browser/backend, adapters, FastAPI and n8n contracts |
| Depends on | ADR-001, ADR-004, ADR-006 and state machines |

## Context

StreetSherlock crosses TypeScript, Java, Python, n8n and external adapter boundaries. Retries, stale clients and schema evolution can duplicate commands or corrupt interpretations. Manual prose cannot be the executable contract. Human decisions also require concurrency protection so one reviewer cannot silently overwrite another.

## Decision

Use:

- resource HTTP APIs under `/api/v1` and internal vision APIs under `/internal/v1`;
- OpenAPI 3.1 as the generated HTTP contract;
- JSON Schema for outbox/integration events;
- a standard event envelope with `event_id`, `event_type`, `schema_version`, `occurred_at`, `correlation_id`, `municipality_id` and a minimal payload;
- idempotency keys for retryable commands, imports and callbacks;
- optimistic version fields/ETags for human-edited aggregates;
- RFC 9457-style problem details for safe errors;
- explicit pagination, time, coordinate/reference-system and enum conventions.

Additive compatible fields remain within a major version when consumers ignore unknown fields safely. Breaking semantic/removal changes require a new major contract and migration/deprecation plan. Persisted events are never edited in place.

## Options considered

| Option | Result | Reason |
|---|---|---|
| OpenAPI/JSON Schema with explicit major versions | Selected | Executable cross-language contract and controlled evolution |
| Unversioned REST/JSON | Rejected | Silent breaking changes and weak auditability |
| GraphQL everywhere | Rejected for initial scope | Adds schema/runtime complexity without solving event/callback needs |
| Shared code models only | Rejected | Cannot govern n8n/external consumers and can hide wire changes |
| Broker-specific event schema | Deferred | No broker is approved for Sprint 1 |

## Consequences

### Positive

- Generated client reduces frontend/backend drift.
- Events and callbacks can be validated/replayed safely.
- Idempotency and optimistic locking make retries/concurrency explicit.
- Contract changes have reviewable diffs.

### Costs and risks

- Schema maintenance and compatibility tests add work.
- Poorly designed “optional” fields can still create semantic breaks.
- Idempotency records require retention/cleanup policy.
- Multiple major versions may temporarily coexist.

## Mandatory controls

1. Generate/check OpenAPI and TypeScript client in CI.
2. Validate events at producer and consumer.
3. Store producer/schema version and processing outcome.
4. Reject unsupported major versions safely; tolerate documented compatible fields.
5. Require idempotency keys for retryable external commands.
6. Scope idempotency to actor/operation/resource and prevent payload mismatch reuse.
7. Use optimistic concurrency on human decision aggregates.
8. Preserve correlation/causation identifiers without PII.
9. Document deprecation and replay behavior before production tiers.

## Verification evidence

- Contract tests across Java/TypeScript/Python.
- CI drift check for generated client/schema.
- Same-key/same-payload retry returns existing result.
- Same-key/different-payload retry is rejected.
- Stale aggregate update returns conflict and preserves both reviewers' evidence.
- Unsupported major event is quarantined/failed visibly.
- Callback replay produces no duplicate delivery or domain transition.

## Reconsider when

- approved consumers require another protocol;
- contract volume justifies a registry/broker;
- event retention/replay requirements exceed the database outbox;
- municipal standards require additional headers or schemas.

## Not authorized by this ADR

No public API, SLA, external consumer, broker, write-back contract or production deprecation window is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Pending | — | Contract policy only |
| Integration/security/operations reviewers | Unassigned | Pending | — | Required before live consumers |
