# Requirements Catalogue

| Field | Value |
|---|---|
| Document ID | PROD-REQ-001 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar |
| Approval | Pending Product Owner review |
| Scope | StreetPulse Portfolio Demo MVP plus explicitly labelled later-release InfraProof concepts |
| Last updated | 3 August 2026 |

## 1. Purpose and control rules

This catalogue is the controlled statement of what StreetSherlock is expected to do and how each obligation can be accepted. It consolidates the approved product, architecture, source, UX, threat, privacy and operations baselines without claiming implementation.

Rules:

1. A requirement has one stable ID and one primary obligation.
2. **Must** is mandatory for its declared release. **Should** is expected unless a recorded decision removes it. **May** is optional.
3. Product Owner approval accepts the catalogue baseline only. It does not prove implementation, testing, compliance, production readiness or external approval.
4. `Planned` means evidence is not yet present. `Blocked` means an external decision is required. `Later` means outside the StreetPulse MVP.
5. PostgreSQL is the sole authority for business state. AI, CV, n8n, source APIs, telemetry and caches never make official decisions.
6. A municipal employee remains responsible for official classification, assignment, publication, override and closure decisions.
7. Deventer scenarios are synthetic. Real KLIC, citizen and municipal operational data are prohibited until separately authorized.
8. InfraProof inspector, contractor and governance capabilities are later-release concepts unless a requirement explicitly says MVP.
9. Requirement changes use a PR, impact analysis and trace update; IDs are never silently reused.

## 2. Field definitions

| Field | Meaning |
|---|---|
| ID | immutable identifier |
| Release | MVP, Later or Cross-cutting |
| Priority | Must, Should or May |
| Requirement | atomic normative statement |
| Acceptance | observable pass condition |
| Status | Planned, Blocked or Later |
| Owner | accountable delivery role |
| Sources | controlled source document IDs |

## 3. Functional requirements — citizen and public flow

| ID | Release | Priority | Requirement | Acceptance | Status | Owner | Sources |
|---|---|---:|---|---|---|---|---|
| FR-CIT-001 | MVP | Must | The system shall let a citizen submit a public-space report without creating an account. | Valid synthetic report persists and returns a non-sequential tracking capability. | Planned | Product/Backend | UX-SB-001, PRIV-DC-001 |
| FR-CIT-002 | MVP | Must | Intake shall collect category, description and a map or address location. | Required fields validate; map and address paths create the same location contract. | Planned | Product/Frontend | UX-WF-001 |
| FR-CIT-003 | MVP | Must | Intake shall support optional photos under declared count, byte, dimension and format limits. | Safe fixtures succeed; oversized, malformed and decompression-bomb fixtures fail closed. | Planned | Backend/Security | SEC-TM-001, PRIV-DC-001 |
| FR-CIT-004 | MVP | Must | The citizen shall review the report before final submission. | Review shows normalized non-secret values and supports correction. | Planned | Frontend/QA | UX-WF-001 |
| FR-CIT-005 | MVP | Must | Submission shall present a recoverable receipt and tracking path only after authoritative persistence. | Database failure never produces a false success; retry does not duplicate the report. | Planned | Backend/QA | OPS-SLO-001 |
| FR-CIT-006 | MVP | Must | A tracking capability shall reveal only the allowed public status projection. | Invalid, expired, revoked or unrelated tokens reveal no report/contact data. | Planned | Backend/Security | SEC-TM-001, PRIV-DC-001 |
| FR-CIT-007 | MVP | Must | Public report views shall use privacy-safe derivatives and never restricted originals. | Public routes cannot resolve original objects or uncertain derivatives. | Planned | Privacy/Backend | PRIV-DC-001, SEC-TM-001 |
| FR-CIT-008 | MVP | Should | Intake shall offer a recoverable draft when a session or dependency fails. | Synthetic interruption can resume without silently submitting or exposing contact data. | Planned | Frontend | UX-STATE-001 |
| FR-CIT-009 | MVP | Must | The citizen flow shall display explicit permission, upload, offline, timeout and validation recovery states. | Each state has an accessible message, safe retry/cancel path and no lost accepted state. | Planned | Frontend/QA | UX-STATE-001 |
| FR-PUB-001 | MVP | Must | A public map/list shall show only publication-approved records and fields. | Unapproved/restricted fields are absent from API and UI projections. | Planned | Backend/Privacy | UX-WF-001, PRIV-DC-001 |
| FR-PUB-002 | MVP | Must | Map information shall have an equivalent filtered list view. | Keyboard-only user can access the same report set and details without the map. | Planned | Frontend/A11y | UX-WF-001 |
| FR-PUB-003 | MVP | Should | Public results shall expose data freshness and synthetic/demo limitations. | Fixture date, provenance state and demo notice are visible. | Planned | Product/Frontend | SRC-REG-001, ARCH-ENV-001 |

