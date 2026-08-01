# StreetSherlock Product Charter

| Field | Value |
|---|---|
| Work item | E00-01 |
| Sprint | Sprint 0 — Product freeze and discovery |
| Document owner | Kiarash Delavar, Product Owner |
| Version | 1.0 |
| Status | Approved |
| Controlled baseline | [Master Project Specification v2.0](../MASTER_PROJECT_SPEC.md) |
| Last updated | 1 August 2026 |

## 1. Purpose

This charter defines why StreetSherlock exists, who it serves, which outcome it aims to create, and where its authority stops. It is the product boundary for later requirements, architecture, design, implementation, evaluation, and portfolio claims.

If a later proposal conflicts with this charter or the controlled Master Project Specification, it must be changed or approved through an explicit product decision. Convenience is not a reason to weaken privacy, authorization, auditability, human oversight, or the non-goals below.

## 2. Product definition

**StreetSherlock** is a privacy-first urban incident-intelligence and repair-assurance platform for Dutch municipalities.

It has two product modules:

- **StreetPulse NL** connects fragmented public-space reports and context into human-reviewed incident recommendations.
- **InfraProof AI** connects incidents to street works, repair evidence, inspections, recurrence signals, and configurable warranty context.

StreetSherlock is an integration and intelligence layer around existing municipal systems. It does not replace the systems that receive reports, manage assets, register cases, plan work, or operate contractor processes.

### One-line vision

> Help Dutch municipalities turn fragmented public-space information into explainable, traceable, and human-owned incident and repair decisions.

## 3. Problem statement

Dutch municipalities already receive public-space reports through systems such as Signalen, Fixi, BuitenBeter, and municipal portals. The main product opportunity is therefore not another report form.

The deeper operational problems are:

- several reports may describe one real street problem but remain separate across channels, categories, teams, or systems;
- an incorrect automatic merge can hide an unresolved citizen problem;
- priority decisions may be inconsistent or difficult to explain when location, accessibility, weather, asset, and work context are checked manually;
- a new defect may be related to earlier street work or a recently accepted repair, while the relevant records are disconnected;
- before-and-after evidence may be inconsistent, difficult to compare, or unsafe to publish;
- staff need a reliable history of the evidence, policy version, system recommendation, human decision, and later correction;
- low reporting volume may reflect under-reporting and must not be treated as proof that an area has no problems.

StreetSherlock addresses these gaps while preserving the existing municipal source systems and the authority of municipal employees.

## 4. Product vision

A municipal employee should be able to open one trustworthy incident view and understand:

- which source reports may refer to the same real-world problem;
- why the system considers them related;
- which evidence is verified, missing, restricted, or uncertain;
- which municipal policy factors produced a priority recommendation;
- whether nearby assets, planned works, earlier repairs, inspections, or warranty windows may be relevant;
- who made the official decision, why it was made, and what changed later.

The system should reduce manual searching and fragmented triage without hiding uncertainty or transferring public authority to an AI model.

## 5. Target users

### Primary users

| User | Need |
|---|---|
| Intake employee | Review privacy processing, structured report analysis, and possible duplicate incidents. |
| Case handler | Confirm the incident, apply municipal policy, update status, assign follow-up, and communicate safely. |
| Municipal inspector | Review comparable repair evidence and make an official accept, reject, or rework decision. |
| Field worker | Receive the minimum required task information and capture usable evidence. |
| Operations manager | Understand queue, recurrence, workload, service, and quality patterns without misleading certainty. |
| Municipality administrator | Configure categories, policies, thresholds, users, retention, and integration settings with version history. |

### Supporting and governed users

- Citizen or anonymous reporter.
- Contractor user with assignment-only access and no reporter contact data.
- AI/data steward.
- Privacy officer or Data Protection Officer.
- Security/audit reviewer.
- Platform operator.
- Municipal integration owner.

Actual roles, permissions, and municipal policy ownership require validation with a design-partner municipality.

## 6. Value for municipalities

StreetSherlock aims to provide five connected forms of value:

1. **Less fragmented triage:** show likely relationships between reports while preserving every source report.
2. **More explainable handling:** show the factors, missing information, policy version, and human override behind a recommendation.
3. **Stronger street memory:** connect incidents with assets, works, repairs, inspections, and possible recurrence.
4. **Better evidence quality:** guide capture and review while separating restricted originals from safe derived/public media.
5. **Safer integration:** generate recommendations and workflow intents around existing systems without making AI or n8n the business source of truth.

