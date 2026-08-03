# Non-Functional Requirements

| Field | Value |
|---|---|
| Document ID | OPS-NFR-001 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar, Product Owner |
| Approval | Pending |
| Scope | Sprint 0 quality baseline for StreetSherlock |
| Controls | Master Project Specification §§19, 20, 36, 39, 43–45 |
| Related | SEC-TM-001, PRIV-DC-001, ADR-001–ADR-010 |

## 1. Purpose and claim boundary

This document turns quality goals into measurable implementation and verification obligations. Values are portfolio-demo hypotheses unless an approved customer context replaces them. They do not establish production readiness, 24/7 availability, GDPR/BIO2/WCAG compliance, or customer service levels.

The initial implementation scope is Local, CI, and Demo with synthetic fixtures and approved public snapshots. Preview is optional. Shadow Pilot and Production are design targets only.

## 2. Measurement rules

- A requirement is not verified without dated evidence naming environment, build, dataset/fixture, method and result.
- Measurements exclude warm-up or external calls only where the requirement says so; exclusions must be reported.
- A passed synthetic test does not predict customer-scale performance.
- Failed or missing evidence leaves the requirement Planned or Unverified.
- Security, privacy, authorization, audit, human authority and recovery controls cannot be traded away to meet latency.
- Owners below identify delivery responsibility, not independent approval.

Status values: Planned, Measured, Verified, Failed, Deferred, Blocked.

## 3. Reliability and integrity

| ID | Requirement | Initial target / invariant | Evidence | Owner | Status |
|---|---|---|---|---|---|
| NFR-REL-01 | Valid public submissions persist once | 99% in a controlled test; no acknowledged lost report | fault-injection acceptance test | Backend/QA | Planned |
| NFR-REL-02 | Retryable commands are idempotent | one authoritative result for repeated key/payload | duplicate/replay tests | Backend/QA | Planned |
| NFR-REL-03 | Source/API outage preserves intake | report retained; context marked stale/unknown | adapter-outage fixture | Backend/Data | Planned |
| NFR-REL-04 | AI/CV failure preserves human handling | no invented decision; visible manual path | timeout/malformed/unavailable tests | AI/QA | Planned |
| NFR-REL-05 | n8n retry cannot duplicate final delivery | one final delivery per approved intent | outbox/callback retry fixture | Backend/Platform | Planned |
| NFR-REL-06 | Official transitions are atomic with audit/outbox evidence | 100% critical-path test coverage | transaction rollback tests | Backend/QA | Planned |
| NFR-REL-07 | Concurrent official edits do not silently overwrite | stale version rejected; deliberate reload | optimistic-lock tests | Backend/QA | Planned |
| NFR-REL-08 | Object failure never creates false publication success | explicit pending/failed state | object-store outage test | Backend/Platform | Planned |
| NFR-REL-09 | Schema migration is explicit and repeatable | empty DB and upgrade path tested | migration CI evidence | Backend/Platform | Planned |
| NFR-REL-10 | Business state has one authority | PostgreSQL only; no n8n/Sentry/AI authority | architecture and negative tests | Architecture | Planned |

## 4. Performance and capacity

| ID | Workload | Hypothesis | Measurement profile | Status |
|---|---|---|---|---|
| NFR-PERF-01 | Normal CRUD/list API | p95 < 500 ms | seeded dataset; excludes AI/external calls | Planned |
| NFR-PERF-02 | Map bounding-box query | p95 < 1 s | chosen approved historical snapshot; bounded viewport | Planned |
| NFR-PERF-03 | Duplicate candidates | first useful candidates < 3 s | embeddings precomputed; controlled profile | Planned |
| NFR-PERF-04 | Long AI/CV work | progress/status visible and bounded timeout | slow/unavailable provider fixtures | Planned |
| NFR-PERF-05 | Public web experience | measured Core Web Vitals on declared mobile/desktop profiles | repeatable browser audit | Planned |
| NFR-PERF-06 | List/map endpoints | bounded query, pagination and hard limits | abuse/load test | Planned |
| NFR-PERF-07 | Upload path | byte, count, dimension, pixel and decompression limits enforced before expensive work | malicious corpus | Planned |

Capacity limits must be derived from measured demo infrastructure. No municipality-scale or concurrent-user claim is allowed without a declared dataset and load profile.

## 5. Security, privacy and authorization

| ID | Invariant / target | Evidence obligation | Status |
|---|---|---|---|
| NFR-SEC-01 | Deny by default; server-side role, entity and purpose checks | authorization/IDOR matrix | Planned |
| NFR-SEC-02 | Restricted originals never resolve through public paths | negative route/signed-URL tests | Planned |
| NFR-SEC-03 | Secrets and public configuration are separated | secret scan and startup validation | Planned |
| NFR-SEC-04 | Uploads fail closed under uncertainty | parser/quarantine test suite | Planned |
| NFR-SEC-05 | External callbacks are authenticated, fresh and replay-safe | forgery/replay tests | Planned |
| NFR-SEC-06 | Raw content, contact data, tokens, auth headers, sensitive coordinates and media URLs do not enter telemetry | canary/scrubbing tests | Planned |
| NFR-PRIV-01 | Originals and public derivatives are separate objects and decisions | privacy-publication tests | Planned |
| NFR-PRIV-02 | Contact information is absent from contractor/public projections | schema and authorization tests | Planned |
| NFR-PRIV-03 | AI receives the minimum safe representation | adapter contract tests | Planned |
| NFR-PRIV-04 | Retention/deletion is class-specific and auditable | policy decision plus lifecycle tests | Blocked |
| NFR-PRIV-05 | Restore respects prior deletion through documented re-deletion | restore exercise | Planned |

