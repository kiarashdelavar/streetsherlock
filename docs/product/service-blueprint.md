# StreetSherlock Initial Service Blueprint

| Field | Value |
|---|---|
| Document ID | SS-PROD-006 |
| Work item | E00-08 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar |
| Product Owner | Kiarash Delavar |
| Approval | Pending explicit Product Owner approval |
| Review date | 2 August 2026 |
| Next review | Before Sprint 1 UI scaffolding and after any approved journey change |
| Required reviewers | Product Owner self-review; independent municipal-domain, service-design, privacy, security, and accessibility review remain pending |
| Controlled baseline | `docs/MASTER_PROJECT_SPEC.md` |
| Related documents | `product-charter.md`, `hero-scenario.md`, `mvp-scope.md`, `glossary.md`, `../architecture/data-flow.md` |
| Release boundary | StreetPulse `v0.1.0-streetpulse-mvp`; later InfraProof concepts are non-MVP |

## 1. Purpose

This blueprint defines how people, interfaces, backend components, data zones, decisions, evidence, and recovery paths work together across the frozen StreetSherlock hero scenario. It is a service-design baseline, not an implementation or compliance claim.

The blueprint protects five rules:

1. Every source `Report` remains independent evidence.
2. An `Incident` and every report-to-incident link are human-owned operational records.
3. AI, spatial/vector retrieval, priority calculation, vision, and n8n provide bounded assistance only.
4. Restricted originals, reporter contact data, derived/redacted data, internal data, public-safe data, and contractor-visible data stay separated.
5. External-service failure never loses an accepted report, silently creates a decision, or removes the manual path.

## 2. Release checkpoints

| Checkpoint | Included service outcome | Explicitly not included |
|---|---|---|
| StreetPulse MVP | Report, privacy boundary, advisory assessment, duplicate candidates, human link decision, deterministic priority recommendation, human priority/state decision, notification intent, public tracking | Previous repairs, computer vision, recurrence, warranty, contractor workflow, liability |
| Later InfraProof | Assigned work, guided evidence, quality feedback, inspection, comparison, possible recurrence, approved contractor communication | Autonomous repair acceptance, liability finding, contractor sanction, invoice/payment, unapproved write-back |
| Pilot/production | Not authorized by this document | Real municipal operations, real personal data, customer-specific policy, production multi-tenancy |

Every demo surface must show the active release tier. Later-release concepts use a visible **Roadmap — not in StreetPulse MVP** label.

## 3. Actors, jobs, and authority

| Actor | Primary job | May decide | Must not receive or decide |
|---|---|---|---|
| Citizen/reporter | Describe, locate, review, submit, track | Whether to submit, correct, join/follow, or leave optional contact | Internal notes, other reporters, final priority, incident link |
| Intake employee | Review privacy status and candidate evidence | Approve/correct safe derivative; accept/reject link candidate when authorized | Automatic-decision framing; unrestricted contact without purpose |
| Case handler | Manage verified incident | Confirm/override priority; perform permitted transition; approve public note | LLM-generated final decisions; contractor liability |
| Privacy reviewer | Resolve unsafe/uncertain derivative | Approve, correct, block publication, request replacement | Delete source evidence merely because publication is blocked |
| Inspector — later | Capture/review evidence and inspect work | Evidence sufficiency and allowed inspection decision | Automatic warranty/liability conclusion |
| Contractor user — later/pilot | Receive assigned work, upload evidence, answer approved requests | Submit response/evidence within assignment | Reporter identity/contact, internal notes, municipal acceptance or liability |
| Governance/manager | Review service health, audit, policies and limitations | Configuration/promotion only through separately authorized controls | Routine unrestricted source content |
| Product Owner | Approve product scope and this design baseline | Portfolio scope and acceptance | Independent municipal, legal, privacy, security or accessibility sign-off |
| Supporting components | Validate, retrieve, calculate, deliver and record evidence | No official operational decision | Direct business-state mutation outside backend commands |