These are value hypotheses. They must be measured with synthetic/open-data scenarios first and, if authorized, through a read-only municipal shadow pilot. This charter does not claim proven savings or customer adoption.

## 7. Positioning and product boundary

### StreetSherlock is

- an incident-intelligence and repair-assurance layer;
- a decision-support product with explainable evidence;
- an API-first component designed for replaceable municipal integrations;
- a privacy-, security-, accessibility-, and audit-aware portfolio prototype;
- a future candidate for a read-only shadow pilot after the required reviews.

### StreetSherlock is not

- a replacement for Signalen, Fixi, BuitenBeter, a municipal portal, a zaaksysteem, a BOR/asset system, or contractor ERP;
- a system that owns municipal policy or legal interpretation;
- an autonomous decision maker;
- evidence that a contractor is at fault;
- production-ready, certified, or compliant merely because controls are documented.

A thin report intake may exist in the demo so the end-to-end flow is understandable. It is not the commercial differentiator.

## 8. Core product semantics

| Concept | Product meaning |
|---|---|
| **Report** | One submitted observation or request from a person or source system. It remains independently traceable evidence. |
| **Incident** | The municipal representation of one real-world public-space problem. It may be supported by zero, one, or many reports. |
| **Assessment** | A versioned system or AI recommendation with inputs, evidence, uncertainty, and provenance. It is not an official decision. |
| **Decision** | An authorized, attributable, and auditable human action that changes operational state or accepts/rejects a recommendation. |
| **Street work** | Planned or completed activity affecting a defined public-space area. It is context, not automatic proof of causation. |
| **Repair** | Recorded work intended to resolve an issue, with evidence and lifecycle state. |
| **Inspection** | A human review against an approved checklist or policy. |
| **Warranty case** | A human-reviewed case concerning possible recurrence within a configurable contractual context; it is not automatic liability. |

The central rule is:

> A Report is evidence submitted by a source. An Incident is a human-owned operational representation of a real-world problem. StreetSherlock may recommend a link, but it never silently merges them.

Detailed vocabulary and aggregate rules belong to E00-03.

## 9. First MVP scope

The first bounded release is the **StreetPulse NL vertical MVP**. It proves one complete and safe workflow:

1. Receive a demo or imported public-space report.
2. Validate the submission and separate contact data, restricted originals, derived data, and public-safe output.
3. Produce a structured advisory assessment or a clear manual fallback.
4. Retrieve and explain possible related incidents using bounded spatial, temporal, category, and semantic evidence.
5. Let an authorized employee accept, reject, or reverse a report-to-incident link.
6. Calculate an explainable, deterministic, versioned priority recommendation from verified factors.
7. Let an authorized employee confirm or override the recommendation with a reason.
8. Update incident status through an authorized state transition.
9. Record provenance, system recommendations, decisions, overrides, and public-safe timeline events.
10. Create a reliable citizen-update intent and record delivery status without making the workflow engine the source of truth.

The MVP uses synthetic Deventer scenarios and approved public-data snapshots. It does not imply that Deventer, Amsterdam, or another municipality is a customer or partner.

## 10. Later product scope

**InfraProof AI** begins only after the StreetPulse MVP and its product boundaries are stable. Later increments may add:

- street work, work order, contractor, repair, inspection, evidence, warranty, and recurrence entities;
- guided mobile evidence capture;
- privacy review and image-quality gates;
- advisory before/after/current image alignment and change overlays;
- possible recurrence candidates linked to earlier repair footprints;
- inspector-owned accept, reject, rework, or warranty-case decisions;
- bounded Dutch open-data and municipal adapter context.

Computer vision must be able to refuse unsuitable evidence. A model output can support an inspection but cannot prove repair quality, causation, contractual liability, or legal compliance.

## 11. Explicit non-goals

StreetSherlock will not initially build or claim:

- nationwide replacement of existing reporting, case, asset, works, or contractor systems;
- autonomous report merging or deletion of source reports;
- LLM-generated final priority;
- autonomous assignment, repair acceptance, warranty decision, contractor sanction, invoice approval, payment, or external-system write-back;
- emergency-service dispatch, policing, enforcement, facial recognition, person identification, or behaviour prediction;
- demographic profiling or allocation of service based on protected traits;
- a general-purpose smart-city digital twin;
- production multi-tenancy in the first four-week MVP;
- real KLIC ingestion without lawful access and an approved customer context;
- reliable measurement of depth, slope, compaction, structural integrity, causation, or legal compliance from one phone image;
- drone, robotics, IoT, or vehicle-camera hardware in the MVP;
- Redis, Kafka, Kubernetes, a service mesh, or artificial microservices without a measured need;
- claims of full GDPR, BIO2, WCAG/EN 301 549, AI Act, security, or production compliance without independent evidence.

