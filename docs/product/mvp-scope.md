# StreetSherlock MVP Scope and Release Cut Line

| Field | Value |
|---|---|
| Work item | E00-02 |
| Sprint | Sprint 0 — Product freeze and discovery |
| Release | `v0.1.0-streetpulse-mvp` |
| Document owner | Kiarash Delavar, Product Owner |
| Version | 1.0 |
| Status | Approved |
| Controlled baseline | [Master Project Specification v2.0](../MASTER_PROJECT_SPEC.md) |
| Related documents | [Product Charter v1.0](product-charter.md), [Hero Scenario HS-01](hero-scenario.md) |
| Last updated | 2 August 2026 |

## 1. Release decision

`v0.1.0-streetpulse-mvp` is a small but complete, persisted, authorized, auditable StreetPulse workflow. It demonstrates how StreetSherlock sits above existing public-space reporting systems and supports a municipal employee without transferring decision authority to AI or workflow automation.

The release must complete this chain:

```text
Citizen/demo report
→ privacy processing and safe data separation
→ structured AI assessment or manual fallback
→ explainable duplicate candidates
→ authorized human link/reject decision
→ deterministic priority recommendation
→ authorized human priority/status decision
→ audit/public-safe timeline
→ transactional citizen-notification intent
→ idempotent delivery result
```

The intake screen is necessary to prove the vertical flow, but it is not the product's commercial differentiator and must not grow into a replacement for Signalen, Fixi, BuitenBeter, or another MOR platform.

## 2. Frozen release cut line

The Master Project Specification defines the release cut as:

| Included backlog boundary | MVP purpose |
|---|---|
| E01 — Engineering foundation and platform controls | Persisted platform, contracts, identity/roles, CI, health, seeded synthetic data, and accessible map/list foundation. |
| E02 — Citizen intake and privacy boundary | Bounded report intake, validation, contact/original/derived/public separation, privacy processing, tracking, and abuse controls to the MVP acceptance level. |
| E03 — AI-assisted report understanding and incident intelligence | Strict advisory assessment, deterministic fallback, separate Report/Incident aggregates, explainable candidates, human review, and evaluation evidence. |
| E04 — Explainable priority and accountable incident workflow | Versioned deterministic priority, human confirmation/override, authorized state change, notes/timeline, audit, and end-to-end StreetPulse gate. |
| E07-01..E07-03 | Transactional outbox, one signed/idempotent local n8n notification workflow, versioned workflow fixture, retry, and no-duplicate-delivery evidence. |
| Bounded E06-05 | One recorded/synthetic KNMI rain fixture and the minimum rain-context rule needed by HS-01, with provenance, freshness, limitation, and outage fallback. |

E00 product decisions and the required Sprint 0 trust/architecture evidence are prerequisites, not application features in this release.

An item that spans MVP and a later target is included only to the minimum behaviour required by the StreetPulse release acceptance. E00-05 must create the exact requirement traceability and identify any story that must be split before Sprint 1/Sprint 2 planning. The cut line cannot be expanded informally through a PR.

## 3. Frozen demo categories

The first demo supports exactly six top-level categories. Stable IDs are frozen here; subcategories and municipal mapping remain configurable and are refined in E00-03/E00-05.

| Stable ID | Display name | Included examples | Boundary/exclusions |
|---|---|---|---|
| `ROAD_CYCLE_SURFACE` | Road/cycle surface | Pothole, crack, loose/missing/sunken paving, surface depression, unsafe cycle-path surface. | Not a traffic collision, moving vehicle, emergency dispatch, underground structural measurement, or automatic legal/safety conclusion. |
| `PAVEMENT_SIDEWALK` | Pavement/sidewalk | Broken/uneven paving, kerb damage, tactile-paving problem, pedestrian or wheelchair-route obstruction. | Does not infer a person's disability or allocate service using protected traits. Private-property defects require routing/rejection policy, not silent acceptance. |
| `DRAIN_WATERLOGGING` | Drain/waterlogging | Blocked drain cue, standing water, repeated local water accumulation, rain-amplified surface problem. | Not a flood/emergency service, sewer diagnosis, or proof of underground cause. National climate layers are indicative, not street-level truth. |
| `TREE_BRANCH` | Tree/branch | Fallen or dangerous-looking branch, tree obstruction, storm-related tree/branch report. | No automated biological health diagnosis, individual risk certainty, or emergency dispatch. General gardening/vegetation may require a later routing subcategory. |
| `STREETLIGHT` | Streetlight | Light out, flickering, damaged column/fixture, exposed-looking damage reported by a citizen. | Excludes traffic signals, private lighting, power-network diagnosis, and instructions to touch electrical equipment. Urgent hazards need approved guidance. |
| `STREET_FURNITURE` | Street furniture | Damaged bench, bollard, public bin, bicycle rack, barrier, sign/support, or similar municipal object. | Ownership and object mapping must be verified; excludes private property and uncontrolled contractor/utility equipment. |

