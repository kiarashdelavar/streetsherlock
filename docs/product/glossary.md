# StreetSherlock Domain Glossary

| Field | Value |
|---|---|
| Work item | E00-03 |
| Sprint | Sprint 0 — Product freeze and discovery |
| Document owner | Kiarash Delavar, Product Owner |
| Domain steward | Product Owner until a municipality assigns a domain owner |
| Version | 0.1 |
| Status | Proposed |
| Controlled baseline | [Master Project Specification v2.0](../MASTER_PROJECT_SPEC.md) |
| Related documents | [Product Charter v1.0](product-charter.md), [Hero Scenario v1.0](hero-scenario.md), [MVP Scope v1.0](mvp-scope.md) |
| Last updated | 2 August 2026 |

## 1. Purpose

This glossary is the controlled language for StreetSherlock product, domain, API, data, AI, UX, audit, test, and operational work. It prevents teams from giving the same word different meanings or using an AI recommendation as if it were an official municipal decision.

The glossary defines logical domain meaning. It does not freeze physical database tables, API payloads, Dutch translations, municipality-specific policy, retention periods, legal conclusions, or contractor terms.

If implementation, UI text, an event, a requirement, or another document conflicts with this glossary, the conflict must be resolved through an explicit domain decision. Teams must not silently redefine a term.

## 2. Normative language and precedence

- **Must** and **must not** describe mandatory product rules.
- **May** describes permitted behaviour.
- **Should** describes a preferred rule that needs a recorded reason to override.
- Canonical domain terms use `PascalCase` in technical models and the exact English label in documentation.
- User-facing Dutch or plain-English labels may be simpler, but each label must map to one canonical term.
- Product Charter v1.0 controls product authority and non-goals.
- Hero Scenario v1.0 and MVP Scope v1.0 control the release boundary.
- This glossary controls term meaning and logical relationships.
- Later accepted ADRs control technical implementation without changing domain meaning.

## 3. Core semantic decision

> A `Report` is one independently traceable observation received from a person or source system. An `Incident` is the municipality's human-owned operational representation of one real-world public-space problem.

StreetSherlock may recommend that a report relates to an incident. It must not silently merge, delete, replace, or operationally link reports.

### 3.1 Report versus Incident

| Dimension | `Report` | `Incident` |
|---|---|---|
| Represents | What one source observed or requested at a particular time | One real-world public-space problem being investigated or managed |
| Created from | Citizen submission, staff entry, or approved import | Authorized human action, approved workflow rule, or controlled import requiring review |
| Identity | Stable source observation identity | Stable municipal problem identity |
| Authority | Evidence/input; never the final operational conclusion | Human-owned operational case representation |
| Cardinality | May remain unlinked or support one active primary incident in the MVP | May be supported by zero, one, or many reports |
| History | Original meaning and provenance remain traceable | State changes and decisions remain traceable |
| Correction | New version or correction record; never silent overwrite | New decision/state transition; never silent history rewrite |
| Duplicate handling | May receive duplicate candidates | May become a candidate target for a report |
| Closure | A report can finish processing without erasing its evidence | An incident can be resolved, reopened, or archived |
| Retention | Controlled by lawful retention and source obligations | Controlled by lawful municipal case/asset policy |
| Public visibility | Only approved, minimized, public-safe fields | Only approved public-safe status and timeline fields |
| MVP ownership | Report aggregate | Incident aggregate |

### 3.2 Cardinality and linking rules

- An incident may exist with no citizen report, for example after an authorized staff inspection or controlled import.
- An incident may be supported by many reports.
- In the StreetPulse MVP, a report may have zero or one active **primary** `ReportIncidentLink`.
- A report may have several historical link records because a human can reverse or correct a decision.
- Rejected duplicate candidates are retained as assessment evidence; they do not become operational links.
- Future secondary/supporting relations require a separate approved domain decision.
- A report must not be deleted, hidden, or marked resolved merely because it is linked to another report or incident.
- Lawful deletion, anonymization, restriction, or archival duties remain possible; they must use explicit privacy/records procedures and must not masquerade as duplicate handling.

## 4. Domain ownership and aggregate boundaries

An **aggregate root** is the domain object through which rules and state changes for a consistency boundary are authorized. This is a logical boundary, not a promise that every aggregate becomes one table or service.