## 4. Data-visibility boundary

| Data class | Citizen/public | Intake/privacy | Case handler | Inspector | Contractor | Governance |
|---|---|---|---|---|---|---|
| Tracking reference | Own reference only | If operationally required | If required | No default access | No | Aggregated metadata only |
| Reporter contact | Own submitted value | Purpose-limited role access | No default access | No | Never | No content; access-event metrics only |
| Restricted original text/media | Own submission preview before send | Explicit authorized access | Only when separately authorized and necessary | Assigned evidence only, not citizen contact | Never | No default content access |
| Derived/redacted report | Own/public-safe subset | Yes | Yes | Incident-relevant subset | Assignment-relevant subset only | Minimized sample only when governed |
| Internal note | Never | Role-dependent | Yes | Assigned-work subset | Never | Audit metadata; content only if separately authorized |
| Public status/timeline | Yes | Yes | Yes | Yes | Assignment-related public status | Yes |
| Candidate factors | No other reporter detail | Yes | Yes | Later recurrence factors only | No | Aggregated/evaluation view |
| Human decision/audit | Own public-safe result | Relevant decision history | Full authorized incident history | Assigned inspection history | Own submission/notice history | Filtered audit and decision provenance |
| AI/model/prompt detail | No; plain limitation only | Assessment provenance | Assessment provenance | Later vision provenance | No internal model detail | Registry/evaluation metadata |
| Contractor evidence | Public only if approved separately | No default | Authorized work context | Yes | Own assignment | Metadata/quality measures |

A UI route, export, log, error message, telemetry event, signed URL, notification, or accessibility label must not bypass this matrix.

## 5. StreetPulse service blueprint — phases A–E

| Lane | A. Understand | B. Describe and locate | C. Add evidence and review | D. Submit and protect | E. Assess and retrieve |
|---|---|---|---|---|---|
| Citizen action | Opens honest product explanation; chooses report or track | Enters Dutch/English description; selects map point or manual address | Optionally uploads media; reviews nearby incidents and complete submission | Confirms submission; stores tracking reference | Waits; may see processing status without internal detail |
| Visible frontstage | Synthetic-demo banner; emergency limitation; language control | Progressive wizard; validation summary; GPS optional; map plus text/list alternative | File checks; upload progress; privacy notice; nearby candidate cards; review screen | Confirmation with reference and recovery guidance | Public tracking says received/under review; no unsupported ETA |
| Intake action | — | — | — | Report appears in bounded queue | Reviews privacy and advisory assessment; continues manually if unavailable |
| Frontstage operations | — | — | — | Queue item shows source/time/category status, not an automatic incident | Report detail shows original/derived only to authorized role; advisory provenance and limitations |
| Backstage process | Load controlled copy/version | Validate required text/location; record language and client validation | Validate signature/MIME/size/dimensions; upload to restricted staging | Transactionally persist report/contact references/correlation; create audit event | Privacy transformation; strict AI contract; deterministic candidate retrieval/scoring |
| Business records | Copy/config version | Draft only until submit | Temporary upload references | `Report`, contact reference, restricted media metadata, audit event | `AssessmentRun`, derived references, `DuplicateCandidate` evidence |
| Supporting systems | Web content/config | Address/map adapter with manual fallback | Object storage adapter; malware/file validation boundary | PostgreSQL + restricted object storage | Privacy adapter, `AiTextProvider`, PostGIS/pgvector, weather fixture |
| Evidence/control | Honest positioning and synthetic label | Field errors associated with controls; no colour-only status | Consent/notice version; checksum; upload validation result | Immutable source time; actor/session; correlation ID | Tool/model/prompt/schema/policy versions; factor values; missing/stale signals |
| Failure/recovery | Content remains usable without animation/map | GPS denied → manual map/address; map unavailable → list/address | Upload failure → preserve text/location and retry/remove file | Network uncertainty → idempotent resubmit/status check | AI/weather unavailable → visible limitation and manual review; privacy uncertain → publication blocked, report preserved |

