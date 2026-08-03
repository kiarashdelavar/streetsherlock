# StreetSherlock Threat Model

| Field | Value |
|---|---|
| Document ID | SEC-TM-001 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar — Product Owner / solo delivery |
| Review cadence | Every sprint and after architecture, data-flow, identity, provider, model, deployment, or trust-boundary change |
| Controlled source | `requirements/StreetSherlock-Master-Project-Prompt.md` |
| Related issue | #22 |
| Approval | Pending Product Owner review |
| Independent review | Municipal security, privacy/FG, legal, accessibility and domain reviews pending |

## 1. Purpose and claim boundary

This document is the Sprint 0 threat-model skeleton for StreetSherlock. It identifies assets, actors, entry points, trust boundaries, threats, intended controls, safe failure and future verification evidence before application scaffolding.

It is not proof of implementation, OWASP ASVS conformance, BIO2 conformance, GDPR compliance, penetration testing, production readiness, municipal approval, or deployment authorization. A control marked **Planned** is an obligation, not evidence.

StreetSherlock has two release scopes:

- **StreetPulse MVP:** report intake, privacy processing, advisory assessment, duplicate recommendation, human review, deterministic explainable priority, incident update and citizen notification.
- **InfraProof later release:** work/repair lineage, guided evidence, inspection, computer-vision comparison, recurrence and warranty-candidate workflows.

Threats for later InfraProof features are retained but marked **Later**. They do not authorize those features in the MVP.

## 2. Non-negotiable security and safety rules

1. PostgreSQL is the authoritative store for business state; n8n, AI, CV and external providers are not.
2. AI and CV are advisory and cannot merge reports, set final priority, accept repair, assign liability, send a claim, or change an external system.
3. Reports remain independent evidence. Links and operational decisions are human-owned, reversible and audited.
4. Authorization is deny-by-default and enforced server-side; frontend visibility is not a security boundary.
5. Restricted originals never become public automatically.
6. Contractor users never receive citizen contact information or unrelated municipal records.
7. Public tracking tokens are high entropy, revocable, expiring and rate-limited.
8. Provider failure must preserve persisted state and expose a visible manual/retry path.
9. User content cannot select tools, execute queries, alter prompts/policies/models, or create side effects.
10. No real KLIC data, real citizen data, or municipal production integration is authorized in the portfolio baseline.

## 3. Method

Threat discovery uses STRIDE:

| Code | Category | Question |
|---|---|---|
| S | Spoofing | Can an attacker impersonate a person, tenant, service or provider? |
| T | Tampering | Can data, evidence, state, policy, model or messages be changed improperly? |
| R | Repudiation | Can a sensitive action occur without attributable evidence? |
| I | Information disclosure | Can restricted or personal data cross its allowed boundary? |
| D | Denial of service | Can a resource or workflow be exhausted or blocked? |
| E | Elevation of privilege | Can a principal gain capabilities beyond its role or purpose? |

### 3.1 Risk scale

Likelihood and impact are rated 1–5. Exposure is `likelihood × impact`.

| Exposure | Rating | Treatment expectation |
|---:|---|---|
| 1–4 | Low | Track and verify normal controls |
| 5–9 | Medium | Mitigation and test required before affected capability is accepted |
| 10–16 | High | Release-blocking until mitigated or explicitly removed from scope |
| 17–25 | Critical | Do not expose capability; escalate to security/privacy owner |

Residual ratings remain **Unassessed** until implementation evidence exists. Product Owner acceptance cannot replace independent review where required.

## 4. Protected assets