Rules:

- Citizens may describe a problem in Dutch or English without knowing a technical category.
- The AI may suggest one of these IDs plus a subcategory and limitations; Java validates the value.
- An employee can correct the category with attributable history.
- Multi-signal reports may have a primary category and related facts, as in HS-01 (`ROAD_CYCLE_SURFACE` plus waterlogging context).
- Unknown/unsupported input goes to human review; the system must not force a misleading category.
- Adding, removing, renaming, or changing the meaning of a top-level category is a product-scope change requiring a recorded decision.

## 4. Included product behaviour

### 4.1 Report intake and tracking

- Accept bounded Dutch/English free text, manual map selection, optional contact data, and validated media.
- Show a review step before submission.
- Preserve every source report and source time independently.
- Store optional reporter contact data separately from public/internal report content according to authorization.
- Issue a secure demo tracking reference and show a public-safe timeline.
- Show nearby open incidents and allow a separate report/support signal instead of mutating an existing report.

### 4.2 Privacy boundary

- Keep restricted originals, reporter contact data, derived/redacted data, and public output in separate logical/storage zones.
- Validate media content defensively and strip only policy-approved metadata from derived/public representations.
- Record privacy transformations, versions, status, limitations, and reviewer actions.
- Block public/contractor exposure when a safe derivative is unavailable or review is required.
- Send only a minimized permitted representation to the AI provider.

Full local face/licence-plate detection and measured redaction recall are InfraProof/V1 work. The MVP must still prove the storage/publication boundary with deterministic fixtures and a manual privacy-review/block path; it may not pretend that incomplete vision processing is production-safe.

### 4.3 Structured advisory assessment

- Use an `AiTextProvider` boundary with a deterministic CI provider and local Ollama as the default development provider.
- Return strict schema-validated JSON for summary, language, frozen category, object, danger/obstruction facts, affected route, time reference, missing information, suggested department, urgency indicators, and limitations.
- Preserve original and normalized/translated forms separately and label generated content.
- Treat citizen content as untrusted data and validate output again in Java.
- Record provider/model/prompt/schema versions, latency, outcome, and error class.
- Preserve a complete manual path for timeout, refusal, malformed output, low confidence, or unavailability.

### 4.4 Report-to-incident intelligence

- Keep `Report` and `Incident` as separate aggregates with attributable link history.
- Apply deterministic municipality, status, time, category/asset, and spatial filters before optional semantic ranking.
- Show every candidate factor, missing signal, source/freshness, threshold, and plain-language explanation.
- Require an authorized employee to accept or reject a candidate.
- Create a `ReportIncidentLink` only after that decision; never delete/overwrite the source report.
- Include an explainable negative candidate in HS-01 so rejection is demonstrable.
- Provide safe no-candidate/new-incident and unlink/recovery planning without silent merge behaviour.

### 4.5 Explainable priority and incident workflow

- Calculate priority in deterministic Java code from a versioned demo policy.
- Keep extracted facts, calculation, recommendation, human decision, override reason, and workflow result distinct.
- Show factors, evidence, freshness, missing data, policy version, and factor effect.
- Support the bounded `P1 urgent`, `P2 high`, `P3 normal`, and `P4 low/planned` demo classes without claiming them as Deventer policy.
- Require an authorized case handler to confirm or override the recommendation.
- Validate incident state changes in the backend, separate public/internal notes, and handle concurrent changes safely.
- Record append-only audit/provenance events for every material recommendation and decision.

### 4.6 Map, queue, and accessible operational view

- Show persisted reports and incidents on a map with an accessible list alternative.
- Preserve filters when opening details.
- Provide a bounded intake queue for privacy/manual review, possible duplicates, and priority decisions.
- Display role-appropriate incident details, safe media, linked reports, assessments, decisions, notes, and timeline.
- Include happy, empty, loading, validation, permission, timeout, AI-unavailable, upload-failure, conflict, and recovery states in test/wireframe coverage.

