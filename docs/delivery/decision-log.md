# StreetSherlock Decision Log

## 1. Controlled-document metadata

| Field | Value |
|---|---|
| Requirement | E00-06 |
| Sprint | Sprint 0 — Product freeze and delivery governance |
| Document owner | Kiarash Delavar, Product Owner |
| Version | 0.1 |
| Status | Proposed |
| Controlled baseline | Master Project Specification v2.0 |
| Related evidence | Approved Product Charter, Hero Scenario, MVP Scope, Glossary, and stakeholder/RACI baseline |
| Last updated | 2 August 2026 |
| Review cadence | On every material decision; at sprint and release gates |

## 2. Purpose

This log records important product, domain, architecture, data, AI, security, privacy, delivery, and release decisions with their rationale and consequences.

It prevents repeated debate and hidden decision-making. It does not replace a detailed Architecture Decision Record. Architecture decisions remain Proposed until the required ADR is reviewed and accepted.

## 3. Decision states

| State | Meaning |
|---|---|
| Proposed | A candidate direction exists but is not yet approved by its accountable authority |
| Accepted | The accountable authority approved the decision and controlled evidence exists |
| Rejected | The option was considered and intentionally not selected |
| Deferred | A decision is intentionally postponed to a named trigger or date |
| Superseded | A later decision replaces it; both records remain in history |

Only a human accountable role may change a decision state. AI or automation may prepare evidence but cannot approve a decision.

## 4. Decision classes and authority

| Class | Typical accountable role | Required evidence |
|---|---|---|
| Product scope/positioning | Product Owner; municipal service owner for real pilot scope | Charter, user/problem evidence, scope and non-goals |
| Municipal domain/policy | Named municipal domain/service owner | Workflow examples, policy source, operator review |
| Architecture/API/data | Engineering/architecture owner with consulted specialists | ADR, diagrams, quality attributes, spike/test evidence |
| Privacy/security/accessibility | Independent responsible specialist for formal claims | DPIA/threat/control/test evidence and signed outcome |
| AI/model/dataset promotion | AI/data owner plus domain, QA, privacy/security consultation | Dataset/model cards, evaluation, failure analysis, provenance |
| Release/scope-tier promotion | Product/service owner and required gate owners | Traceability, tests, risks, limitations, rollback and approvals |

In solo mode, Kiarash may accept portfolio product decisions and self-review engineering proposals. He cannot self-certify municipal policy, GDPR, BIO2, WCAG/EN 301 549, legal liability, procurement, or production readiness.

## 5. Required fields

Every material decision records:

- stable ID and short title;
- state and class;
- accountable owner;
- decision date or decision-needed-by trigger;
- context/problem;
- selected direction or proposal;
- alternatives considered;
- rationale/evidence;
- consequences and follow-up work;
- affected requirements, documents, issues, ADRs, data, or releases;
- superseding decision when applicable.

## 6. Decision register