| ID | Asset | Classification | Integrity/availability need |
|---|---|---|---|
| A-01 | Citizen contact data and tracking capability | Restricted personal | Confidential; correct ownership; revocable access |
| A-02 | Original text, images and metadata | Restricted personal/content | Immutable provenance; controlled access; malware-safe |
| A-03 | Redacted/public derivatives | Public only after gate | Must correspond to approved source and redaction decision |
| A-04 | Reports and report history | Internal/restricted | Never silently deleted or merged; available for recovery |
| A-05 | Incidents, links, states and assignments | Internal operational | Human authority, concurrency control and audit |
| A-06 | Priority inputs, policy versions and recommendations | Internal derived | Explainable, versioned and non-authoritative until decision |
| A-07 | Audit events and access reasons | Restricted audit | Append-oriented, attributable, queryable and tamper-evident |
| A-08 | Identity, roles, tenant and purpose grants | Security-sensitive | Deny by default; correct tenant and role binding |
| A-09 | API keys, signing keys, tokens and secrets | Secret | Never logged; rotated; least privilege |
| A-10 | Source snapshots, fixture manifests and provenance | Internal/open-derived | Licence, hash, version and source integrity |
| A-11 | Prompts, models, embeddings and evaluation artefacts | Internal AI | Version compatibility; poison resistance; rollback |
| A-12 | n8n intents, callbacks and delivery state | Internal operational | Authenticated, idempotent, replay-safe |
| A-13 | Backups and restore artefacts | Restricted aggregate | Encrypted, isolated and restored only to intended environment |
| A-14 | Logs, metrics, traces and Sentry events | Internal telemetry | Allowlisted and privacy-safe |
| A-15 | Later repair, inspection, warranty and contractor evidence | Restricted operational | Provenance, authorization, human inspection authority |

## 5. Actors and adversaries

| ID | Actor | Expected authority | Threat concern |
|---|---|---|---|
| P-01 | Anonymous citizen | Submit; track own public result | Abuse, forged files, token enumeration |
| P-02 | Authenticated citizen | Own reports only | IDOR, account compromise |
| P-03 | Intake/case employee | Assigned municipal work | Excess access, unsafe publication, mass assignment |
| P-04 | Inspector/field worker | Assigned evidence/work | Lost device, forged evidence, offline conflict |
| P-05 | Contractor user | Own assignments only | Citizen-data access, cross-contractor IDOR |
| P-06 | Municipal/admin manager | Policy and user configuration | Privilege abuse, unsafe policy change |
| P-07 | AI/data steward | Model/evaluation governance | poisoned artefact, incompatible versions |
| P-08 | Platform/support operator | Infrastructure operations | secret/content exposure, unaudited support access |
| P-09 | Integration service account | Narrow import/export scope | forged/replayed events, overbroad tenant access |
| P-10 | External attacker | No authority | exploitation, denial, exfiltration |
| P-11 | Malicious/compromised dependency or source | No authority | supply-chain or data poisoning |
| P-12 | AI prompt attacker | Content submission only | injection, extraction, resource exhaustion |

## 6. Entry points and trust boundaries

| ID | Boundary / entry point | Untrusted side | Trusted side | Required control family |
|---|---|---|---|---|
| TB-01 | Public web → web/API edge | Browser, network, citizen input | StreetSherlock edge | TLS, validation, rate limit, CSRF/CORS policy, safe errors |
| TB-02 | Edge → application services | Request identity and payload | Authorized application method | Authentication, tenant/role/purpose authorization |
| TB-03 | Application → PostgreSQL/PostGIS | Application query/data | Authoritative business state | Parameterization, constraints, transactions, least privilege |
| TB-04 | Upload → quarantine/object storage | Arbitrary bytes/metadata | Restricted media pipeline | Size/type limits, filename isolation, malware/parser controls |
| TB-05 | Restricted original → redacted/public derivative | Personal content | Publication candidate | redaction gate, human review on uncertainty, separate objects |
| TB-06 | Application → Ollama/embedding provider | User-controlled text/context | Advisory model output | prompt separation, bounded context, schema validation, timeout |
| TB-07 | Application → Python/CV worker | Media/job parameters | Advisory CV output | signed job identity, sandbox, resource limits, refusal |
| TB-08 | Backend outbox ↔ n8n | Delivery intent/callback | Persisted workflow result | signature, timestamp, nonce, idempotency, state validation |
| TB-09 | Import adapter → external/open source | Remote payload/licence/state | Versioned snapshot/fixture | allowlist, timeout, schema/provenance/hash, fail closed |
| TB-10 | Application → email/export/publication | Internal approved facts | External recipient/channel | approval, minimization, destination control, delivery audit |
| TB-11 | Operator/CI → runtime/secrets | Human/workflow identity | Deployment environment | least privilege, protected environments, pinned actions, audit |
| TB-12 | Production-like store → backup/restore | Aggregate restricted data | Isolated recovery target | encryption, environment binding, restore authorization |
| TB-13 | Tenant/role boundary | One municipality/user | Another tenant/role | server-side scoping and negative authorization tests |
| TB-14 | Later contractor/field boundary | External/limited user | Municipal evidence lifecycle | assignment scope, minimum disclosure, evidence provenance |

