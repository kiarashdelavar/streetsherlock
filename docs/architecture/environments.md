# Environments and Trust Boundaries

| Field | Value |
|---|---|
| Document ID | ARCH-ENV-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner approved 3 August 2026 |
| Scope | Environment purpose, data, access, side effects and promotion |

## 1. Decision boundary

StreetSherlock initially implements Local, CI and Demo. Preview is optional. Shadow Pilot and Production are future approval-gated targets.

This diagram does not mean an environment exists, is secure, is deployed or may process real data. It records intended separation and release obligations. No environment may weaken authorization, privacy, audit or human-decision boundaries.

## 2. Environment catalogue

| Environment | Initial state | Purpose | Allowed data | External side effects | Access |
|---|---|---|---|---|---|
| Local | Planned | developer implementation and manual demo | synthetic fixtures; approved public snapshots | Mailpit and mocks only | developer machine |
| CI | Planned | deterministic automated verification | ephemeral synthetic fixtures | none | CI jobs/maintainers |
| Preview | Optional | PR/UX review when available | synthetic seed only | disabled by default | authenticated reviewers |
| Demo | Planned | public portfolio demonstration | synthetic data + approved public snapshot | demo email sink only | public safe read paths; protected staff demo |
| Shadow Pilot | Not authorized | read-only customer evaluation | contracted minimized export | no source-system mutation | customer-approved users |
| Production | Not authorized | future operational use | governed operational data | explicitly approved integrations | customer identity and controls |

Deventer stories are synthetic and do not imply a partnership. Amsterdam/public material retains source/provenance and licence constraints. Real KLIC and citizen/municipal operational data remain prohibited.

## 3. Environment topology

~~~mermaid
flowchart TB
    Dev["Developer"] --> Local["Local<br/>synthetic fixtures<br/>Mailpit + mocks"]
    Repo["Reviewed Git history"] --> CI["CI<br/>ephemeral synthetic data<br/>no side effects"]
    CI --> Gate["Review + release gates"]
    Gate --> Preview["Preview (optional)<br/>authenticated<br/>side effects off"]
    Gate --> Demo["Demo<br/>synthetic/public snapshot<br/>email sink"]
    PilotGate["Customer + privacy + security + legal approval"] --> Shadow["Shadow Pilot<br/>contracted minimized export<br/>read-only"]
    OpsGate["Operational authorization"] --> Prod["Production<br/>governed data<br/>approved integrations"]
    Demo -. no automatic promotion .-> PilotGate
    Shadow -. separate decision .-> OpsGate
~~~

Dashed arrows represent a new approval process, not normal technical promotion. Demo data or credentials are never promoted into Shadow Pilot or Production.

## 4. Per-environment trust-boundary view

~~~mermaid
flowchart LR
    User["User / reviewer"] --> Edge["Web/API boundary"]
    Edge --> Core["StreetSherlock core<br/>PostgreSQL authority"]
    Core --> Objects["Restricted + safe<br/>object zones"]
    Core --> Adapters["Replaceable adapters"]
    Adapters --> Providers["AI / CV / n8n / sources / Sentry"]
    Core --> Evidence["Audit + outbox evidence"]
~~~

In every environment:

- the edge validates input and enforces rate/size limits;
- the server enforces deny-by-default role/entity/purpose authorization;
- PostgreSQL owns current business state;
- object zones preserve restricted-original/public-derived separation;
- adapters cannot create official human decisions;
- audit/outbox records are transactionally related to authoritative changes;
- provider failure produces visible degraded/unknown/manual states;
- telemetry receives only allowlisted, scrubbed fields.

## 5. Data and side-effect matrix

| Capability | Local | CI | Preview | Demo | Shadow Pilot | Production |
|---|---|---|---|---|---|---|
| Synthetic report/contact | Allowed | Allowed, ephemeral | Allowed | Allowed | separate approved test identities only | policy-dependent |
| Approved public snapshot | Allowed | fixture only | Allowed | Allowed | only if contract/use permits | policy-dependent |
| Real citizen/municipal data | Prohibited | Prohibited | Prohibited | Prohibited | contracted minimized export only | governed |
| Real KLIC | Prohibited | Prohibited | Prohibited | Prohibited | separate lawful decision | separate lawful decision |
| Restricted originals | synthetic only | synthetic only | synthetic only | synthetic only | approved minimized scope | governed |
| Public internet read | optional local | none | authenticated | approved safe pages | customer-approved | policy |
| Email | Mailpit | none/fake | off by default | sink only | approval-gated | approved service |
| Webhook/write-back | mock only | fake server | off | off/sink | no source mutation | approved integration |
| AI/CV | local fixture/provider allowed with synthetic safe inputs | mocked/controlled | off or synthetic | synthetic safe data | separate approval | governed |
| Sentry/telemetry | local/off by default | controlled canary | scrubbed if approved | scrubbed if approved | processor approval | governed |
| Backups | disposable exercise | ephemeral test | optional synthetic | synthetic exercise | customer-approved | governed |
| Secrets | local safe mechanism | CI secret store | environment store | environment store | customer-approved store | managed store |

## 6. Configuration boundary

### Repository-safe configuration

- variable names and safe examples;
- schemas/defaults that reveal no secret;
- synthetic identifiers;
- disabled-by-default feature flags;
- adapter endpoints pointing to local mocks in development;
- documented required versions.

### Environment-managed secrets

- database and object credentials;
- signing/encryption keys;
- provider tokens;
- Sentry DSN/source-map credentials where treated as sensitive;
- n8n webhook/callback authentication;
- customer identity/integration credentials.