| ID | Decision | Class | State | Owner | Date / needed by | Controlled evidence or next gate |
|---|---|---|---|---|---|---|
| D-01 | StreetSherlock is an intelligence layer above existing MOR/BOR workflows, not a replacement intake system | Product | Accepted | Product Owner | 2026-08-01 | Product Charter v1.0 |
| D-02 | v0.1.0 delivers the StreetPulse vertical slice; InfraProof repair/CV/warranty workflows are later | Product scope | Accepted | Product Owner | 2026-08-02 | Hero Scenario and MVP Scope v1.0 |
| D-03 | Report and Incident are separate aggregates; several preserved Reports may support one Incident | Domain | Accepted for portfolio baseline | Product Owner; external domain validation pending | 2026-08-02 | Glossary v1.0; REV-001 remains open |
| D-04 | AI provides evidence and reversible recommendations; authorized humans own official decisions | Product/authority | Accepted | Product Owner | 2026-08-01 | Product Charter, MVP Scope, Glossary |
| D-05 | The MVP uses exactly six stable demo categories | Product scope | Accepted | Product Owner | 2026-08-02 | MVP Scope v1.0 |
| D-06 | Deventer is synthetic hero context and is not represented as customer, partner, pilot, or validator | Data/product claims | Accepted | Product Owner | 2026-08-02 | Hero Scenario, MVP Scope, stakeholder baseline |
| D-07 | Reports and decision history are preserved; links are reversible and never silent merges/deletions | Domain/audit | Accepted for portfolio baseline | Product Owner; external domain/privacy validation pending | 2026-08-02 | Glossary v1.0 |
| D-08 | Portfolio/demo scope uses no real citizen data, live write-back, real contractor action, or liability decision | Scope/privacy | Accepted | Product Owner | 2026-08-01 | Product Charter and stakeholder baseline |
| D-09 | Use a modular monolith rather than microservices for the core backend | Architecture | Proposed | Engineering | Before Sprint 1 scaffold | ADR-001 and quality-attribute review |
| D-10 | Use Java/Spring Boot as the primary business backend | Architecture | Proposed | Engineering | Before Sprint 1 scaffold | ADR-002 and clean runtime decision |
| D-11 | Keep Python/FastAPI isolated behind an AI/vision service boundary | Architecture/AI | Proposed | Engineering/AI | Before AI-service scaffold | ADR-003 and API/failure contract |
| D-12 | Use PostgreSQL with PostGIS and pgvector | Data architecture | Proposed | Engineering/Data | Before database scaffold | ADR-004 and Compose proof |
| D-13 | Use a replaceable local-AI provider interface with Ollama for development where suitable | AI architecture | Proposed | AI/Engineering | Before AI implementation | ADR-005 and hardware benchmark |
| D-14 | Restrict n8n to delivery automation; core business state remains in the backend | Architecture/integration | Proposed implementation of accepted authority boundary | Engineering | Before notification workflow | ADR-006, outbox/idempotency design |
| D-15 | Store original/derived media in object storage rather than database blobs | Data/security architecture | Proposed | Engineering/Security/Privacy | Before media implementation | ADR-007 and data-flow/threat review |
| D-16 | Enforce human decision authority in domain commands, authorization, audit, and UX | Architecture/authority | Proposed implementation of D-04 | Engineering/Product | Before link/priority implementation | ADR-008 and authorization tests |
| D-17 | Version APIs and events with explicit compatibility rules | Architecture/API | Proposed | Engineering | Before public contracts | ADR-009 and compatibility policy |
| D-18 | Use a single-tenant MVP boundary; do not imply production multi-tenancy | Architecture/scope | Proposed | Engineering/Product | Before persistence/auth design | ADR-010 |
| D-19 | Keep advanced recurrence, computer vision, repair acceptance, warranty, and contractor workflows deferred | Product scope | Deferred | Product Owner | Revisit only after StreetPulse MVP evidence | MVP Scope later-release register |
| D-20 | Repository licence and public-disclosure strategy remain undecided | Legal/business | Deferred | Product Owner; legal consultation if needed | E00-10 / before public release | E00-10 |

## 7. Accepted product decisions — rationale and consequences

### D-01 — Intelligence layer, not intake replacement

Context: Dutch municipalities already use MOR intake and case systems. Rebuilding the full intake stack would weaken product differentiation and exceed solo capacity.

Alternatives considered:

- replace the intake/case system;
- build only a citizen reporting app;
- add an intelligence and evidence layer above existing sources.

Decision: choose the intelligence-layer position.

Consequences:

- adapters and source-of-truth rules are required;
- intake ownership stays external in an integration scenario;
- the demo must emphasize duplicate evidence, review, priority explanation, audit, and safe status communication;
- any feature that turns StreetSherlock into a generic queue requires change control.

### D-02 — StreetPulse first, InfraProof later

Context: The full vision spans report intelligence, repair history, inspection evidence, computer vision, warranty recurrence, and contractors. That is too large for one MVP.

Decision: v0.1.0 ends after a complete, safe StreetPulse workflow. InfraProof remains later.

Consequences:

- Sprint 1 builds one vertical slice;
- repair/CV/warranty capabilities cannot block the MVP;
- later concepts may appear in architecture boundaries but not as completed functionality or value claims.

### D-03 and D-07 — Separate aggregates and preserved evidence