## 7. Primary data-flow security notes

1. A submission crosses TB-01 and is validated before persistence.
2. Media is stored as a restricted original through TB-04; it is never public by default.
3. Privacy processing may create a separate derivative through TB-05. Uncertain processing blocks publication.
4. AI assessment crosses TB-06. Only schema-valid, bounded advisory output is stored; malformed or unavailable output leads to manual handling.
5. Duplicate candidates and priority recommendations do not change official state.
6. An authorized employee decision crosses TB-02/TB-13, changes PostgreSQL state transactionally and writes an audit event.
7. An approved notification intent enters the transactional outbox. n8n delivery crosses TB-08; callbacks cannot invent or rewrite business state.
8. Public tracking exposes only a minimized projection through an expiring token.
9. Later evidence/CV/contractor flows stay disabled until their separate release gates.

## 8. Threat register

Status values: **Planned**, **Blocked by design**, **Later**, or **Needs decision**.

| ID | STRIDE | Threat / abuse case | Boundary/assets | L | I | Initial | Required treatment | Status |
|---|---|---|---|---:|---:|---:|---|---|
| TM-001 | T/D | Oversized, decompression-bomb, polyglot or malformed image exhausts or exploits parsers | TB-04; A-02 | 4 | 5 | 20 Critical | byte/pixel/page/dimension limits; streaming; quarantine; isolated decoder; timeout; reject ambiguous/polyglot content | Planned |
| TM-002 | T/E | Path traversal, unsafe filename or content-type confusion writes/serves unintended content | TB-04; A-02/A-03 | 4 | 5 | 20 Critical | generated object IDs; ignore client path; magic-byte validation; no execution; attachment headers | Planned |
| TM-003 | S/I | Tracking-token enumeration or replay exposes another citizen’s report | TB-01; A-01/A-04 | 4 | 5 | 20 Critical | 128-bit+ entropy; hashed storage; expiry/revocation; generic errors; rate limits; replay monitoring | Planned |
| TM-004 | E/I | IDOR across reports, incidents, media, work, tenants or exports | TB-02/TB-13; A-01–A-08/A-15 | 4 | 5 | 20 Critical | server-side entity/tenant/purpose authorization; opaque IDs not relied upon; negative matrix tests | Planned |
| TM-005 | E/I | Contractor accesses citizen PII, other contractors or unrelated cases | TB-13/TB-14; A-01/A-02/A-15 | 4 | 5 | 20 Critical | contractor projection; assignment binding; no contact fields; separate endpoints; audit and tests | Later |
| TM-006 | T/D/I | Prompt injection causes tool use, data extraction, unsafe claim or resource exhaustion | TB-06; A-01/A-11 | 4 | 4 | 16 High | no tools/DB access; data/instruction separation; bounded input/output; schema allowlist; timeout; refusal/manual path | Planned |
| TM-007 | T | Model output directly changes link, priority, publication, repair or liability | TB-06/TB-07; A-05/A-06/A-15 | 3 | 5 | 15 High | architecture prohibition; command handlers accept human/deterministic authority only; audit; negative tests | Blocked by design |
| TM-008 | S/T | Forged or replayed n8n callback creates duplicate or false delivery | TB-08; A-12 | 4 | 4 | 16 High | HMAC/mTLS decision; timestamp/nonce; idempotency key; expected-state validation; durable receipt | Planned |
| TM-009 | I | Secret or restricted content leaks through n8n payload/history | TB-08; A-01/A-02/A-09/A-12 | 3 | 5 | 15 High | reference IDs/minimized payload; scoped secret; retention; scrubbed execution data; access review | Planned |
| TM-010 | E/T | Mass assignment or invalid state transition bypasses domain authority | TB-01/TB-02; A-05/A-06/A-15 | 4 | 5 | 20 Critical | request DTO allowlists; state machine/domain commands; role checks; optimistic locking; audit | Planned |
| TM-011 | I | Logs, Sentry, traces or errors contain PII, tokens, prompts or secrets | TB-01/TB-11; A-01/A-02/A-09/A-14 | 4 | 5 | 20 Critical | allowlist telemetry; server-side scrubbing; no request bodies; synthetic tests; kill switch | Planned |
| TM-012 | T | Malicious/poisoned source snapshot, fixture, model or embedding artefact corrupts recommendations | TB-06/TB-09/TB-11; A-10/A-11 | 3 | 5 | 15 High | approved source register; hashes/signatures; schema; provenance; model/dataset version; rollback | Planned |
| TM-013 | T/E | Dependency, container, package or GitHub Action compromise executes in CI/runtime | TB-11; A-09/A-11 | 3 | 5 | 15 High | lockfiles; SBOM; scanning; minimal workflow permissions; actions pinned to reviewed full SHA; provenance | Planned |
| TM-014 | I/T | Backup disclosure or restore into wrong environment/tenant | TB-12; A-01–A-15 | 3 | 5 | 15 High | encryption; access separation; environment/tenant marker; approved restore runbook; isolated test; audit | Planned |
| TM-015 | S/T/I | SSRF through URL, importer, webhook or media reference reaches internal services | TB-04/TB-08/TB-09; A-09/A-13 | 4 | 5 | 20 Critical | no arbitrary URL fetch; scheme/host allowlist; DNS/IP recheck; block private/link-local; egress control; size/time limits | Planned |
| TM-016 | I | Signed URL theft, excessive lifetime or wrong-tenant object reference exposes media | TB-04/TB-13; A-02/A-03 | 4 | 5 | 20 Critical | short TTL; audience/object/tenant binding; authorization before issue; revocation; no logging | Planned |
| TM-017 | R/T | Sensitive access or decision lacks actor, reason, version or correlation evidence | TB-02/TB-13; A-05/A-07 | 3 | 5 | 15 High | mandatory audit envelope; append-only permissions; transaction coupling; completeness tests | Planned |
| TM-018 | T/R | Concurrent reviewers overwrite links, state, publication or priority | TB-02/TB-03; A-04–A-07 | 3 | 4 | 12 High | optimistic version; conflict response; reload/review; audit both attempts; idempotent commands | Planned |
| TM-019 | I | Public derivative retains face, plate, address metadata or original object reference | TB-05/TB-10; A-02/A-03 | 4 | 5 | 20 Critical | separate derivative; EXIF removal; evaluation; uncertainty blocks; manual correction/approval | Planned |
| TM-020 | S/E | Stolen employee/operator session gains municipal or infrastructure authority | TB-02/TB-11; A-05/A-08/A-09 | 3 | 5 | 15 High | OIDC decision; MFA for privileged roles; short sessions; revocation; re-auth for sensitive actions | Needs decision |
| TM-021 | E | Cross-tenant query/cache/vector search returns another municipality’s record | TB-03/TB-13; A-04–A-08 | 3 | 5 | 15 High | single-tenant MVP honestly scoped; future tenant key in every layer; RLS decision; isolation tests before enablement | Blocked by MVP scope |
| TM-022 | D | AI, CV, n8n, source, object store or email outage blocks the core workflow | TB-04/TB-06–TB-10; A-04/A-05/A-12 | 4 | 4 | 16 High | timeout/circuit breaker; persisted status; outbox/retry; stale marker; manual path; runbook | Planned |
| TM-023 | D | Public/API abuse exhausts CPU, database, storage, geocoder or model capacity | TB-01/TB-04/TB-06; all service assets | 4 | 4 | 16 High | quotas; rate/size limits; pagination; bounded spatial queries; queues; backpressure; cost/resource alerts | Planned |
| TM-024 | T/I | Imported remote payload exploits parser, changes semantics or violates provenance/licence | TB-09; A-10 | 3 | 4 | 12 High | adapter schema; snapshot quarantine; source/licence status; hash; review; fail closed on change | Planned |
| TM-025 | T/R | Evidence timestamp/location/file is forged or replaced and treated as inspection truth | TB-04/TB-14; A-15 | 3 | 5 | 15 High | upload provenance; server receipt time; hash; assignment binding; device metadata non-authoritative; inspector review | Later |
| TM-026 | T | CV comparison overstates certainty or accepts unsuitable evidence | TB-07; A-11/A-15 | 3 | 5 | 15 High | quality gate; refusal; confidence/limitations; versioned output; inspector finding separate and authoritative | Later |
| TM-027 | T/E | Warranty candidate becomes automated contractor liability, claim or payment action | TB-02/TB-08/TB-14; A-15 | 3 | 5 | 15 High | candidate only; contract context; inspector/legal approval; no autonomous send/payment; full audit | Blocked by design |
| TM-028 | R/I | Support operator reads restricted content without justified, audited purpose | TB-11; A-01/A-02/A-13 | 3 | 5 | 15 High | audited just-in-time access; reason/ticket; time limit; separation; alert/review | Planned |
| TM-029 | T | Policy, taxonomy, threshold, prompt or model changes without version/evaluation alter outcomes silently | TB-02/TB-06/TB-11; A-06/A-11 | 3 | 5 | 15 High | immutable versions; approval workflow; golden/evaluation suite; rollback; decision trace | Planned |
| TM-030 | I/T | Export/email/publication reaches wrong recipient or includes internal/restricted fields | TB-10; A-01–A-07/A-15 | 3 | 5 | 15 High | approved projection/template; recipient confirmation; preview; human send approval; delivery audit; cancellation where possible | Planned |