Secrets never enter Git, issue/PR bodies, screenshots, fixtures, logs, traces, Sentry, workflow exports or backup payloads.

Municipality policy, category taxonomy, thresholds, retention and notification templates are versioned domain configuration—not environment variables. Feature flags cannot bypass privacy, authorization, audit or human approval.

## 7. Network and adapter assumptions

| Boundary | Initial rule |
|---|---|
| Browser to application | TLS in deployed environments; public/staff routes separated |
| Application to PostgreSQL | private authenticated connection; authoritative writes |
| Application to object storage | scoped service identity; separate zones/prefixes |
| Application to AI/CV | bounded schemas, timeouts, safe data, no tools or direct DB |
| Application to n8n | signed, fresh, idempotent references; minimized payload |
| Application to sources | host/scheme allowlist; bounded time/size; approved fixture fallback |
| Application to Sentry | scrub before export; kill switch; no audit authority |
| Administrative access | least privilege, justified and audited; final design pending |

Exact hosts, regions, firewall/egress controls, identity and tenancy remain unresolved for a customer context.

## 8. Promotion flow

~~~mermaid
flowchart LR
    Ready["Issue Ready"] --> Branch["Task branch"]
    Branch --> Checks["Local + CI checks"]
    Checks --> Review["PR review"]
    Review --> Main["Main"]
    Main --> Demo["Demo deploy + smoke"]
    Demo --> RC["Release candidate"]
    RC --> Gate["Release gate"]
    Gate --> Tag["Signed/tagged release"]
~~~

Rules:

- no direct deployment from an unreviewed feature branch;
- approval is recorded before merge for controlled documents;
- database migration and rollback/forward-fix are reviewed before promotion;
- each tagged release identifies source, containers, schemas, migrations, evidence and limitations;
- a failed gate stops promotion without erasing evidence;
- Shadow Pilot and Production use separate customer gates, data ingestion and credentials.

## 9. Environment isolation controls

| ID | Control | Evidence |
|---|---|---|
| ENV-C01 | unique environment identifier on data, telemetry and backups | config/integration tests |
| ENV-C02 | credentials never reused across trust levels | secret inventory review |
| ENV-C03 | Demo/Preview side effects fail disabled | negative test |
| ENV-C04 | synthetic/public data cannot be confused with customer data | visible labels + manifests |
| ENV-C05 | wrong-environment restore aborts | restore negative test |
| ENV-C06 | public paths cannot access restricted zones | authorization/signed-URL tests |
| ENV-C07 | production-like copies are minimized and separately authorized | approval and manifest |
| ENV-C08 | feature flags cannot disable mandatory controls | negative tests |
| ENV-C09 | telemetry is tagged by environment/release without personal data | scrub/canary tests |
| ENV-C10 | external adapters have per-environment allowlists and fixtures | configuration/contract tests |

## 10. Failure and recovery behavior

| Failure | Safe behavior |
|---|---|
| database unavailable | fail readiness for writes; show recoverable unavailability; never accept then lose |
| migration mismatch | block promotion/startup path; preserve current environment |
| object storage unavailable | retain explicit pending/failed state; block broken public success |
| AI/CV unavailable | record unavailable; continue manual human review |
| n8n unavailable | retain approved intent/outbox; retry idempotently or manual |
| source API unavailable | use approved dated fixture/cache or mark unknown/stale |
| Sentry unavailable | application continues; local safe signals remain; no audit loss |
| telemetry leak suspected | stop export, contain, rotate/review as needed |
| environment marker mismatch | abort import/restore/deploy |
| configuration invalid | fail startup with safe diagnostic, no secret echo |
| Preview/Demo side effect attempted | deny and record sanitized evidence |

## 11. Environment entry gates

### Demo

- only synthetic/approved public data;
- staff demo authorization and public projection tested;
- privacy-safe telemetry configuration verified or disabled;
- side effects use sinks;
- clean-clone and smoke tests pass;
- visible limitations and synthetic labels.

### Shadow Pilot

Requires contract/purpose, minimized export, DPIA/privacy/legal/security decisions, customer identity/access, hosting/network boundaries, retention/deletion, support/incident procedure, measured capacity, backup/RPO/RTO and read-only integration design.

### Production

Requires a separate operational authorization and repeated evidence. Shadow Pilot approval does not imply Production approval.

## 12. Open decisions

| ID | Decision | Required owner |
|---|---|---|
| OD-ENV-01 | Preview hosting and access mechanism | Platform/product |
| OD-ENV-02 | Demo hosting region/provider/network | Platform/security/privacy |
| OD-ENV-03 | Identity provider and privileged-session policy | Municipality/security |
| OD-ENV-04 | customer network/egress/private connectivity | Municipality/platform/security |
| OD-ENV-05 | secret/key manager and custody | Platform/security |
| OD-ENV-06 | telemetry/Sentry provider, region and retention | Privacy/platform |
| OD-ENV-07 | backup provider, region, retention, RPO/RTO | Platform/privacy/municipality |
| OD-ENV-08 | tenant isolation model beyond single-tenant MVP | Architecture/security |
| OD-ENV-09 | shadow-pilot export and deletion procedure | Municipality/privacy/legal |
| OD-ENV-10 | production support, incident and exit responsibilities | Municipality/supplier |

## 13. Approval

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Approved | 3 August 2026 | Sprint 0 environment boundaries and approval gates only |
| Platform/SRE | Pending | — | topology, configuration and promotion |
| Security reviewer | Pending | — | network, identity, secrets and isolation |
| Privacy officer / FG | Pending | — | data, telemetry and location/processor choices |
| Municipal owner | Pending | — | customer environments and operations |