## 6. StreetPulse service blueprint — phases F–I

| Lane | F. Link decision | G. Priority and state | H. Notify | I. Track and audit |
|---|---|---|---|---|
| Citizen action | No action | No action | Receives approved update at most once if channel provided | Opens tracking page and views public-safe timeline |
| Visible frontstage | Tracking remains “under review” | Tracking exposes only approved public status | Message contains approved public-safe content and no internal factors/contact leak | Status, dates, next public step and contact guidance; no internal note |
| Intake action | Reviews each candidate; accepts `INC-2001`; rejects `INC-2002` | Hands verified incident to case handler | — | Can inspect attributable link history |
| Case-handler action | May review link history | Reviews deterministic factors; confirms/overrides; performs allowed transition; approves public message | May retry failed delivery without changing the decision | Reviews complete incident timeline and provenance |
| Frontstage operations | Candidate cards show factor, source, freshness, missing data and advisory label | Incident page plus explanation drawer separates recommendation from human decision | Workflow/retry screen shows intent, attempts, idempotency and safe error | Audit timeline filters source, assessment, recommendation, decision, state and delivery |
| Backstage process | Backend validates authorization/version and writes accepted/rejected decision | Versioned priority calculation; authorization/state/optimistic-lock validation; append audit; persist notification intent/outbox | n8n adapter sends; signed/idempotent callback records attempt/result | Role-aware projections return public or internal views |
| Business records | `ReportIncidentLink` or rejection record; source reports unchanged | `PriorityRecommendation`, `HumanDecision`, state change, audit, notification intent | Delivery attempt/callback; intent remains backend-owned | Public timeline event and internal `AuditEvent` chain |
| Supporting systems | PostgreSQL/backend command boundary | PostgreSQL/state machine/policy engine | Outbox, n8n, Mailpit/SMTP demo adapter | API authorization, PostgreSQL read models |
| Evidence/control | Actor, reason, time, candidate/factors, old/new link history | Policy version, factors, missing signals, actor, override reason, old/new state, version | Idempotency key, template version, attempt, error class, callback signature | Access result, correlation IDs, provenance links |
| Failure/recovery | Stale candidate → reload without partial link; unauthorized → no mutation | Conflict → reload/compare/reapply; invalid transition → actionable error; policy data missing → human route | n8n down → intent stays pending; retry is explicit; duplicate callback is harmless | Token invalid/expired → no existence leak; partial timeline → label missing source and retry |

## 7. Later InfraProof extension — explicitly outside MVP

| Phase | Inspector/contractor experience | Human authority | Safe failure |
|---|---|---|---|
| Assign work | Inspector sees assigned work; contractor sees only authorized assignment | Municipality assigns work | Integration unavailable → assignment remains backend-visible; no unapproved send |
| Capture evidence | Guided mobile flow shows angle/distance/light guidance and optional ghost overlay | Inspector/contractor decides to retake or submit | Offline → encrypted/local bounded draft only if later approved; otherwise preserve form and retry |
| Quality assistance | Vision may flag blur, glare, occlusion or mismatch | Human decides evidence usability | Vision unavailable/uncertain → manual capture and visible limitation |
| Compare | Authorized viewer compares before/after/current with provenance | Inspector interprets evidence | Bad alignment → refuse comparison; never fabricate overlay |
| Inspect | Checklist and evidence package support decision | Inspector approves/rejects/requests rework | Conflict → no partial state change |
| Recurrence/warranty | System shows possible relation to earlier work/warranty | Authorized municipal/legal/contract owner decides next step | Missing history/terms → no liability inference |
| Contractor response | Contractor receives approved notice and submits bounded response | Municipality owns acceptance and liability | Delivery fails → retry approved intent; no duplicate notice |
| Governance | Evaluation records correction, refusal, override and drift signals | Model/data promotion requires separate review | Model or data issue → disable advisory feature; manual workflow remains |