## 9. Mandatory abuse-case coverage

| Master Specification abuse case | Threat IDs | Sprint 0 disposition |
|---|---|---|
| Oversized/decompression-bomb/polyglot/malformed image | TM-001 | Controls and negative-test obligation defined |
| Path traversal/unsafe filename/content-type/parser exploit | TM-002 | Controls and negative-test obligation defined |
| Tracking-token enumeration and replay | TM-003 | Token and abuse controls defined |
| IDOR across protected resources/tenants | TM-004, TM-021 | Authorization matrix required |
| Contractor access to citizen/restricted data | TM-005 | Later release; must fail closed |
| Prompt injection/model resource exhaustion | TM-006, TM-023 | Tool-less bounded adapter/manual fallback |
| SSRF through URLs/importers/webhooks | TM-015 | Fetch allowlist/egress control required |
| Signed-URL theft/lifetime/wrong-tenant object | TM-016 | Short-lived bound URLs required |
| n8n forged callback/replay/duplicate/secret leakage | TM-008, TM-009 | Signed idempotent minimized integration |
| Mass assignment/invalid state transitions | TM-010 | Domain commands/state machine required |
| Log/Sentry/error leakage | TM-011 | Allowlist and scrub verification required |
| Malicious/poisoned snapshot/model artefact | TM-012, TM-024 | Provenance/hash/schema/rollback required |
| Dependency/build-action compromise | TM-013 | Inventory, scans and pinned actions required |
| Backup disclosure/wrong-environment restore | TM-014 | Isolation and restore evidence required |