| Aggregate root | Owns or governs | Does not own |
|---|---|---|
| `Report` | Report content versions, processing state, report media references, source provenance references | Reporter contact lifecycle, incident state, official duplicate decision |
| `ReporterContact` | Restricted contact details, contact preference, consent/notice evidence where applicable | Public report content |
| `MediaAsset` | Stored object identity, media role, visibility/classification, checksums, transformation links | Human interpretation of the defect |
| `Incident` | Incident state, category, geometry, assigned handling context, active report links, incident relations | Original reports or their source truth |
| `AssessmentRun` | Versioned inputs, outputs, evidence references, uncertainty, model/prompt/policy provenance, run state | Official municipal decision |
| `PriorityPolicyVersion` | Versioned deterministic rules and factor definitions | The incident's final operational priority |
| `StreetWork` | Work footprint, planned/completed context, external references | Automatic proof of defect cause |
| `WorkOrder` | Authorized instruction and work lifecycle | Inspection acceptance or contractual liability |
| `Repair` | Recorded remedial work, repair lifecycle, associated evidence | Proof that the problem is fully resolved |
| `Inspection` | Human checklist, evidence review, findings, official inspection outcome | Model output as final acceptance |
| `Warranty` | Configured contractual window/context after an accepted repair | Automatic fault or payment decision |
| `WarrantyCase` | Human review of possible recurrence in warranty context | Automatic liability finding |
| `NotificationIntent` | Intended message, recipient channel reference, template/version, business status | External delivery provider truth |

Detailed transaction boundaries, optimistic locking, APIs, and database ownership will be decided in architecture work.

## 5. Actors and authority

### `Reporter`

A person or approved source that submits an observation. A reporter may be identified, pseudonymous, anonymous, or represented by an external system according to the approved intake policy.

A reporter is not automatically the owner of the incident and does not make the municipal handling decision.

### `MunicipalEmployee`

An authenticated person acting under a municipal role and authorization. This umbrella term must be narrowed to a real role, such as intake employee, case handler, inspector, administrator, or auditor, when permissions differ.

### `IntakeEmployee`

A municipal employee authorized to review incoming report processing, privacy status, structured assessment, and duplicate candidates. Authorization to link reports must be explicit.

### `CaseHandler`

A municipal employee authorized to manage incident state, confirm or override priority, record reasons, assign follow-up where permitted, and approve citizen-facing status updates.

### `Inspector`

An authorized human who reviews repair or site evidence against an approved checklist or policy and records an official inspection outcome. A vision model is never an inspector.

### `FieldWorker`

A person authorized to receive minimum necessary work information and capture field or repair evidence. The role does not automatically include access to reporter contact data or inspection authority.

### `Contractor`

An external organization or authorized user performing assigned work. Contractor access is assignment-bound and must not expose reporter contact data unless a separately approved lawful need exists.

The term does not mean that the contractor caused a defect or is liable for it.

### `ProductOwner`

The person accountable for product boundary, backlog priority, acceptance, and unresolved product decisions. Product approval is not legal, privacy, security, accessibility, or municipal policy approval.

## 6. StreetPulse report and privacy terms

### `ReporterContact`

Restricted contact information kept separately from report content so access, retention, deletion, and communication rules can be controlled independently.

It must not be copied into public report text, contractor views, analytics exports, embeddings, prompts, or public URLs.

### `Report`

One submitted or imported observation/request with stable identity, source, received time, location/context, category input, text versions, media references, and processing history.

A report is evidence and input. It is not an incident, confirmed defect, work order, repair, or proof of liability.

### `ReportTextVersion`

An append-only version of report text or its approved redacted/normalized representation. It records why, when, and by whom or what process the version was created.

A normalized or translated version must not silently replace the original meaning.

### `MediaAsset`

A stored media object and its controlled metadata, such as an original image, redacted derivative, thumbnail, evidence image, or generated visualization.

A media asset is not automatically public and is not itself an assessment or inspection decision.

### `PrivacyTransformation`

A recorded transformation applied for privacy or safe use, such as metadata removal, face/licence-plate redaction, cropping, or generation of a public-safe derivative.

It must record input, output, method/version, status, review requirement, and failure. A failed or uncertain transformation must not make the original public.

### `PublicSafeRepresentation`

A specifically approved minimized derivative that may be exposed to the intended public audience. “Processed” does not automatically mean public-safe.

### `RestrictedOriginal`