## 12. Human and system authority

| Activity | System may do | Authorized human must do |
|---|---|---|
| Structured report understanding | Extract and suggest structured fields; show uncertainty or fail safely. | Correct or confirm information when it affects handling. |
| Possible duplicate handling | Retrieve candidates and explain contributing factors. | Accept, reject, or reverse the report-to-incident link. |
| Priority | Calculate a deterministic recommendation from verified policy factors. | Confirm or override the operational priority with a reason. |
| Incident workflow | Validate allowed transitions and propose next actions. | Perform official state changes and assignments. |
| Repair evidence | Check capture quality, align images, and highlight possible changes. | Decide whether evidence is sufficient and accept/reject/request rework. |
| Recurrence/warranty | Find spatial/temporal overlap and show contractual context. | Decide recurrence, warranty handling, liability, or contractor action. |
| Notifications | Create a versioned intent and retry delivery idempotently. | Approve policy/templates and any exceptional communication. |
| External integration | Prepare validated import/export or a disabled write-back proposal. | Authorize each operational integration and side effect. |

Non-negotiable rules:

- PostgreSQL remains the business source of truth.
- An LLM never directly mutates incidents, priorities, work orders, warranties, contractor status, payments, or external systems.
- AI uncertainty, timeout, malformed output, or unavailability must lead to refusal or a usable manual path.
- Every operational recommendation is versioned and attributable.
- Every official decision is attributable to an authorized human.
- Links and overrides are reversible and auditable.

## 13. Product principles

1. **Human authority over automation.**
2. **Evidence before certainty.**
3. **Preserve source reports and decision history.**
4. **Privacy boundaries before public convenience.**
5. **Safe manual handling when AI or integrations fail.**
6. **Explainable municipal policy before opaque scoring.**
7. **One reliable vertical slice before platform expansion.**
8. **Recorded fixtures before demo dependence on live external APIs.**
9. **Accessible, plain operational language.**
10. **Honest prototype and pilot claims backed by evidence.**

## 14. Success measures

### MVP release gates

The MVP is successful only if the bounded hero flow demonstrates:

- 100% of report-to-incident link decisions require and record an authorized human action;
- 100% of final priority confirmations or overrides record actor, reason where required, policy version, and evidence;
- 0 restricted-original media objects are exposed through public output in the verification suite;
- AI timeout, malformed output, and unavailability all preserve a manual handling path;
- every recommendation shown to a user includes its type, status, version/provenance, and relevant factors or limitations;
- notification retries produce no duplicate citizen message in the idempotency test;
- the end-to-end hero scenario works with real persistence and no hardcoded operational decision in the UI.

### Measures to baseline and validate

The project will measure, without claiming an improvement before comparison data exists:

- median report triage time;
- time from first report to the correct incident or department;
- duplicate candidate precision at k, acceptance rate, and reversal rate;
- priority override rate and reasons;
- citizen-update coverage for linked reports;
- privacy-redaction recall and publication-block rate on a bounded test set;
- p95 latency, timeouts, failures, and recovery;
- workflow delivery success and duplicate-send count;
- later, evidence retake rate, comparison success, and accepted possible-recurrence rate.

Numeric pilot targets will be approved only after a baseline, representative data, and municipal ownership are available.

## 15. Assumptions

The current charter assumes:

- a municipality can provide a read-only export or approved API access for a future shadow pilot;
- municipal employees remain owners of operational status, priority policy, repair acceptance, and warranty handling;
- StreetSherlock can integrate beside existing systems through adapters rather than replacing them;
- synthetic Deventer scenarios and licence-reviewed public snapshots are sufficient for portfolio development;
- local-first AI and recorded fixtures are acceptable for the prototype;
- one municipality/single-tenant context is sufficient for the first MVP;
- the first valuable proof is a reliable human-reviewed StreetPulse workflow, not the full InfraProof vision.

If an assumption is disproved, the affected scope must return to refinement and be recorded in the decision/RAID log.

## 16. External validation and open questions

The project must not invent answers to these questions:

### Municipal operations

- Who owns report-to-incident confirmation, priority policy, service levels, and final status?
- Which MOR, zaak, BOR/asset, works, identity, map, document, and contractor systems are actually used?
- Which events may be imported, exported, or written back?
- What evidence is useful in daily work, and when does another recommendation create extra workload?