All mandatory Section 44.2 cases are represented. Coverage means planned treatment, not completed verification.

## 10. Security control catalogue

| Control ID | Control | Applies to | Planned evidence |
|---|---|---|---|
| SC-01 | Server-side deny-by-default authentication/authorization | TM-003–005, 010, 020–021, 028 | route/method policy and negative matrix tests |
| SC-02 | Tenant/entity/purpose scoping | TM-004–005, 016, 021 | cross-object and cross-tenant tests |
| SC-03 | Domain state machine, allowlisted commands and optimistic locking | TM-007, 010, 018, 027 | domain tests and conflict recovery tests |
| SC-04 | Transactional audit and outbox | TM-008, 017, 030 | atomicity, completeness and retry tests |
| SC-05 | Restricted-original/public-derivative separation | TM-011, 016, 019 | storage policy and publication-gate tests |
| SC-06 | Hardened upload quarantine | TM-001–002, 015, 023 | malicious corpus and resource-limit tests |
| SC-07 | Tool-less bounded AI adapters with schema/refusal | TM-006–007, 022–023, 029 | injection, timeout, malformed and unsupported-output tests |
| SC-08 | Signed, replay-safe, idempotent integrations | TM-008–009, 015 | forged/replay/duplicate callback tests |
| SC-09 | Provenance, hash, version and rollback | TM-012–013, 024, 029 | manifest/SBOM/verification and rollback evidence |
| SC-10 | Privacy-safe telemetry and errors | TM-011 | automated secret/PII canaries and scrub tests |
| SC-11 | Backup encryption, isolation and environment binding | TM-014 | restore exercise and access review |
| SC-12 | Rate limits, quotas, backpressure and bounded queries | TM-001, 003, 006, 023 | controlled load/abuse tests |
| SC-13 | Least-privilege secrets and operator access | TM-009, 013, 020, 028 | permissions review, rotation and audited-access exercise |
| SC-14 | Safe degradation and visible recovery | TM-018, 022–024 | outage fixtures and user-visible state tests |
| SC-15 | Human authority and external-send approval | TM-007, 026–027, 030 | authorization, audit and no-autonomous-side-effect tests |