## 4. Functional requirements — intake and municipal workflow

| ID | Release | Priority | Requirement | Acceptance | Status | Owner | Sources |
|---|---|---:|---|---|---|---|---|
| FR-INT-001 | MVP | Must | Authorized staff shall see a bounded, paginated intake queue. | Role/entity/purpose checks precede data access; unbounded queries are rejected. | Planned | Backend/Security | SEC-TM-001, NFR-001 |
| FR-INT-002 | MVP | Must | Staff shall inspect the report, safe media, provenance and advisory context before deciding. | Detail view distinguishes authoritative, derived, stale, unknown and unavailable information. | Planned | Product/Frontend | ARCH-DFD-001, UX-WF-001 |
| FR-INT-003 | MVP | Must | Duplicate detection shall return advisory candidates with reasons and confidence, never auto-merge. | Provider failure yields unavailable/manual state; human confirms or rejects. | Planned | Data/Backend | ADR-006, OPS-SLO-001 |
| FR-INT-004 | MVP | Must | Staff shall record classification, priority, ownership and rationale as an explicit decision. | Transition validates policy/version and creates business plus audit records transactionally. | Planned | Backend | ARCH-SM-001, ADR-003 |
| FR-INT-005 | MVP | Must | Staff shall be able to override advisory output with a reason. | Override is authorized, versioned and audited without overwriting source evidence. | Planned | Backend/QA | ADR-006, SEC-TM-001 |
| FR-INT-006 | MVP | Must | Concurrent updates shall be detected rather than silently overwritten. | Stale version produces conflict state with reload/compare recovery. | Planned | Backend/Frontend | UX-STATE-001 |
| FR-INT-007 | MVP | Must | Publication shall be a separate human-authorized transition. | No AI/provider result or classification automatically publishes a record. | Planned | Backend/Privacy | ADR-003, PRIV-DC-001 |
| FR-INT-008 | MVP | Must | Assignment/notification intent shall be persisted before asynchronous delivery. | Retry/replay produces exactly one final effect or an explicit manual/dead-letter state. | Planned | Backend/Platform | ADR-005, OPS-SLO-001 |
| FR-INT-009 | MVP | Must | Staff shall see degraded source, AI, CV, storage and workflow states. | Missing provider data is labelled unknown/unavailable and manual work remains possible. | Planned | Frontend/Platform | ARCH-ENV-001, UX-STATE-001 |
| FR-INT-010 | MVP | Must | Closure shall require an authorized human decision and reason. | Closing transition validates current state, records actor/reason/version and updates projection. | Planned | Backend | ARCH-SM-001 |
| FR-INT-011 | MVP | Should | Staff shall reopen a closed item through an explicit audited transition. | Reopen preserves history and does not mutate the original closure event. | Planned | Backend | ARCH-SM-001 |
| FR-INT-012 | MVP | Must | Critical business transitions shall produce immutable audit envelopes. | Expected transition suite shows complete actor, action, entity, reason, time, version and correlation. | Planned | Backend/QA | ADR-004, OPS-SLO-001 |

## 5. Later-release InfraProof requirements

| ID | Release | Priority | Requirement | Acceptance | Status | Owner | Sources |
|---|---|---:|---|---|---|---|---|
| FR-INF-001 | Later | Must | An inspector workflow shall support assigned work, evidence capture and human assessment. | Later release test preserves offline/conflict/privacy boundaries. | Later | Product | UX-WF-001 |
| FR-INF-002 | Later | Must | Contractor access shall be limited to assigned work and exclude citizen contact/originals by default. | Projection and IDOR tests deny cross-assignment and restricted fields. | Later | Security/Backend | PRIV-DC-001, SEC-TM-001 |
| FR-INF-003 | Later | Must | Contractor completion evidence shall require municipal acceptance before official closure. | Contractor action cannot close authoritative incident state. | Later | Product/Backend | ADR-003 |
| FR-INF-004 | Later | Should | Governance dashboards shall use aggregated/minimized data and preserve source freshness. | Drill-down cannot bypass role/entity/purpose controls. | Later | Data/Privacy | PRIV-DC-001 |
| FR-INF-005 | Later | Must | Any KLIC integration shall remain contract-mocked until lawful access and exact terms are approved. | CI/demo use synthetic contract fixtures only; real KLIC path is disabled. | Blocked | Legal/Product | SRC-REG-001 |