Original content whose access is limited because it may contain personal, sensitive, security-relevant, licensed, or unnecessary information. It must not be exposed through public object URLs or broad roles.

### `ReportProcessingState`

The visible lifecycle of intake and analysis, including received, privacy processing, analysing, needs review, analysis ready, linked/creates incident, and archived states.

An AI failure is a recoverable processing condition, not loss or rejection of the report.

## 7. Incident and relationship terms

### `Incident`

The human-owned municipal representation of one real-world public-space problem with stable identity, location/geometry, category, state, priority decision, relationships, and traceable history.

An incident is not a collection produced by an automatic merge, and it is not proof that every linked report is correct.

### `ReportIncidentLink`

The auditable operational relationship stating that a report supports a particular incident. In the MVP it is created, rejected, changed, or removed only through an authorized `HumanDecision`.

The record must preserve:

- report and incident identities;
- link type and active/historical status;
- actor identity and role;
- decision reason;
- decision time;
- assessment run and duplicate candidate, when relevant;
- score/factor snapshot shown to the reviewer;
- previous link state;
- reversal/unlink reason and history.

Removing an active link creates history; it must not erase the earlier decision.

### `IncidentRelation`

A typed, human-reviewed relation between incidents, for example “possible recurrence of,” “spatially related to,” or “supersedes.” It must not be used as a hidden substitute for merging incidents.

### `ExternalRecord`

A reference to an object in a source system, including system identity, source ID, observed version, sync status, and provenance. StreetSherlock does not become the authoritative owner of the external object merely by storing the reference.

### `Asset`

A managed public-space object or network segment, such as a streetlight, drain, tree, bench, road segment, pavement, or cycle-path segment.

A location near an asset does not prove the asset caused the incident.

### `Location`

A reported or verified point, line, polygon, address, or textual place reference with source and confidence/verification status. Reported and verified locations must remain distinguishable.

### `DemoCategory`

One of the six frozen cross-cutting demo categories:

1. road/cycle surface;
2. pavement/sidewalk;
3. drain/waterlogging;
4. tree/branch;
5. streetlight;
6. street furniture.

A category supports routing and assessment; it is not a conclusion about cause, responsibility, or required work.

## 8. Assessment, AI, recommendation, and decision terms

### `AssessmentRun`

An immutable/versioned execution that evaluates defined inputs and records status, outputs, uncertainty, evidence, model/prompt/policy versions, dataset or retrieval provenance, timing, and failure details.

A new run supersedes for presentation only through an explicit rule; it never overwrites the old run and never becomes an official decision.

### `AssessmentEvidence`

A traceable input or derived factor used by an assessment, including source, value, time, quality, and access classification. Evidence may support a recommendation without proving it.

### `DuplicateCandidate`

An advisory proposition that a report may relate to an existing incident, with candidate identity, factor explanation, score, threshold/version, missing evidence, and assessment provenance.

A duplicate candidate is not a duplicate, merge, link, closure, or rejection. Low score is not proof that no relation exists.

### `DuplicateScore`

A bounded ranking value produced from defined factors such as spatial, temporal, category, semantic, asset, or verified context. It supports reviewer ordering and explanation.

The score must not be displayed as certainty, probability, or truth unless it is validly calibrated and documented for that meaning.

### `PriorityPolicyVersion`

An immutable version of municipality-approved deterministic priority rules, factor definitions, thresholds, and effective period.

StreetSherlock may provide a demo policy, but it must be labelled synthetic and not presented as Deventer or another municipality's policy.

### `PriorityRecommendation`

A versioned advisory result calculated from verified factors and a `PriorityPolicyVersion`, including explanation, missing inputs, and limitations.

It is not the final operational priority. An authorized human must confirm or override it with a recorded reason.

### `HumanDecision`

An attributable, authorized, reasoned, timestamped action by a human that accepts, rejects, changes, reverses, or overrides a recommendation or operational state.

A human decision must preserve the recommendation/evidence shown at the time. Corrections create a new decision; they do not overwrite history.

### `ManualFallback`

A safe workflow that lets authorized staff continue when AI, an integration, a data source, or automation is unavailable or unsuitable. It must not invent assessment output and must preserve the failure and later retry state.

### `Confidence`

A precisely defined measure attached to a particular output and version. The term must not be used without explaining what it measures and how it was obtained.

“High confidence” must never be shorthand for authorized, correct, legally valid, or safe to act automatically.