### Privacy, legal, and AI governance

- What are the lawful bases, retention periods, archive duties, deletion procedures, and data-subject processes?
- Which inputs and outputs require a DPIA and FRAIA/IAMA review?
- Which AI Act role and risk classification applies to the authorized use case at pilot time?
- When may restricted originals be accessed, by whom, and for which documented reason?

### Security, hosting, and operations

- Which identity provider, network boundary, hosting region, support model, incident-notification process, backup objective, and BIO2 control scope are required?
- Which independent penetration, authorization, accessibility, and operational tests are required before a pilot?

### Contracts and repair assurance

- Which warranty clauses, evidence standards, rework/appeal steps, and contractor responsibilities apply?
- Which municipal policy can link a new defect to earlier work without implying causation or liability?

### Business and procurement

- Who owns budget and procurement?
- Which operational baseline and KPI would justify a read-only shadow pilot?
- What data-export, support, rollback, and exit terms are required?

Owners and due dates for these questions belong in E00-04 and E00-06.

## 17. Initial product risks

| Risk | Product response |
|---|---|
| Rebuilding established MOR software | Keep demo intake thin and invest in intelligence, integration, lineage, and review. |
| False duplicate merge | Candidate-only recommendations, human confirmation, reversible links, and evaluation. |
| Hallucinated or opaque priority | Deterministic versioned policy using verified factors; no LLM final priority. |
| Automatic contractor blame | Use possible-recurrence language and require contract-specific human review. |
| Privacy leakage | Separate restricted originals and public-derived data; block publication and audit restricted access. |
| Over-scoping | Protect the StreetPulse vertical cut line and move InfraProof to later increments. |
| Compliance theatre | Label independent validation as pending and avoid unsupported claims. |
| Technology-showcase architecture | Require each technology to support a tested user or operational outcome. |

Detailed risk, assumption, issue, and dependency ownership belongs to E00-06.

## 18. Release and business framing

The first public description is:

> **StreetSherlock — AI-assisted street incident and repair assurance for the Netherlands.** StreetSherlock combines StreetPulse NL and InfraProof AI to group public-space reports into human-reviewed incidents, connect new defects to previous repairs and warranties, and help inspectors compare privacy-safe evidence. AI finds clues; municipal staff make decisions.

Approved wording:

- AI-assisted.
- Human-reviewed.
- Designed with privacy, security, and accessibility requirements.
- Evaluated on a bounded synthetic/open-data test set.
- Portfolio prototype or pilot-ready concept only when the required evidence exists.

Unapproved wording:

- Fully compliant.
- Production-ready for all municipalities.
- Automatically proves contractor fault.
- Accurately predicts city problems.
- Replaces municipal systems.
- Official partner or customer without a written agreement.

The safest future commercial validation is a read-only shadow pilot that imports minimized data, generates recommendations, collects employee labels, compares outcomes, and keeps all source-system write-back disabled.

## 19. Approval record

| Decision | Owner | Status | Date | Notes |
|---|---|---|---|---|
| Approve product charter and non-goals | Kiarash Delavar, Product Owner | Approved | 1 August 2026 | Approved without conditions. E00-02 and E00-03 may move to Ready. |
| Validate municipal workflow and policy assumptions | External municipal-domain reviewer | External validation required | — | Must not be self-certified. |
| Validate legal, privacy, security, accessibility, and compliance claims | Authorized independent reviewers | External validation required | — | Required before relevant pilot or public claim. |

### Product Owner decision

Kiarash Delavar approved this charter as Product Owner on 1 August 2026 without conditions. Later changes to the approved product boundary require an explicit, recorded product decision.

---

## E00-01 acceptance review

| Acceptance criterion | Evidence in this charter |
|---|---|
| Problem excludes basic reporting as the innovation | Sections 3 and 7 |
| Target users and municipal value are explicit | Sections 5 and 6 |
| Intelligence/assurance positioning is clear | Sections 2 and 7 |
| Report and Incident are distinct | Section 8 |
| MVP and later InfraProof scope are separated | Sections 9 and 10 |
| Non-goals and authority boundaries agree | Sections 11 and 12 |
| Success signals are measurable and honest | Section 14 |
| External unknowns are recorded, not guessed | Sections 15 and 16 |
| No material product ambiguity blocks the next product-freeze issues | Sections 1–19; Product Owner approval recorded on 1 August 2026 |

**Review result:** Approved by the Product Owner on 1 August 2026. E00-01 acceptance criteria are satisfied.