Context: Multiple observations can describe one real problem, and an incorrect duplicate decision must be reversible.

Decision: preserve each Report, manage the real problem as an Incident, and represent associations as audited links.

Consequences:

- no silent merge or deletion;
- link acceptance/rejection/reversal requires actor, time, reason, evidence, and history;
- APIs, schema, UX, metrics, and tests must respect aggregate boundaries;
- municipal domain validation is still required before operational claims.

### D-04 and D-16 — Human authority

Context: Recommendations may be useful, but official priority, status, repair, warranty, liability, and enforcement decisions carry operational and legal consequences.

Decision: AI stays advisory. The later ADR must show how code enforces the accepted product rule.

Consequences:

- recommendations show uncertainty, factors, provenance, and refusal;
- authorized users decide and may override;
- automation cannot be the source of truth;
- every official decision is auditable and reversible where policy allows;
- unsafe autonomous paths are release blockers.

### D-05 and D-06 — Stable categories and synthetic context

Context: A repeatable demonstration needs bounded scenarios without implying a municipality supplied or approved personal data.

Decision: freeze six categories and use synthetic Deventer context.

Consequences:

- category IDs change only through controlled change;
- no real personal or municipal operational data enters the MVP by convenience;
- Amsterdam or another public source is used only after E00-07 licence/provenance approval;
- all public wording preserves the non-customer/non-pilot boundary.

## 8. Proposed architecture decisions

D-09 through D-18 are not accepted merely because they appear in the Master Project Specification. Each requires:

1. a dedicated ADR;
2. context and quality attributes;
3. at least two realistic alternatives;
4. security, privacy, accessibility, data, AI, and operational impacts where relevant;
5. consequences and rollback/revisit triggers;
6. self-review disclosure and any required independent review;
7. acceptance by the accountable human role before affected implementation.

If an ADR rejects a proposal, this register marks the proposal Rejected or Superseded and links the accepted replacement.

## 9. Change and reversal rules

A new decision or update is required when work:

- changes the MVP cut line or six categories;
- changes Report/Incident semantics or decision authority;
- introduces real data, a new data recipient, public publication, or a new provider;
- adds an external integration, write-back, notification, contractor, warranty, liability, or enforcement path;
- changes persistence, API/event compatibility, tenancy, identity, or media storage;
- promotes an AI model, embedding model, prompt, dataset, or decision threshold;
- accepts a security/privacy/accessibility exception;
- changes release or scope tier;
- contradicts an approved document or ADR.

Accepted decisions are not edited to hide history. Add a new decision that supersedes the old one and update both links.

## 10. Decision history

| Date | Actor | Decision IDs | Change | Evidence |
|---|---|---|---|---|
| 2026-08-02 | Kiarash Delavar / delivery agent | D-01 to D-20 | Created initial decision register from controlled Sprint 0 evidence and Master Specification proposals | Issue #11 and E00-06 pull request |

## 11. Acceptance traceability

| Issue #11 criterion | Result | Evidence |
|---|---|---|
| Decision states separated | Pass | Section 3 |
| Accepted product decisions traceable | Pass | Sections 6–7 |
| Proposed architecture choices remain unapproved until ADR | Pass | Sections 6 and 8 |
| Human authority preserved | Pass | D-04 and D-16 |
| Synthetic Deventer/non-partner boundary | Pass | D-06 |
| Independent assurance cannot be self-closed | Pass | Sections 4 and 8 |
| No unrelated/code changes | Pending branch validation | Pull request diff |
| Product Owner approval before merge | Pending | Approval record |

## 12. Approval record

| Role | Name | Decision | Date | Conditions / notes |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Pending | — | Review and explicitly approve E00-06 before merge |
| Municipal domain reviewer | Unassigned | External validation required | — | D-03 and D-07 are portfolio baselines, not municipal validation |
| Architecture reviewer | Kiarash Delavar, self-review only | Pending ADR review | — | D-09 to D-18 remain Proposed |
| Privacy/Security/Accessibility/Legal reviewers | Unassigned | External validation required | — | Formal assurance and production/pilot claims remain unavailable |