## 6. Data and integration requirements

| ID | Release | Priority | Requirement | Acceptance | Status | Owner | Sources |
|---|---|---:|---|---|---|---|---|
| DR-001 | Cross-cutting | Must | PostgreSQL shall own current business, decision, audit and outbox state. | Architecture tests show providers/caches/workflows cannot become business authority. | Planned | Architecture/Backend | ADR-001, ADR-005 |
| DR-002 | Cross-cutting | Must | Restricted originals and safe/public derivatives shall use separate objects and access paths. | Negative tests prove public roles cannot obtain originals or uncertain derivatives. | Planned | Backend/Privacy | ADR-002, PRIV-DC-001 |
| DR-003 | Cross-cutting | Must | Every derived artefact shall retain source, transformation, policy/model and decision provenance. | Evidence chain resolves versions/hashes without leaking restricted content. | Planned | Data/Backend | SRC-PROV-001 |
| DR-004 | MVP | Must | External source use shall be restricted to approved product-level licence entries and dated fixtures. | Unknown/blocked source IDs fail closed and cannot appear as current facts. | Planned | Data/Legal | SRC-REG-001 |
| DR-005 | MVP | Must | Offline fixtures shall be manifest-driven and SHA-256 verified. | Tampered, missing or unregistered fixture aborts the dependent test/demo path. | Planned | Data/QA | SRC-FIX-001 |
| DR-006 | Cross-cutting | Must | Environment and synthetic/real-data identity shall be explicit and non-promotable by accident. | Wrong-environment import/restore aborts; demo shows synthetic labels. | Planned | Platform | ARCH-ENV-001 |
| DR-007 | Cross-cutting | Must | Deletion and retention shall be class-specific, auditable and restore-aware. | Lifecycle tests follow approved schedule and re-delete after restore. | Blocked | Privacy/Platform | PRIV-DC-001, OPS-BR-001 |
| DR-008 | Cross-cutting | Must | Secrets shall stay outside repository, payloads, telemetry, fixtures and ordinary backups. | Secret scan and canary tests show no prohibited values. | Planned | Security/Platform | SEC-TM-001, OPS-BR-001 |

## 7. Quality requirements

| ID | Domain | Requirement | Acceptance | Status | Sources |
|---|---|---|---|---|---|
| QR-SEC-001 | Security | Server-side authorization shall deny by default by role, entity and purpose. | Complete positive/negative IDOR matrix passes. | Planned | SEC-TM-001, NFR-001 |
| QR-SEC-002 | Security | Upload processing shall enforce layered validation, quarantine and bounded resource use. | Malicious corpus fails safely before expensive processing/publication. | Planned | SEC-TM-001 |
| QR-SEC-003 | Security | Callbacks and tracking capabilities shall be authenticated, scoped, fresh and replay-safe. | Forgery, replay, expiry, revocation and scope tests pass. | Planned | SEC-TM-001 |
| QR-PRIV-001 | Privacy | Contact, raw content, tokens, precise coordinates and object URLs shall be absent from telemetry. | Prohibited-value canaries are absent from all configured outputs. | Planned | PRIV-DC-001, OPS-SLO-001 |
| QR-PRIV-002 | Privacy | Lawful basis, notices, retention and DPIA outcomes shall be approved before real-data use. | Named responsible reviewers approve recorded decisions. | Blocked | PRIV-DC-001 |
| QR-A11Y-001 | Accessibility | Core citizen/staff journeys shall work by keyboard with visible focus and announced states. | Automated plus manual journey evidence passes declared criteria. | Planned | UX-STATE-001, NFR-001 |
| QR-A11Y-002 | Accessibility | Meaning shall not depend on colour, pointer precision or map-only interaction. | Contrast, target, list-equivalence and zoom checks pass. | Planned | UX-WF-001, NFR-001 |
| QR-PERF-001 | Performance | Normal API p95 shall be below 500 ms on the declared controlled profile. | Repeatable result records dataset, workload, build and exclusions. | Planned | NFR-001, OPS-SLO-001 |
| QR-PERF-002 | Performance | Bounded map p95 shall be below 1 second on the declared snapshot/profile. | Repeatable evidence meets target. | Planned | NFR-001, OPS-SLO-001 |
| QR-PERF-003 | Performance | Duplicate candidates p95 shall be below 3 seconds on the declared controlled profile. | Repeatable evidence meets target or visible unavailable/manual state is used. | Planned | NFR-001, OPS-SLO-001 |
| QR-REL-001 | Reliability | Valid accepted state shall survive dependency failure with a visible recovery path. | Fault-injection suite preserves invariants in every scenario. | Planned | OPS-SLO-001 |
| QR-REL-002 | Reliability | Final approved workflow intent shall produce exactly one final effect. | Retry/replay suite reaches delivery or explicit manual/dead-letter state without duplicates. | Planned | ADR-005, OPS-SLO-001 |
| QR-REC-001 | Recovery | Restore shall occur in isolation and validate environment, release, database and object consistency. | Synthetic restore exercise completes all gates; wrong-environment case aborts. | Planned | OPS-BR-001 |
| QR-PORT-001 | Portability | A clean clone shall start and test the declared local demo without live source APIs. | Independent clean-clone run passes documented commands with synthetic fixtures. | Planned | ARCH-ENV-001, NFR-001 |
| QR-MAIN-001 | Maintainability | Contracts, migrations, dependencies and architectural boundaries shall be machine-checked in CI. | Declared checks fail on controlled drift fixtures. | Planned | ADR register, NFR-001 |