### 4.7 Notification reliability

- Spring Boot commits business state and the notification intent/outbox event transactionally.
- One local n8n workflow sends an approved incident update through Mailpit/SMTP and returns delivery status through a signed/idempotent boundary.
- Store attempts, idempotency key, timestamps, error class, retry count, and outcome.
- Demonstrate that duplicate webhook/callback/retry activity produces at most one citizen message.
- n8n never directly changes incident, priority, link, inspection, or warranty state.

### 4.8 Bounded rain context

- Use one dated, recorded/synthetic rain fixture required by HS-01.
- Store source, licence/terms decision, source time, fetch time, fixture version, freshness, and limitation.
- Show missing/stale/unavailable weather honestly and preserve a manual path.
- Do not poll a live service during acceptance tests or treat weather as proof of cause.

## 5. Explicitly outside `v0.1.0-streetpulse-mvp`

- `StreetWork`, `WorkOrder`, `Repair`, `EvidenceCapture`, `Inspection`, `Warranty`, `WarrantyCase`, and `Contractor` implementation.
- Street-memory timelines linking incidents to works, repairs, inspections, or warranty windows.
- Guided mobile/ghost-overlay evidence capture and image quality scoring.
- Face/licence-plate computer-vision redaction as a claimed production control.
- Image alignment, defect recognition, change overlays, depth/slope/structural measurement, or repair-quality conclusions.
- Possible-recurrence/warranty decisions, liability handling, contractor scoring/sanction, rework workflow, evidence PDF, or contractor notices.
- Autonomous merge, final priority, assignment, status, repair acceptance, external-system write-back, invoice, payment, or legal decision.
- Real municipal integrations, real KLIC data, production multi-tenancy, live write-back, or customer-specific identity/hosting/network setup.
- Nationwide MOR, zaaksysteem, BOR/asset, works, or contractor-system replacement.
- Predictive maintenance, neighbourhood ranking, demographic profiling, facial recognition/person identification, policing, enforcement, or emergency dispatch.
- Kafka, Redis, Kubernetes, service mesh, or artificial microservices without measured need.
- Claims of production readiness, certification, customer adoption, savings, accuracy, GDPR/BIO2/WCAG/AI-Act compliance, or Deventer partnership without independent evidence.

## 6. Data boundary for this release

| Data class | MVP treatment |
|---|---|
| Synthetic Deventer business data | Clearly labelled fixture data; no implication of real municipal source or outcome. |
| Reporter contact data | Optional, minimized, separately protected, never shown to public/contractor roles. |
| Restricted original text/media | Access-controlled source evidence; never exposed through public-safe output. |
| Derived/normalized/redacted data | Versioned with provenance, status, limitation, and human correction. |
| Public-safe data | Explicit allowlisted fields only; blocked when privacy status is incomplete. |
| AI assessment | Advisory, schema validated, versioned, attributable to provider/model/prompt, and separate from decisions. |
| Duplicate/priority calculation | Versioned inputs/factors/policy and missing/stale signals; recommendation only. |
| Human decision | Authorized actor, time, reason where required, old/new state, and correlation ID. |
| Weather context | Dated fixture with provenance/freshness/limitation; not causation evidence. |
| Workflow/notification data | Minimized approved intent plus idempotent delivery metadata; not business authority. |

Detailed lawful basis, retention, archive, deletion, data-subject procedure, and municipal data-sharing decisions require external owners and remain outside self-approval.

## 7. Release acceptance gates

The release is not accepted by screen count or a polished demo. All gates below must pass with persisted data and documented evidence.