### `Uncertainty`

Known limitations, missing information, disagreement, quality concerns, or model ambiguity presented with an assessment. Uncertainty must remain visible at the human decision point.

## 9. InfraProof terms for later releases

These terms belong to later InfraProof releases unless the MVP uses read-only synthetic context. Their definition does not authorize implementation in `v0.1.0-streetpulse-mvp`.

### `StreetWork`

Planned or completed activity affecting a defined public-space footprint and period, with source and external references.

Spatial or temporal overlap with an incident is context, not proof of causation.

### `WorkOrder`

An authorized instruction to perform defined work, including scope, assignment, lifecycle, and references. It is not proof that work was completed or accepted.

### `Repair`

Recorded remedial work intended to address a problem, with lifecycle, footprint, timing, performer, method/context, and evidence references.

A repair record is not proof of quality, resolution, or warranty liability.

### `EvidenceCapture`

A traceable capture session or submission that records media, location/time, capture guidance, quality checks, source device/context where approved, and uploader identity/role.

Passing automated quality checks does not make evidence true, sufficient, or accepted.

### `Inspection`

A human review of a site, repair, or evidence package against an approved checklist or policy, producing an attributable official outcome.

Automated visual output may assist but cannot accept or reject a repair.

### `VisionAssessment`

A versioned advisory computer-vision run that may assess quality, alignment, change, or narrow defect signals and may refuse unsuitable inputs.

It is not an inspection, measurement certificate, proof of structural integrity, or liability decision.

### `DefectObservation`

A bounded observation of a possible defect feature made by a human or system, with observer type, location, time, method, evidence, and uncertainty.

It is not automatically a confirmed defect or incident.

### `Warranty`

Configured contractual context, scope, conditions, and time window associated with an accepted repair. The actual terms and authority belong to the municipality and contract.

A warranty is not a fault finding and must not be inferred from generic assumptions.

### `WarrantyCase`

A human-reviewed case that investigates possible recurrence in configurable warranty context. Its states may include possible recurrence, under review, claim open, not related, monitoring, rework in progress, resolved, and closed.

Opening a warranty case does not establish causation, breach, fault, contractor liability, payment, or sanction.

### `PossibleRecurrence`

An advisory relation indicating that a current incident may resemble or overlap an earlier incident/repair within defined spatial, temporal, category, asset, or visual context.

The mandatory qualifier **possible** must remain until an authorized process reaches a supported conclusion.

## 10. Workflow, notification, provenance, and audit terms

### `OutboxEvent`

A durable business event record written with the authoritative state change so external processing can occur reliably. Delivery failure must not roll back or invent the business decision.

### `WorkflowExecution`

A recorded automation attempt, such as an n8n workflow execution, with correlation, status, retry, and result. It is operational evidence, not the source of municipal business truth.

### `NotificationIntent`

The authoritative business instruction that a particular approved message should be sent through a defined channel/template/version to an eligible recipient.

It contains the minimum necessary communication reference and must not expose restricted data to the workflow engine without approval.

### `DeliveryAttempt`

One provider/channel attempt to deliver a `NotificationIntent`, including status, time, provider reference, failure, and retry relation.

“Sent” and “delivered” must remain distinct where the provider supports that distinction.

### `AuditEvent`

An append-only security/governance record of a relevant action, access, decision, configuration change, or system event with actor/service, time, target, action, outcome, and correlation.

An audit event is not a substitute for the domain record or an editable activity note.

### `DomainEvent`

A versioned fact that something meaningful occurred in the business domain. Event names use past tense, such as `ReportReceived` or `IncidentPriorityConfirmed`.

A command or recommendation must not be named as if the action already happened.

### `DatasetSnapshot`

An immutable identified version of approved data used for fixtures, retrieval, evaluation, training, or demonstration, with source, date, scope, licence/terms, transformations, and checksum/version.

### `SourceProvenance`

Traceable information describing where data or evidence came from, under which terms, when it was observed, how it was transformed, and which version was used.

### `CorrelationId`

A non-secret identifier used to trace related requests, events, assessments, workflows, and logs. It must not contain personal data.

## 11. Authority matrix