## 11. Required verification backlog

No item below is complete in Sprint 0 unless separate evidence says so.

### Before the public intake slice

- Unit tests for filename, media metadata, byte/pixel/dimension and parser limits.
- Negative upload corpus including malformed, polyglot and decompression-bomb fixtures.
- Rate-limit and generic-error tests for public submission/tracking.
- Token entropy, hashed storage, expiry, revocation and replay tests.
- Telemetry tests proving report text, media, contact data, tokens and secrets do not leak.
- SSRF tests covering redirects, DNS rebinding assumptions, private/link-local ranges and unsupported schemes.

### Before municipal review features

- Role/entity/purpose authorization matrix, including IDOR negative tests.
- State-transition and mass-assignment negative tests.
- Optimistic-lock conflict and idempotent retry tests.
- Audit coverage for sensitive access and decisions.
- Restricted-original access reason and correlation-ID evidence.
- Publication gate and redaction uncertainty tests.

### Before AI or CV is enabled

- Prompt-injection and resource-exhaustion cases.
- Schema-invalid, malformed, slow and unavailable model behavior.
- Proof that adapters cannot call tools, write business state or select recipients.
- Versioned prompt/model/dataset/evaluation record and rollback.
- CV quality refusal and inspector-authority separation for later InfraProof.

### Before n8n or external delivery is enabled

- Callback signature, freshness, replay and idempotency tests.
- Duplicate delivery/outbox recovery fixture.
- Minimized payload and secret-leak review.
- Recipient/projection preview and human-approval test.
- n8n outage with persisted manual/retry path.

### Before any deployment or release claim

- Relevant OWASP ASVS 5.0 Level 2 mapping and evidence.
- Dependency, container, secret and IaC/workflow scans.
- SBOM plus model/dataset/container inventory.
- Backup and isolated restore exercise.
- Key/secret rotation exercise.
- Security incident tabletop for exposure/authorization bypass.
- Independent security and privacy review; unresolved findings recorded.
- No production/compliance wording without its required evidence.

## 12. Safe failure and recovery matrix