| Gate | Required evidence |
|---|---|
| Product boundary | Product Charter and E00-02 approved; demo states intelligence-layer position and synthetic status. |
| Persistence and contracts | Clean environment migrations; real persisted `Report`, `Incident`, link, assessment, decision, audit, and notification-intent data reach the UI through authorized APIs. |
| Privacy | Restricted/contact/derived/public separation; publication block; no restricted original in the public/contractor verification suite. |
| AI safety/recovery | Strict contract and Java validation; prompt-injection cases; timeout/refusal/malformed/unavailable paths preserve manual handling. |
| Human duplicate decision | Every accepted/rejected link is attributable; zero automatic merges; source reports remain traceable. |
| Explainable priority | Deterministic versioned factors visible; every final priority is human-confirmed/overridden and recorded separately. |
| Authorized workflow | Backend state-machine and role tests reject unauthorized/invalid/conflicting changes without partial mutation. |
| Citizen update | Transactional intent plus signed/idempotent delivery; retry/callback test produces no duplicate message. |
| Audit/provenance | HS-01 timeline connects source, privacy, AI/calculation versions, human decisions, state, and delivery attempts. |
| Accessibility | Critical path has keyboard, screen-reader labels, clear focus/errors, and an accessible list alternative to the map; independent full evaluation remains a later gate. |
| Reliability | AI, weather, notification, and source-fixture outages degrade safely; failures have correlation evidence without unnecessary personal data. |
| Honest release | HS-AT-01..10 pass; InfraProof functions are absent or clearly labelled roadmap material; limitations are published. |

## 8. Release success measures

For the bounded verification suite:

- 100% of report-to-incident links require and record an authorized human action.
- 100% of final priority confirmations/overrides record actor, policy version, evidence, and required reason.
- 0 restricted-original media objects appear in public/contractor output.
- AI timeout, refusal, malformed output, low confidence, and unavailability preserve a usable manual path.
- 0 duplicate citizen messages are produced by the idempotency/retry test.
- 100% of displayed recommendations identify type, version/provenance, factors/limitations, and advisory status.
- HS-01 completes using persisted backend data, not UI-hardcoded operational decisions.

Triage-time improvement, precision@k, candidate acceptance/reversal, priority overrides, privacy-redaction recall, accessibility conformance, and delivery reliability must be measured and reported with a bounded dataset. No unmeasured business benefit may be claimed.

## 9. Change control

This scope is frozen after Product Owner approval. A proposal must return to refinement and receive a recorded decision when it:

- changes a top-level demo category or its meaning;
- moves an InfraProof capability into the MVP;
- changes Report/Incident separation or source-report preservation;
- allows automatic link, final priority, status, liability, repair, contractor, or external-system decisions;
- weakens privacy separation, authorization, audit, human review, failure recovery, or honest synthetic-data labelling;
- adds a major technology without a tested MVP outcome;
- changes the exact release cut line.

When capacity is insufficient, split or remove lower-priority behaviour through backlog refinement. Do not meet a date by weakening privacy, authorization, auditability, human authority, or safe recovery.

## 10. Open external decisions

The following are deliberately not frozen as municipal truth:

- real category taxonomy/codes and routing ownership;
- municipality-specific priority factors, weights, classes, thresholds, and service levels;
- lawful basis, retention, archive, publication, and data-subject processes;
- authoritative source systems, identity provider, integration formats, network, hosting, support, and incident notification;
- contractor roles, warranty clauses, evidence standards, appeal/rework process, and write-back authority;
- pilot KPIs, procurement, data-sharing, support, rollback, and exit terms.

These questions must receive named owners/dates in E00-04/E00-06 and cannot be guessed in implementation.

## 11. Approval record

| Decision | Owner | Status | Date | Notes |
|---|---|---|---|---|
| Freeze six categories and `v0.1.0-streetpulse-mvp` cut line | Kiarash Delavar, Product Owner | Approved | 2 August 2026 | Approved without conditions; controlled as version 1.0. |
| Validate municipal workflow, category mapping, and policy | External municipal-domain owner | External validation required | — | Required before a real pilot. |
| Validate privacy, legal, security, accessibility, and AI-governance controls | Authorized independent reviewers | External validation required | — | Not self-certified by this document. |

## E00-02 acceptance evidence

| Criterion | Evidence |
|---|---|
| Six categories frozen | Section 3 |
| Exact release cut documented | Section 2 |
| Complete StreetPulse vertical boundary | Sections 1, 2, and 4 |
| InfraProof and autonomous decisions excluded | Section 5 |
| Synthetic/privacy/authority boundaries | Sections 4–6 |
| Testable release gates and measures | Sections 7 and 8 |
| Scope changes controlled | Section 9 |
| External questions not invented | Section 10 |
| Product Owner approval | Recorded in Section 11 |

**Review result:** Approved by Kiarash Delavar, Product Owner, on 2 August 2026. E00-02 remains open only until PR #4 is merged.