| Activity | Advisory/system output | Required authority |
|---|---|---|
| Structure report text | Suggested fields with provenance/uncertainty | Human correction when handling is affected |
| Redact media | Transformation result and review status | Approved privacy rule; human review when uncertain |
| Find possible duplicate | `DuplicateCandidate` | Authorized human creates/rejects/reverses `ReportIncidentLink` |
| Recommend priority | `PriorityRecommendation` | Authorized human confirms/overrides final operational priority |
| Change incident state | Valid transition options | Authorized municipal role |
| Connect incident to work/repair | Possible contextual relation | Authorized human review |
| Assess images | `VisionAssessment` or refusal | Inspector owns official inspection outcome |
| Identify possible recurrence | `PossibleRecurrence` | Authorized human decides next case action |
| Open/decide warranty case | Context and evidence summary | Authorized municipal/contractual process |
| Notify citizen | `NotificationIntent` and delivery status | Approved business event/template and communication policy |
| Write to external municipal system | Prepared integration intent only | Separate approved integration authority; disabled in MVP/shadow mode |

## 12. Required language and prohibited shortcuts

| Do not use | Use instead | Reason |
|---|---|---|
| “The AI merged the reports” | “The system recommended a candidate; an authorized employee linked the report to the incident” | Preserves human authority and source reports |
| “Duplicate report” before review | “Possible duplicate” or `DuplicateCandidate` | Candidate is not a conclusion |
| “AI priority” or “final AI priority” | “Versioned priority recommendation” | Final priority is human-owned |
| “The contractor caused it” | “Possible relation to earlier work/repair” | Context does not prove causation |
| “Warranty violation” from a model | “Possible recurrence in warranty context” | No automatic contractual conclusion |
| “Repair passed AI inspection” | “Vision assessment available; inspector decision pending/recorded” | A model is not an inspector |
| “Anonymous data” without proof | “Pseudonymized,” “redacted,” “minimized,” or “public-safe,” as applicable | These states have different meanings |
| “Public image” after processing | “Public-safe derivative approved for the intended audience” | Processing alone is insufficient |
| “Confidence” without definition | Named score/factor with method and limitation | Avoids false certainty |
| “Deventer policy/data” for fixtures | “Synthetic Deventer scenario” or named licensed public snapshot | Avoids false partnership/authority |
| “Resolved report” when an incident is closed | State the report processing state and incident state separately | Lifecycles differ |
| “Audit log is the source of truth” | Name the authoritative domain record and related audit event | Audit supports, not replaces, domain truth |

The terms “match,” “confirmed,” “verified,” “accepted,” “compliant,” “safe,” and “anonymous” require a named actor, method, policy, and scope.

## 13. Naming across interfaces and code

### 13.1 API and schema

- API resources and schema names must map one-to-one to canonical terms.
- Identifiers must be explicit, for example `reportId` and `incidentId`; generic `caseId` is prohibited unless the domain object is defined.
- Advisory records use names such as `duplicateCandidate` and `priorityRecommendation`, not `duplicate` or `priorityDecision`.
- Human-authoritative actions use explicit commands such as `linkReportToIncident`, `rejectDuplicateCandidate`, or `confirmIncidentPriority`.
- Unlink/reversal is a new action with reason and history, never a hard delete of the link decision.
- External identifiers must include source-system context.
- Reported, derived, recommended, verified, and decided values must not share one ambiguous field.

### 13.2 Events

- Events are past-tense facts: `ReportReceived`, `DuplicateCandidateGenerated`, `ReportLinkedToIncident`, `IncidentPriorityConfirmed`.
- Recommendations must not emit an event that implies human acceptance.
- Event payloads use minimum necessary data, stable identifiers, schema versions, provenance, and correlation IDs.
- Public events must not contain reporter contact data or restricted media locations.

### 13.3 UI and accessibility

- UI may display “Report” and “Incident” with a short plain-language explanation.
- A recommendation must be visually and semantically different from a decision.
- Score, reason, missing information, uncertainty, and model/policy version must be available to the reviewer.
- Status must not be communicated by colour alone.
- Translation must preserve the Report/Incident distinction; the Dutch labels require municipal/user validation.
- Contractor and public views must not expose reporter identity or restricted originals.

## 14. Examples and counterexamples

### Example A — several reports, one incident

Three citizens submit separate reports about standing water and loose paving on the same synthetic cycle-path segment. StreetSherlock produces candidates with explanations. An intake employee links two reports to an existing incident and rejects the third candidate because it describes a different drain.

Result:

- all three reports keep their identities and history;
- one incident has two active supporting report links;
- the rejected candidate remains assessment evidence;
- no report is deleted or silently closed.

### Example B — one report, new incident

No suitable candidate exists or the employee rejects all candidates. The employee creates a new incident from the report through an authorized decision.

Result:

- the report remains the original observation;
- the new incident becomes the operational problem record;
- the link, actor, reason, and evidence snapshot are recorded.

### Example C — corrected link

A case handler discovers that a report was linked to the wrong incident. The handler removes the active link with a reason and links the report to the correct incident.

Result:

- both decisions remain in history;
- the original report is unchanged;
- current state shows only the correct active primary link.

### Example D — possible warranty recurrence

A later incident overlaps an accepted repair footprint and occurs within configured warranty context. The system creates a possible-recurrence recommendation.

Result:

- no contractor fault or liability is declared;
- an inspector or authorized case handler reviews evidence;
- a warranty case opens only through an authorized human process.

### Counterexamples

The following behaviours violate this glossary:

- a similarity score automatically moves a report into an incident;
- linking deletes or hides the report;
- a model writes the final priority;
- a workflow engine becomes the only record of a status change;
- an image-quality pass is treated as repair acceptance;
- proximity to street work is presented as proof of causation;
- a warranty case automatically triggers sanction, payment, or invoice action;
- a public timeline exposes reporter contact data or an unrestricted original image.

## 15. External validation questions

The glossary deliberately does not guess:

- municipality-specific Dutch labels and team/role names;
- which roles may create, reverse, or approve each link and state transition;
- lawful basis, retention, archival, deletion, restriction, and data-subject procedures;
- municipal priority ownership, service-level definitions, and override policy;
- authoritative source systems and identifiers;
- records-management meaning of report, melding, incident, zaak, asset, work order, and inspection;
- contractor evidence access, appeal, rework, and dispute processes;
- actual warranty clauses, start event, scope, and decision authority;
- evidence standards for inspection and repair acceptance;
- requirements for communicating uncertain or changed decisions to citizens.

Each question needs a named municipal/legal/privacy/security/accessibility owner before a pilot or production claim.

## 16. Change control and conformance

A proposed new term or changed meaning must include:

1. problem and examples;
2. current and proposed definition;
3. affected requirements, entities, APIs, events, UI labels, tests, analytics, and documents;
4. migration/compatibility impact;
5. privacy, authorization, audit, AI, accessibility, and external-integration impact;
6. Product Owner and relevant domain-owner decision.

A work item conforms only when:

- canonical terms are used consistently;
- advisory and authoritative records are separate;
- original reports and decision history remain traceable;
- human authority and reversal paths are explicit;
- restricted/public data language is accurate;
- future InfraProof concepts are not presented as StreetPulse MVP capability;
- limitations and external validation needs are visible.

## 17. Acceptance review

| Criterion | Draft result | Evidence |
|---|---|---|
| Clear definitions and confusion boundaries | Pass | Sections 3–10 |
| Report/Incident identity, lifecycle, cardinality, and ownership | Pass | Sections 3–4 and 7 |
| Advisory assessment versus human decision | Pass | Sections 8 and 11 |
| Reversible, attributable report linking | Pass | Sections 3.2 and 7 |
| StreetPulse versus InfraProof separation | Pass | Sections 6–9 |
| Safe warranty/causation/liability language | Pass | Sections 9 and 12 |
| Canonical/prohibited terminology | Pass | Sections 2, 12, and 13 |
| Examples and counterexamples | Pass | Section 14 |
| External unknowns recorded | Pass | Section 15 |
| Product Owner approval | Pending | Section 18 |

## 18. Approval record

| Role | Name | Decision | Date | Conditions/notes |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Pending | — | Review E00-03 and record an explicit approve or change decision. |
| Municipal domain representative | Unassigned | Pending external validation | — | Required before municipality-specific or pilot claims. |
| Privacy/legal reviewer | Unassigned | Pending external validation | — | Required before personal-data or retention claims. |
| Security reviewer | Unassigned | Pending external validation | — | Required before production-readiness claims. |
| Accessibility reviewer | Unassigned | Pending external validation | — | Required before accessibility-conformance claims. |

Approval of this glossary freezes product vocabulary for the next Sprint 0 tasks. It does not constitute legal, privacy, security, accessibility, procurement, contractual, or municipality-specific approval.