| Failure/attack | Safe system behavior | Prohibited behavior |
|---|---|---|
| Upload rejected or scanner unavailable | Preserve non-media form where policy permits; show reason/retry; quarantine uncertain content | Serve or analyze uncertain file |
| Privacy/redaction uncertain | Keep original restricted; require review; block publication | Publish best-effort derivative |
| AI unavailable/malformed/injected | Record failure/version; show manual structured review | Treat prose as command or silently accept fields |
| Duplicate assessment unavailable | Keep report independent; allow manual search/review | Auto-link or hide report |
| Priority context/source stale | Mark missing/stale factors; deterministic/manual review | Invent facts or claim certainty |
| n8n unavailable/callback replay | Keep approved intent/outbox status; retry idempotently or handle manually | Lose intent or create duplicate final delivery |
| Object storage unavailable | Keep database state explicit; retry; block broken public link | Claim upload/publication success |
| Authorization uncertain | Deny; preserve correlation ID; offer correct escalation route | Fall back to broad access |
| Concurrency conflict | Reject stale write; reload and require deliberate review | Last-write-wins on official state |
| Backup/restore environment mismatch | Abort restore and alert | Import into wrong environment/tenant |
| Source/import integrity failure | Quarantine/disable adapter; use approved fixture/stale marker | Ingest unverified payload |
| Suspected exposure/auth bypass | Contain, revoke, preserve privacy-safe evidence and escalate | Continue normal processing or erase evidence |

## 13. Incident response expectations

For suspected data exposure or authorization bypass:

1. stop the affected path when safe;
2. preserve privacy-safe evidence and correlation IDs;
3. revoke affected tokens/keys and block the path;
4. identify records, roles, environments and time window;
5. notify accountable security/privacy owners;
6. remediate and add regression tests;
7. record notification/legal questions for the responsible organization;
8. complete a blameless review and update this model.

Portfolio exercises simulate the process only; they do not claim a real municipal response capability.

## 14. Assumptions and open decisions

| ID | Open item | Risk if unresolved | Owner / required reviewer |
|---|---|---|---|
| O-01 | Final OIDC provider, MFA and privileged-session policy | TM-020 remains high | Architecture + independent security |
| O-02 | Object storage, malware scanning and decoder isolation design | TM-001/002/016 remain critical | Platform + security |
| O-03 | n8n authentication, retention and deployment topology | TM-008/009 remain high | Architecture + security/privacy |
| O-04 | AI/CV sandbox and compute/resource quotas | TM-006/023/026 remain high | AI/platform/security |
| O-05 | Backup encryption, key custody, target isolation and retention | TM-014 remains high | Platform + privacy/security |
| O-06 | Public-token lifetime and revocation policy | TM-003 remains critical | Product + privacy/security |
| O-07 | Telemetry/Sentry processor, region, retention and scrub configuration | TM-011 remains critical | Privacy + platform |
| O-08 | Future multi-tenant enforcement model and migration | TM-021 remains blocked | Architecture + security |
| O-09 | Municipal roles, purpose rules and support-access procedure | authorization cannot be validated | Municipal owner + privacy/security |
| O-10 | Legal and contractual meaning of later warranty data/actions | TM-027 remains blocked | Municipal legal/procurement |
| O-11 | Retention/deletion behavior across originals, derivatives, audit and backups | privacy risk remains open | Privacy/FG + legal |
| O-12 | Representative threat review and penetration-test scope | unknown implementation risk | Independent security reviewer |

## 15. Release and review gates

- **Sprint 0 acceptance:** coherent skeleton, complete mandatory-abuse-case coverage, owners and evidence obligations; no implementation claim.
- **Sprint 1 entry:** architecture and backlog reference the applicable threat IDs; critical controls are acceptance criteria for exposed capabilities.
- **Feature merge:** relevant threat/control tests pass and documentation is updated.
- **Portfolio release:** scans, negative tests, restore evidence, incident exercise and limitations are published.
- **Shadow pilot:** separate municipality-specific model, DPIA/security/legal decisions, real identity/hosting/integration design and independent review.
- **Operational pilot:** outside current authorization.

Any new entry point, role, provider, data class, external side effect, model, deployment environment, tenant mechanism or file parser requires this model to be reviewed.

## 16. Approval record

| Role | Name | Decision | Date | Scope |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Pending | — | Sprint 0 threat-model structure only |
| Independent security reviewer | Unassigned | Pending | — | Architecture and implementation security |
| Privacy officer / FG | Unassigned | Pending | — | Personal-data processing and DPIA |
| Municipal/domain owner | Unassigned | Pending | — | Roles, operations and risk acceptance |
| Legal/procurement reviewer | Unassigned | Pending | — | Later warranty/contractor and processing terms |

Product Owner approval will not close independent review, lower residual risk without evidence, authorize real data, or permit deployment.