## 8. Governance requirements

| ID | Requirement | Acceptance | Status | Sources |
|---|---|---|---|---|
| GR-001 | Controlled documents shall record version, status, owner, decision date and approval scope. | Document audit reports no missing fields. | Planned | GOV logs |
| GR-002 | Product approval shall occur before merge; deviations shall be recorded honestly. | PR history and decision log agree. | Planned | DEC register |
| GR-003 | Requirement, risk, decision, issue, test and evidence IDs shall remain traceable. | Orphan and dangling-reference report is empty or has approved gaps. | Planned | E00-05 |
| GR-004 | External specialist review shall remain pending until performed by the accountable role. | No self-review is represented as independent assurance. | Planned | RACI, RAID |
| GR-005 | Real-data, shadow-pilot and production use shall require separate authorization. | Environment gates block promotion from portfolio demo. | Planned | ARCH-ENV-001 |
| GR-006 | Requirement changes shall include impact on architecture, privacy, threats, sources, tests and backlog. | Change PR contains completed impact section. | Planned | E00-05 |

## 9. Blocked external decisions

| Gap ID | Requirement(s) | Decision required | Accountable reviewer | Effect until resolved |
|---|---|---|---|---|
| GAP-REQ-01 | DR-007, QR-PRIV-002 | retention/deletion schedule and restore treatment | Municipality + Privacy/FG + Legal | real personal data prohibited |
| GAP-REQ-02 | QR-PRIV-002 | lawful bases, notices, processor roles and DPIA conclusion | Municipality + Privacy/FG + Legal | real personal data prohibited |
| GAP-REQ-03 | FR-INF-005 | KLIC authority, contract and permitted product use | Legal/municipal owner | mock only |
| GAP-REQ-04 | DR-004 | exact NDW product/licence and Amsterdam WIOR reuse terms | Legal/data owner | affected source blocked |
| GAP-REQ-05 | QR-A11Y-001/002 | target standard and independent conformance evidence | Accessibility specialist | no conformance claim |
| GAP-REQ-06 | QR-REC-001 | customer RPO/RTO, backup region/retention and custody | Platform + Municipality + Privacy | no production recovery claim |
| GAP-REQ-07 | QR-PERF-* | customer scale, geography, concurrency and capacity | Municipality + Product | demo profile only |
| GAP-REQ-08 | GR-005 | hosting, identity, support, incident and deployment authorization | Municipality + Security + Platform | demo only |

## 10. Change and acceptance workflow

1. Propose a requirement change in an issue with reason and source.
2. Preserve the original ID when meaning is refined; create a new ID when the obligation changes materially.
3. Update the catalogue and traceability matrix in one PR.
4. Perform impact analysis across ADRs, threats, privacy, data, UX, tests, operations and Sprint backlog.
5. Record Product Owner decision before merge.
6. Independent reviewers decide only their accountable external gaps.
7. Implementation PRs link requirement and test IDs; passing evidence changes evidence state, not the historical wording.
8. Superseded requirements remain discoverable with a replacement reference.

## 11. Approval

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Pending | — | Sprint 0 catalogue baseline |
| Municipal domain owner | Pending | — | municipal workflow and policy |
| Privacy officer / FG | Pending | — | privacy lifecycle and lawful processing |
| Security reviewer | Pending | — | security obligations and threat coverage |
| Accessibility reviewer | Pending | — | accessibility criteria |
| Platform/SRE reviewer | Pending | — | service, recovery and environment obligations |
| Legal/licence reviewer | Pending | — | sources, licences and disclosure |