The contractor never sees reporter contact, restricted citizen media, unrelated reports, internal notes, security configuration, or another contractor’s work.

## 8. Handoffs and service promises

| Handoff | Entry condition | Receiving owner | Required evidence | Unsafe shortcut prohibited |
|---|---|---|---|---|
| Citizen → intake | Report transaction committed | Intake employee | Report ID, source time, privacy/assessment status | Treating draft/upload as accepted report |
| Privacy processing → intake | Safe derivative or review-needed status stored | Privacy/intake role | Transformation version, limitation, object references | Publishing uncertain content |
| Assessment → intake | Validated output or explicit failure stored | Intake employee | Provider/schema versions and error/limitations | Using raw LLM output as truth |
| Candidate engine → intake | Candidate set stored with factors | Intake employee | Inputs, thresholds, missing/stale signals | Automatic linking or deleting reports |
| Intake → case handler | Link/rejection decision committed | Case handler | Actor, reason, time, link history | Silent merge |
| Priority engine → case handler | Recommendation stored | Case handler | Policy/factors/evidence/version | LLM priority or automatic final priority |
| Case handler → notification | State/public message/intent committed together | Delivery operator/adapter | Approved template/content, idempotency key | n8n inventing content or changing state |
| Notification → citizen | Successful callback recorded | Citizen/public projection | Delivery status and public event | Duplicate sends or internal detail |
| Work/evidence → inspector — later | Assigned, authorized evidence exists | Inspector | Chain of custody and quality limitations | Automatic repair acceptance |
| Recurrence → warranty owner — later | Candidate with source history exists | Authorized municipal owner | Contract context, evidence, human decision | Liability or contractor fault inference |

## 9. Journey success and service metrics

Metrics are evidence targets, not current claims.

| Journey | Evidence target |
|---|---|
| Citizen submission | Persisted report exists once after retry/idempotency checks; source inputs remain traceable |
| Privacy | Zero restricted-original objects in public/contractor projections in the bounded verification suite |
| Candidate review | Every accepted/rejected candidate has actor, time, factors and reason where required |
| Priority | Every final priority is separate from recommendation and human-attributable |
| State transition | Unauthorized, invalid and conflicting commands cause no partial mutation |
| Notification | Retry and duplicate callback tests produce at most one citizen message |
| Accessibility | Critical journey is keyboard operable with labelled controls, clear focus/errors and map/list parity |
| AI resilience | Timeout, refusal, malformed output and unavailability preserve manual handling |
| Later vision | Unusable pairs produce a refusal/retake path rather than an unsupported comparison |

## 10. External validation and open questions

This Product Owner review can approve consistency with the portfolio scope. It cannot close:

- municipality-specific intake roles, priority ownership, service levels, wording or route taxonomy;
- lawful basis, privacy notice, consent where applicable, retention, archive, deletion, contact access and data-subject processes;
- actual identity provider, source systems, hosting, network and operational-support boundaries;
- contractor contract, evidence, appeal, rework, warranty and liability rules;
- accessibility conformance, Dutch plain-language quality or assistive-technology results;
- offline storage rules for later field capture;
- emergency-routing content and abuse/spam response;
- production security accreditation, pilot authorization or public-data publication approval.

These remain external-review gaps in the stakeholder and RAID registers.

## 11. Approval record

| Role | Name | Decision | Date | Scope |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Pending | — | Blueprint consistency and portfolio scope |
| Municipal domain owner | Unassigned external reviewer | Pending | — | Workflow/policy truth |
| Privacy/legal reviewer | Unassigned external reviewer | Pending | — | Data use, notice, retention and rights |
| Security reviewer | Unassigned external reviewer | Pending | — | Upload, identity, tokens and trust boundaries |
| Accessibility/service-design reviewer | Unassigned external reviewer | Pending | — | Journey usability and conformance evidence |

Approval of this document does not authorize implementation beyond the active sprint, use of real data, deployment, pilot activity, or compliance claims.
