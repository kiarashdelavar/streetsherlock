# ADR-006 — Keep n8n at the Delivery-Automation Boundary

## Document control

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering / Operations |
| Target review | 3 August 2026 |
| Scope | Notifications and later approved contractor/workflow delivery |
| Depends on | ADR-001, ADR-008 and ADR-009 |

## Context

n8n can demonstrate realistic workflow automation, provider integration and retries. It is not suitable as the authoritative store for Incidents, inspections, warranty cases or human decisions. If it owns business state, callback duplication, editing through the UI and partial failures can produce inconsistent or invisible outcomes.

External delivery must be retryable without sending duplicates or pretending success.

## Decision

Use n8n only to execute backend-owned delivery intents.

The Java backend writes an outbox record in the same transaction as the authorized domain action. A dispatcher sends a signed, versioned event with an idempotency key and minimal payload. n8n may retrieve approved delivery metadata, call a permitted provider, and post a signed status callback.

The callback updates a delivery/workflow attempt only through a validated backend API. It cannot directly change Incident, inspection, repair, warranty, priority or liability state.

Workflow JSON is versioned in Git. Credentials remain outside Git. Mailpit is the default safe local email sink.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Backend outbox + n8n delivery worker | Selected | Demonstrates automation while preserving transactions and recovery |
| n8n owns workflow/business state | Rejected | Weak authority, audit, concurrency and migration guarantees |
| Backend implements every provider call | Deferred | Simpler authority but less flexible for approved delivery orchestration |
| Managed queue/workflow platform | Deferred | Adds service/cost/hosting decisions not needed for the MVP |
| No automation | Valid safe fallback | Manual recovery must remain possible |

## Consequences

### Positive

- Business state remains transactional and auditable.
- Workflows are visible, versioned and replaceable.
- Delivery retry can be demonstrated safely.
- Provider credentials are isolated from domain code.

### Costs and risks

- Requires signed webhook/callback and replay protection.
- Two attempt histories must correlate without contradicting each other.
- Workflow edits outside Git can drift.
- n8n availability and secret management add operations work.

## Mandatory controls

1. Transactional outbox is the source of delivery intent.
2. Every event has ID, schema version, correlation ID and idempotency key.
3. Sign requests/callbacks; reject expired/replayed/unknown executions.
4. Minimize payloads and never include restricted originals or unnecessary contact data.
5. Callback endpoints use an allowlisted state machine for delivery attempts.
6. Duplicate callbacks return the existing result safely.
7. Retries have limits, backoff and a visible dead-letter/manual path.
8. Export/version workflows and test deployed hashes/versions.
9. n8n credentials and execution logs follow retention/scrubbing rules.

## Verification evidence

- Integration test for outbox atomicity.
- Duplicate event and duplicate callback tests.
- Forged, expired and replayed callback tests.
- n8n outage test showing pending intent and manual recovery.
- Mailpit test proving one approved message despite retries.
- Contract test for event/callback versions.
- Trace showing one correlation ID across backend, n8n and provider attempt.

## Reconsider when

- n8n cannot meet approved hosting/security/data-location controls;
- workflow needs are simple enough that the operational cost is unjustified;
- volume/SLO demands a dedicated queue/orchestrator;
- callbacks would require n8n to become business-state authority.

## Not authorized by this ADR

No real citizen/contractor delivery, SMTP provider, live credentials, schedule, production n8n or domain write-back is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Pending | — | Boundary only |
| Security/privacy/operations reviewers | Unassigned | Pending | — | Required before external delivery |