Blocked means municipal privacy/legal decisions are required; it does not authorize a guessed default.

## 6. Accessibility and usability

| ID | Requirement | Evidence | Status |
|---|---|---|---|
| NFR-A11Y-01 | Core citizen and staff flows work by keyboard with visible focus | manual + automated checks | Planned |
| NFR-A11Y-02 | Map information has equivalent list/table access with preserved filters | journey acceptance test | Planned |
| NFR-A11Y-03 | Status, error, retry and asynchronous completion are programmatically announced | screen-reader/manual test | Planned |
| NFR-A11Y-04 | Meaning never depends on colour alone; targets and contrast meet declared criteria | design/system audit | Planned |
| NFR-A11Y-05 | Critical public flow remains usable at 360 px and zoom | responsive test matrix | Planned |
| NFR-A11Y-06 | Dutch/English labels use plain language and preserve domain meaning | content review | Planned |

Targets guide implementation; only independent evidence may support a conformance claim.

## 7. Maintainability and testability

| ID | Requirement | Evidence | Status |
|---|---|---|---|
| NFR-MAIN-01 | Modular boundaries have architecture tests | dependency-rule tests | Planned |
| NFR-MAIN-02 | OpenAPI client is generated and drift-checked | CI contract check | Planned |
| NFR-MAIN-03 | Business rules are not duplicated in UI or n8n | code/contract review | Planned |
| NFR-MAIN-04 | Migrations run from empty DB and supported prior state | CI migration test | Planned |
| NFR-MAIN-05 | Dependency versions and actions are locked/pinned intentionally | lockfile/SBOM scan | Planned |
| NFR-MAIN-06 | Every requirement/test/evidence item has a stable trace | traceability report | Planned |
| NFR-MAIN-07 | External systems are behind replaceable adapters with offline fixtures | contract tests | Planned |

## 8. Portability and configuration

| ID | Requirement | Evidence | Status |
|---|---|---|---|
| NFR-PORT-01 | Clean clone can start the Local demo with documented prerequisites | clean-clone test | Planned |
| NFR-PORT-02 | CI and tests require no live source API | network-disabled test | Planned |
| NFR-PORT-03 | Typed configuration fails startup on missing/invalid required values | config tests | Planned |
| NFR-PORT-04 | .env.example contains names and safe examples only | secret/config review | Planned |
| NFR-PORT-05 | Domain policy is versioned data, not environment variables | schema/config review | Planned |
| NFR-PORT-06 | Feature flags cannot bypass safety, privacy, authorization, audit or approval | negative tests | Planned |

## 9. Recoverability and operability

| ID | Requirement | Evidence | Status |
|---|---|---|---|
| NFR-REC-01 | Backup artefacts are encrypted, access-separated and environment-bound | config review + restore test | Planned |
| NFR-REC-02 | Restore order and verification are documented | isolated exercise | Planned |
| NFR-REC-03 | A wrong-environment restore aborts before mutation | negative restore test | Planned |
| NFR-REC-04 | Backup expiry and re-deletion after restore are supported | lifecycle exercise | Blocked |
| NFR-OPS-01 | Health distinguishes liveness, readiness and dependency degradation | endpoint tests | Planned |
| NFR-OPS-02 | Structured logs use correlation IDs and allowlisted fields | telemetry tests | Planned |
| NFR-OPS-03 | Critical failures have safe-degradation/runbook ownership | tabletop and runbook review | Planned |
| NFR-OPS-04 | Release/rollback preserves schema and domain invariants | deployment exercise | Planned |

## 10. Quality gates

### Sprint 1 entry

- IDs are referenced by applicable issues.
- Critical exposed capabilities inherit threat, privacy and recovery acceptance criteria.
- Unresolved customer values remain explicit.

### Feature merge

- Applicable NFR evidence runs or the PR records a justified open gap.
- No regression weakens human authority, privacy, authorization, audit or recovery.

### Portfolio release

- Measured performance profile is published.
- Clean-clone, resilience and restore exercises are executed.
- Known limitations and failed objectives remain visible.

### Shadow pilot or production

Requires separate customer-approved SLOs, capacity, identity, hosting, retention, support, incident, RPO/RTO and independent assurance. This document cannot grant that approval.

## 11. Open decisions

| ID | Decision required | Owner/reviewer |
|---|---|---|
| OD-NFR-01 | Customer availability/support hours and maintenance windows | Municipality + operations |
| OD-NFR-02 | Customer RPO/RTO and backup retention | Municipality + platform + privacy |
| OD-NFR-03 | Expected volume, geography and concurrency | Municipality + product |
| OD-NFR-04 | Accessibility conformance evidence and reviewer | Accessibility specialist |
| OD-NFR-05 | Hosting region/network/identity constraints | Municipality + security/platform |
| OD-NFR-06 | Telemetry processors, region and retention | Privacy + platform |
| OD-NFR-07 | Operational ownership and escalation rota | Municipality + supplier |

## 12. Approval record

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Pending | — | Sprint 0 NFR structure and hypotheses |
| Platform/SRE reviewer | Pending | — | Operability, capacity and recovery |
| Security reviewer | Pending | — | Security requirements |
| Privacy officer / FG | Pending | — | Personal-data lifecycle |
| Accessibility reviewer | Pending | — | Accessibility targets |
| Municipal owner | Pending | — | Customer service levels and risk acceptance |
