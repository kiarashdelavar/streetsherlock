# StreetSherlock Personas, Stakeholders, Ownership, and RACI

## 1. Controlled-document metadata

| Field | Value |
|---|---|
| Requirement | E00-04 |
| Sprint | Sprint 0 — Product freeze and delivery governance |
| Document owner | Kiarash Delavar, Product Owner |
| Version | 1.0 |
| Status | Approved |
| Controlled baseline | [Master Project Specification v2.0](../MASTER_PROJECT_SPEC.md) |
| Related product documents | [Product Charter v1.0](product-charter.md), [Hero Scenario v1.0](hero-scenario.md), [MVP Scope v1.0](mvp-scope.md), [Glossary v1.0](glossary.md) |
| Last updated | 2 August 2026 |
| Next review | At every scope-tier promotion or material authority/access change |

## 2. Purpose

This document identifies the people, organizations, teams, and system owners affected by StreetSherlock. It freezes:

- stakeholder groups and their expected outcomes;
- authority and accountability boundaries;
- information-access boundaries;
- the company-reference delivery model;
- the realistic solo-delivery mapping;
- the RACI for high-risk decisions;
- independent review gaps that cannot be self-certified;
- engagement and escalation expectations.

It is governance evidence, not proof that any municipality, resident, contractor, or specialist has validated the product.

## 3. Scope and non-claims

This document covers the StreetPulse MVP and identifies later InfraProof stakeholders where necessary for future planning.

Current scope tier: **portfolio demo and engineering MVP**.

Current data boundary:

- synthetic Deventer data may support the hero scenario;
- licence-reviewed public snapshots may support engineering and evaluation;
- Amsterdam public data may become a source only after licence and provenance review;
- no real citizen personal data is approved;
- no live municipal write-back is approved;
- no real contractor notification, liability, warranty, payment, or enforcement action is approved.

The following are explicit non-claims:

- Deventer is not presented as a customer, partner, pilot, or validator.
- Amsterdam is not presented as a customer, partner, pilot, or validator.
- Signalen, Fixi, BuitenBeter, BOR systems, and contractor systems are not being replaced.
- Product Owner approval is not municipal, legal, privacy, security, accessibility, or procurement approval.
- A portfolio demonstration is not a production-ready municipal service.

## 4. Stakeholder principles

1. A person affected by the service is a stakeholder even when they do not operate the software.
2. Citizens need understandable outcomes, not access to internal operational or personal data.
3. A Report remains a submitted observation; an Incident remains the municipal problem under management.
4. AI produces evidence and reversible recommendations only.
5. An authorized human owns every official link, priority, status, repair-acceptance, liability, and enforcement decision.
6. Contractors receive only the minimum information needed for an authorized work or evidence task.
7. Self-review must never be represented as independent assurance.
8. The organization operating a real deployment assigns accountable municipal roles; the portfolio owner cannot invent those appointments.
9. Every scope-tier promotion requires an explicit decision and evidence.
10. When responsibility is unclear, work stops at the safe boundary and is escalated.

## 5. Stakeholder map

### 5.1 People affected by the service

| Stakeholder | Desired outcome | Main concerns | Influence | Decision rights | Permitted information |
|---|---|---|---|---|---|
| Citizen reporter | Submit once, understand progress, receive a useful outcome | Privacy, ease of use, accessibility, duplicate confusion, response time | Medium through feedback and consent choices | Controls own submission and optional contact choices; may correct or withdraw where policy permits | Own report receipt, public-safe status, own notifications |
| Non-reporting resident or road user | Safer, usable public space without unnecessary surveillance | Fair prioritization, false claims, public transparency | Low individually; high collectively | No case-management authority | Public-safe service information and aggregate reporting |
| Vulnerable road user | Safe routes and accessible reporting | Barriers for disability, low digital skill, language, urgent hazards | High design relevance | Can request accessible channel or assistance where offered | Same public-safe and own-report information |
| Bystander or incidental data subject | Personal details in images or text are protected | Face, vehicle plate, home, precise-location, or identity exposure | High privacy relevance | Data-subject rights depend on lawful basis and policy | Data about themselves through governed request processes only |
| Citizen contact-centre user | Receive equivalent service through an assisted channel | Digital exclusion and inconsistent answers | Medium | Chooses available channel; no municipal incident authority | Own interaction and public-safe case status |

### 5.2 Municipal operational stakeholders

| Stakeholder | Desired outcome | Main concerns | Influence | Decision rights | Permitted information |
|---|---|---|---|---|---|
| Intake or triage employee | Review reports quickly and consistently | Duplicate workload, poor evidence, unsafe automation | High operational influence | Accepts or rejects duplicate/link suggestions when authorized | Report content and minimum reporter data required for the task |
| Incident case worker | Maintain one accurate incident record with traceable evidence | Incorrect links, lost history, unexplained priority | High | Creates or updates Incidents and reverses Report–Incident links within policy | Incident evidence and role-authorized report details |
| Operational coordinator | Plan work and manage service performance | Backlog, safety, capacity, policy consistency | High | Approves operational planning and escalation within municipal policy | Operational details and performance data |
| MOR/BOR domain lead | Own terminology, workflow, categories, and policy meaning | Semantic drift and software replacing policy | Very high | Accountable for domain rules and priority policy in a real deployment | Domain, operational, and policy evidence |
| Asset manager | Protect asset quality and lifecycle value | Missing asset history, recurring defects, weak evidence | High for InfraProof | Owns asset-maintenance rules and accepts lifecycle evidence within policy | Asset, work, inspection, and authorized incident data |
| Municipal inspector | Capture and assess field evidence | Unsafe site conditions, unusable photos, unreliable comparisons | High for later releases | Records inspection findings; does not automatically determine legal liability | Assigned work, asset, and minimized location/evidence data |
| Contractor manager | Coordinate authorized supplier work and contract evidence | Incomplete work packages and unsupported warranty claims | High for later releases | Initiates contractor workflow only under approved municipal policy | Contract/work evidence and minimized case data |
| Citizen communications or contact-centre lead | Provide consistent public explanations | Conflicting statuses, inaccessible language, overpromising | Medium | Approves communication templates and escalation routes | Public-safe status and minimum contact data |
| Municipal data owner | Ensure data use is authorized, accurate, retained, and exportable | Ownership, quality, access, retention, deletion | Very high | Approves municipal dataset use and access rules | Data inventory, provenance, access, and processing evidence |
| Municipal service owner / executive sponsor | Own service outcome, budget, and pilot authority | Value, risk, procurement, public accountability | Very high | Accountable for pilot and service authorization; cannot waive legal or technical assurance alone | Governance, risk, performance, and release evidence |

### 5.3 Contractor and field-service stakeholders

| Stakeholder | Desired outcome | Main concerns | Influence | Decision rights | Permitted information |
|---|---|---|---|---|---|
| Contractor coordinator | Receive an unambiguous authorized task | Citizen-data exposure, unclear acceptance, unsupported fault claims | Medium to high in operational pilot | Accepts or queries assigned work; no access to unrelated reports | Minimum work package, asset, location, deadline, and approved evidence |
| Field technician | Complete and document repair safely | Missing context, unsafe instructions, difficult evidence capture | Medium | Records work and evidence; cannot close municipal Incident unless policy grants it | Assigned work and minimum site information |
| Independent or municipal inspector | Verify physical outcome with traceable evidence | Conflict of interest, weak comparison, hidden AI limitations | High | Records inspection result; acceptance authority follows municipal policy | Assigned inspection, evidence, standard, and asset history |
| Contractor commercial or warranty representative | Respond to a formally authorized warranty case | Premature liability claim and incomplete evidence | Medium | Responds to an approved case; cannot decide municipal truth | Only authorized warranty package; never citizen identity by default |

Contractor boundary: a contractor must not receive reporter identity, contact details, unrelated free text, unrestricted original media, or other citizen information unless a separately documented lawful and operational need has been approved.

### 5.4 Governance and assurance stakeholders

| Stakeholder | Accountable concern | Cannot approve alone |
|---|---|---|
| Product Manager / Product Owner | Product thesis, MVP scope, roadmap, acceptance, known limitations | Security/privacy exceptions, municipal policy, formal compliance |
| Municipal domain lead | MOR/BOR workflow, terminology, category and priority policy | Architecture, model accuracy, legal compliance |
| Privacy officer / Functionaris Gegevensbescherming delegate | DPIA, minimization, retention, data-subject flows, privacy sign-off | Business value, release, or security sign-off alone |
| Security lead / CISO delegate | Threat model, ASVS/BIO2 control review, exceptions, security sign-off | Lawful basis or product acceptance alone |
| Accessibility specialist | WCAG and EN 301 549 evaluation, assistive-technology evidence | Product scope or municipal operational policy alone |
| Legal/procurement specialist | Processing roles, contracts, licences, warranty wording, supplier obligations | Technical safety or product value alone |
| AI/data steward | Dataset, model and prompt registry; provenance; drift and override review | Final operational decisions or legal claims |
| QA/test lead | Test strategy, release evidence, defect visibility | Business risk acceptance alone |
| Platform/SRE lead | Environments, observability, backup, recovery, operational readiness | Product acceptance or lawful basis alone |
| Release review group | Evidence-based go/no-go recommendation | Scope-tier promotion without required accountable authorities |

### 5.5 Product and engineering delivery stakeholders

| Role/team | Responsible for | Required evidence | Cannot decide alone |
|---|---|---|---|
| UX/service design | Research plan, journeys, service blueprint, plain language, accessibility design | Research notes, wireframes, usability and accessibility findings | Municipal policy or formal accessibility conformance |
| Web squad | Next.js surfaces, design system, client validation, frontend tests | Test results, accessibility checks, screenshots/demos | Backend authorization or municipal priority |
| Core platform squad | Spring modules, domain model, APIs, persistence, authorization, audit | Architecture tests, API contracts, integration tests | Municipal semantics or lawful basis |
| Data/AI squad | Adapters, embeddings, evaluation, computer vision, model documentation | Dataset/model cards, evaluation, failure analysis | Final Report link, Incident priority, liability, or repair acceptance |
| Platform/SRE | CI/CD, environments, monitoring, backup and recovery | Pipeline, restore test, SLO and incident evidence | Product acceptance |
| QA/test lead | Risk-based test strategy and release evidence | Traceability, automated/manual test reports, residual defects | Accepting unowned product or compliance risk |
| Technical writer | Controlled documentation, runbooks, user and operator guidance | Reviewed documentation and version history | Product, policy, or compliance approval |
| Pilot/integration lead | Customer mapping, read-only import, support and exit plan | Mapping, reconciliation, support, rollback, export/deletion evidence | Production write-back or scope-tier promotion alone |

### 5.6 External system and provider stakeholders

| System or owner | Relationship | Boundary or concern | Approval needed before operational use |
|---|---|---|---|
| Existing MOR intake owner, such as Signalen/Fixi/BuitenBeter | Upstream report source or adjacent system | StreetSherlock adds intelligence; it does not replace intake ownership | API, purpose, data fields, support, reconciliation, and exit agreement |
| BOR/asset-management owner | Asset and maintenance context | External identifiers and status remain source-owned | Mapping, source-of-truth, freshness, and conflict policy |
| Municipal identity provider owner | Workforce authentication | No demo identity mechanism may be treated as production identity | OIDC configuration, role mapping, lifecycle and break-glass review |
| Map/open-data provider | Basemap or public dataset | Licence, attribution, freshness, completeness, and availability | Licence/provenance register and fallback behavior |
| Object-storage provider | Original and derived media storage | Restricted originals, encryption, retention, deletion, and access logs | Security/privacy design and processor terms where applicable |
| n8n/workflow owner | Non-core notification automation | Never owns business state; callbacks must be idempotent | Workflow boundary, secrets, retry, failure and recovery review |
| Ollama/model provider boundary | Local or replaceable AI inference | Model output is untrusted advisory evidence | Evaluation, model registry, privacy and resource review |
| Error-monitoring owner, such as Sentry | Operational telemetry | Personal or sensitive content must not leak into telemetry | Data filtering, retention, access, region and processor review |

## 6. Power–interest engagement map

| Segment | Stakeholders | Engagement approach |
|---|---|---|
| Manage closely | Municipal service owner, Product Owner, municipal domain lead, data owner, privacy, security, operational coordinator | Decision forums, documented approvals, visible risks and change control |
| Co-design and validate | Triage employees, case workers, inspectors, contact centre, accessibility specialist, representative citizens | Scenario walkthroughs, prototypes, usability/accessibility tests, structured feedback |
| Keep satisfied | Asset managers, contractor managers, legal/procurement, platform/SRE, QA | Gate-specific evidence, risk summaries, early notice of relevant changes |
| Keep informed | Contractors, technicians, public communications, non-reporting residents | Clear operating boundaries, role-specific guidance, public-safe limitations |
| Monitor dependencies | External system and data-provider owners | Interface contracts, availability/licence reviews, escalation and exit plans |

No group in this map is currently confirmed as an external project participant. Engagement becomes factual only after an identifiable person or organization agrees to participate and the decision is recorded.

## 7. Authority boundaries

### 7.1 Human operational authority

Only a role authorized by the responsible municipality may:

- accept, reject, replace, or remove a Report–Incident link;
- create or close an official Incident;
- determine official operational priority;
- approve planned work;
- accept or reject repair evidence;
- open a warranty or contractor case;
- attribute responsibility or liability;
- authorize citizen or contractor communication;
- approve write-back into a municipal source system.

### 7.2 AI and automation authority

AI may:

- detect and redact candidate personal information for human review;
- propose possible duplicate Reports or related Incidents;
- explain factors behind a priority recommendation;
- summarize evidence with traceable source references;
- identify possible recurrence or comparison candidates in later releases;
- refuse or degrade safely when evidence is insufficient.

AI may not:

- silently merge or delete Reports;
- create an official Report–Incident link without human confirmation;
- set final priority;
- close an Incident;
- accept a repair;
- assign contractor fault or liability;
- send real contractor or enforcement communication;
- override a human decision;
- hide uncertainty, provenance, or failure.

n8n or another workflow engine may deliver an approved notification or request, but it never becomes the source of truth for Report, Incident, Decision, or StatusHistory state.

## 8. Information-access boundary

| Information class | Citizen | Municipal operator | Municipal manager/domain lead | Contractor/technician | Assurance reviewer | Public |
|---|---:|---:|---:|---:|---:|---:|
| Own report receipt and public-safe status | Own only | As authorized | As authorized | No | As required for review | No |
| Reporter identity/contact | Own only | Minimum required | Exception-based | No by default | Strictly need-to-know | No |
| Original uploaded media | Own where policy allows | Restricted role | Restricted role | No by default; approved derivative only | Controlled review access | No |
| Redacted/derived media | Own report context | As authorized | As authorized | Assigned task only | As required | Only if publication separately approved |
| Duplicate recommendations and scores | No by default | Task-authorized | Policy/quality view | No | Review evidence | No |
| Human decision and reason | Public-safe summary | Full task history | Full governed history | Assigned-case subset | Review evidence | Aggregate/public-safe only |
| Incident operational details | Public-safe subset | As authorized | As authorized | Assigned task only | As required | Public-safe subset only |
| Security logs and findings | No | No by default | Summary | No | Named reviewers | No |
| Model/dataset evaluation | Published limitations | Role-based | Governance view | No by default | Full controlled evidence | Approved summary only |

This matrix is a product boundary, not a final authorization design. E00-05 requirements, the threat model, privacy work, and role design must turn it into testable controls.

## 9. Company-reference team topology

| Role/team | Accountable for | Cannot approve alone |
|---|---|---|
| Executive sponsor / municipal service owner | Business outcome, budget, pilot authority | Technical safety or legal compliance |
| Product Manager / Product Owner | Product thesis, roadmap, scope, acceptance | Security/privacy exceptions |
| Municipal domain lead | MOR/BOR workflow, terminology, priority policy | Model accuracy or architecture |
| UX/service designer | Research, journeys, plain language, accessibility design | Operational policy |
| Web squad | Next.js surfaces, design system, frontend tests | Backend authorization |
| Core platform squad | Spring modules, domain, API, persistence, authorization | Municipality policy decisions |
| Data/AI squad | Adapters, embeddings, evaluation, computer vision, model cards | Final incident or repair decisions |
| Platform/SRE | Environments, CI/CD, observability, backup, recovery | Product acceptance |
| QA/test lead | Test strategy, release evidence, exploratory testing | Risk acceptance |
| Security lead / CISO delegate | Threat model, ASVS/BIO2 controls, security sign-off | Lawful basis/privacy sign-off |
| Privacy officer / FG delegate | DPIA, minimization, retention, data-subject flows | Business value or technical release alone |
| Accessibility specialist | WCAG/EN 301 549 evaluation | Product scope alone |
| AI/data steward | Dataset/model/prompt registry, drift and override review | Human operational decisions |
| Pilot/integration lead | Customer mapping, import, support, and exit plan | Production write-back alone |

## 10. Solo-delivery mapping

Kiarash may perform several delivery responsibilities for the portfolio and engineering MVP. The repository must label the evidence accurately.

| Responsibility | Solo role | What may be self-reviewed | What cannot be self-certified | Required external role before the stated gate |
|---|---|---|---|---|
| Product scope and acceptance | Product Owner | Portfolio scope, backlog priority, demo acceptance | Municipal value or procurement acceptance | Municipal service owner before a claimed pilot |
| Architecture and implementation | Architect/developer | Design consistency, code, tests, limitations | Production security/accreditation | Independent engineering and security review before operational pilot |
| Domain analysis | Interim domain analyst | Glossary consistency and synthetic workflow | Municipal policy correctness | MOR/BOR domain lead before municipal workflow claims |
| QA | QA lead | Automated tests, manual evidence, defect log | Independent release assurance | Independent reviewer before V1/pilot where material |
| Technical writing | Document owner | Completeness, traceability, change history | Specialist approval | Named specialist for each controlled domain |
| AI/data work | AI/data developer and steward | Evaluation implementation and synthetic/public snapshot results | Fitness for municipal decisions or legal use | Domain, privacy, security, and AI/data reviewers before pilot |
| Privacy preparation | Document author | Data inventory and draft risk analysis | GDPR lawful basis, DPIA or FRAIA approval | Privacy officer/FG and responsible controller |
| Security preparation | Security-document author | Threat-model draft and technical scans | BIO2 compliance or security accreditation | Security lead/CISO delegate |
| Accessibility preparation | Designer/developer | Automated and manual development checks | Formal WCAG/EN 301 549 conformance | Independent accessibility specialist |
| Warranty/contract analysis | Product researcher | Hypotheses and non-legal workflow sketches | Liability or contract interpretation | Municipal legal/procurement specialist |
| Operations/SRE | Platform developer | Local/demo monitoring and recovery tests | Production operational readiness | Named service owner and platform/SRE reviewer |

Allowed evidence labels:

- **Self-review completed** — Kiarash performed and recorded the review.
- **Peer review completed** — an identifiable independent reviewer reviewed a defined scope.
- **External validation required** — the necessary accountable specialist or organization is not yet assigned.
- **Not applicable at current scope tier** — the decision is intentionally deferred and the trigger is recorded.

The label **approved** must always identify the approving role, person, date, scope, and conditions.

## 11. RACI legend and rules

- **A — Accountable:** owns the decision and its consequences.
- **R — Responsible:** prepares or performs the work.
- **C — Consulted:** must be consulted before the decision.
- **I — Informed:** receives the outcome.
- **—:** no routine role in the decision.

Rules:

- Each decision should have one accountable role unless a jointly governed pilot gate explicitly requires more.
- AI, automation, and software services never occupy A or R for an official human decision.
- In solo mode, Product and Engineering cells may refer to the same person, but they remain separate responsibilities.
- An external-validation-required cell cannot be converted to completed by self-review.
- When an accountable municipal role is unassigned, the project may prepare evidence but may not claim operational approval.

Abbreviations:

- **SO:** Municipal service owner
- **PO:** Product Owner
- **DOM:** Municipal domain lead
- **OPS:** Authorized municipal operations
- **ENG:** Engineering
- **AI:** AI/data
- **SEC:** Security
- **PRV:** Privacy
- **A11Y:** Accessibility
- **QA:** QA/SRE
- **LEG:** Legal/procurement

## 12. RACI — high-risk product and operational decisions

| Decision | SO | PO | DOM | OPS | ENG | AI | SEC | PRV | A11Y | QA | LEG |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Portfolio MVP scope | I | A/R | C | C | C | C | I | I | C | I | I |
| Report/Incident semantics | I | C | A | R | R | C | I | C | I | I | I |
| Municipal category and priority policy | I | C | A | R | R | C | C | C | C | I | I |
| Report–Incident link decision | I | I | C | A/R | — | — | — | — | — | I | — |
| Final Incident priority decision | I | I | C | A/R | — | — | — | — | — | I | — |
| Repair acceptance | I | I | A | R | — | — | — | — | — | C | C |
| Contractor liability or warranty interpretation | I | I | C | R | — | — | — | C | — | I | A |
| Citizen communication policy/template | I | A | C | R | C | — | I | C | C | C | I |
| Public-data publication | I | I | C | C | R | C | C | A | C | C | C |
| Personal-data lawful basis and retention | I | C | C | C | R | I | C | A | I | C | C |
| Security exception | I | I | I | I | R | I | A | C | I | C | I |
| Accessibility acceptance for a release | I | C | C | C | R | — | I | C | A | R | I |
| AI/model or prompt promotion | I | C | C | C | C | A/R | C | C | I | R | I |
| Production data import | A | C | C | C | R | C | C | A | I | R | C |
| Pilot write-back enablement | A | A | C | R | R | C | A | A | C | R | C |
| Portfolio/demo release | I | A | C | I | R | C | C | C | C | A/R | I |
| Operational-pilot release | A | C | C | R | R | C | C | C | C | A/R | C |
| Production release | A | C | C | R | R | C | C | C | C | A/R | C |
| Scope-tier promotion | A | R | C | C | C | C | C | C | C | C | C |

At the current portfolio-demo/engineering-MVP tier, SO, DOM, OPS, PRV, SEC, A11Y, and LEG are not named external approvers. Their future accountability remains visible, while the corresponding operational decisions remain unavailable.

## 13. RACI — delivery evidence and operations

| Activity | PO | DOM | UX/A11Y | ENG | AI | SEC | PRV | QA/SRE | SO |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Requirement catalogue and traceability | A | C | C | R | C | C | C | R | I |
| Architecture and ADR preparation | C | C | C | A/R | C | C | C | C | I |
| Threat-model preparation | I | C | C | R | C | A | C | C | I |
| Privacy inventory/DPIA preparation | I | C | C | R | C | C | A | C | I |
| Accessibility test evidence | C | I | A | R | — | I | C | R | I |
| Dataset/model documentation | I | C | I | C | A/R | C | C | R | I |
| Test strategy and release evidence | C | C | C | R | R | C | C | A/R | I |
| Backup/restore and recovery evidence | I | I | — | R | — | C | C | A/R | I |
| Sprint review | A/R | C | C | R | R | I | I | C | I |
| Risk/privacy/security gate | I | C | C | R | C | A | A | R | I |
| Shadow-pilot proposal | R | C | C | C | C | C | C | C | A |
| Exit/export/deletion plan | C | C | I | R | C | C | A | R | A |

## 14. Decision forums and cadence

| Forum | Cadence or trigger | Core participants | Required output |
|---|---|---|---|
| Daily delivery check | Daily, maximum 10 minutes during active work | Current delivery roles | Updated board, blockers, owner and next action |
| Backlog refinement | Weekly | PO, domain, engineering, QA; specialists as needed | Ready stories with acceptance criteria and dependencies |
| Technical design review | Before material schema, API, security, data, or AI change | Engineering plus affected specialists | Approved/rejected ADR and actions |
| Sprint review | End of sprint | PO, delivery roles, available stakeholders | Acceptance record, demo evidence, feedback, limitations |
| Retrospective | End of sprint | Delivery roles | Maximum three process improvements with owners |
| Risk/privacy/security review | Sprint 0, before V1, before pilot, and on material change | Security, privacy, product, engineering, QA | Signed gate or explicit open risks |
| Model/data review | Before dataset, model, embedding, or prompt promotion | AI/data, domain, privacy, security, QA | Promotion/rejection decision and evaluation evidence |
| Accessibility review | Before MVP release and after material journey change | Accessibility, UX, engineering, QA | Findings, severity, fixes, residual limitations |
| Release readiness | Before each tag | PO, engineering, QA/SRE and required gate owners | Go/no-go decision with evidence |
| Pilot governance | Before data import or any write-back | Service owner, PO, domain, privacy, security, legal, QA | Signed scope, prohibited uses, rollback and exit decision |

In solo mode, only the daily check, backlog refinement, self-review, sprint review, and retrospective can be completed without external participants. All other forums remain preparation or self-review until the required independent roles are identified.

## 15. External-review gap register

| ID | Review gap | Required independent role | Trigger/gate | Minimum evidence | Current status |
|---|---|---|---|---|---|
| REV-001 | Municipal workflow and terminology validation | MOR/BOR domain lead and operational user | Before municipal-correctness claims or shadow pilot | Scenario walkthrough, glossary, process map, decisions | External validation required |
| REV-002 | Citizen/user-needs validation | Representative users including accessibility needs | Before usability or citizen-value claims | Research protocol, consent/privacy approach, findings | External validation required |
| REV-003 | Privacy and lawful-basis review | Controller privacy officer/FG delegate | Before real personal data or shadow pilot | Data inventory, purpose, roles, retention, DPIA/FRAIA decision | External validation required |
| REV-004 | Security/BIO2 review | Security lead/CISO delegate | Before operational pilot | Threat model, architecture, control matrix, test evidence | External validation required |
| REV-005 | Accessibility conformance review | Independent accessibility specialist | Before formal WCAG/EN 301 549 claim | Test scope, assistive-technology evidence, issue log | External validation required |
| REV-006 | Data licence/provenance review | Data owner and legal/licensing reviewer | Before distributing or relying on public snapshots | Source register, terms, attribution, transformation, retention | External validation required |
| REV-007 | Contractor/warranty/legal workflow review | Municipal legal/procurement and contract owner | Before InfraProof liability or warranty workflow | Contract assumptions, evidence standard, prohibited language | External validation required |
| REV-008 | AI/data evaluation review | Independent AI/data reviewer plus domain reviewer | Before model promotion beyond demo | Dataset/model cards, metrics, slices, overrides, failures | External validation required |
| REV-009 | Production platform/operations review | Platform/SRE owner | Before operational pilot | SLOs, monitoring, backup/restore, runbooks, support | External validation required |
| REV-010 | Pilot authority and value validation | Named municipal service owner and data owner | Before calling work a pilot | Signed scope, KPI baseline, prohibited uses, exit plan | External validation required |
| REV-011 | Procurement and supplier assurance | Procurement/legal/security stakeholders | Before purchase or production claim | Supplier terms, processors, exit/export/deletion, support | External validation required |
| REV-012 | Independent release review | QA/release reviewer not authoring all evidence | Before V1 or pilot release | Traceability, tests, defects, risks, limitations, rollback | External validation required |

No gap is closed by adding a placeholder name. Closure requires an identifiable reviewer, review scope, evidence, date, outcome, conditions, and link to the resulting record.

## 16. Stakeholder engagement plan

| Objective | Participants | Method | Timing | Evidence |
|---|---|---|---|---|
| Validate problem and current workflow | Triage, case worker, domain lead | Structured interviews and process walkthrough | Before pilot proposal | Anonymized notes, decisions, changed assumptions |
| Validate Report-vs-Incident semantics | Domain lead, operators, data owner | Example-based domain workshop | Before requirements baseline or pilot mapping | Accepted examples, counterexamples, unresolved terms |
| Validate citizen journey | Representative citizens, contact centre, accessibility specialist | Prototype usability and accessibility sessions | Before MVP claim | Protocol, findings, fixes, limitations |
| Validate explainable priority | Domain lead, operators, security/privacy as needed | Blind scenario comparison and override review | Before AI recommendation promotion | Agreement/override results and reasons |
| Validate contractor boundary | Contractor manager, inspector, legal/procurement | Minimal-data and evidence-package walkthrough | Before InfraProof operational work | Approved fields, exclusions, responsibilities |
| Validate privacy/security | Privacy, security, data owner, engineering | Evidence-based gate review | Before real data or pilot | Signed decision and residual risks |
| Validate shadow-pilot value | Service owner, operational owner, data owner | Baseline/KPI and exit-plan workshop | Before pilot | Signed scope and measurable success criteria |

Research or validation involving real people must have a suitable consent, privacy, storage, and deletion approach before it begins.

## 17. Decision and escalation model

1. The Responsible role prepares evidence and a recommendation.
2. Consulted roles review before the deadline and record concerns.
3. The Accountable role approves, rejects, defers, or requests changes.
4. Conditions, residual risks, dissent, date, and evidence link are recorded.
5. Informed roles receive the final outcome.
6. If no Accountable role is assigned, the decision remains pending.
7. If two controlled documents conflict, implementation pauses until the owner resolves both.
8. Any suspected personal-data exposure, authorization bypass, destructive corruption, or unsafe autonomous decision is escalated as a highest-severity incident.
9. Any request to enable real data, real notifications, real write-back, or liability workflow is a scope-tier change, not a small feature.
10. Product Owner convenience cannot override privacy, security, accessibility, municipal policy, or legal gates.

## 18. Assumptions

| ID | Assumption | Owner | Validation route | If false |
|---|---|---|---|---|
| ASM-STAKE-01 | A municipality has distinct operational, domain, data, privacy, security, and service-ownership responsibilities, even if job titles differ | Product | Stakeholder interviews | Map responsibilities to actual roles without weakening gates |
| ASM-STAKE-02 | Existing MOR intake remains authoritative for report intake in an integration scenario | Product/domain | System-owner interview and interface review | Reassess positioning and architecture through change control |
| ASM-STAKE-03 | Triage staff may benefit from advisory duplicate and priority evidence | Product/domain | Baseline measurement and shadow evaluation | Remove or redesign the recommendation |
| ASM-STAKE-04 | Contractors can operate from a minimized work package without citizen identity | Privacy/domain | Field and legal review | Redesign workflow; do not expose data by default |
| ASM-STAKE-05 | Synthetic Deventer scenarios can demonstrate the workflow without claiming municipal validation | Product | Portfolio review | Change fictionalization and public wording |
| ASM-STAKE-06 | One solo developer can prepare, but not independently certify, specialist evidence | Product | Gate review | Narrow scope or obtain reviewers earlier |

These assumptions must be copied or referenced in the E00-06 assumption log; this document does not replace the central register.

## 19. Open questions

| ID | Question | Decision owner type | Needed by |
|---|---|---|---|
| OQ-STAKE-01 | Which actual municipal role owns Report–Incident linking and reversals? | Municipal domain/service owner | Before shadow pilot |
| OQ-STAKE-02 | Which information may a citizen see about an Incident linked to their Report? | Domain, privacy, communications | Before production UX |
| OQ-STAKE-03 | When may original media be shared with an inspector or contractor? | Privacy, domain, legal | Before InfraProof workflow |
| OQ-STAKE-04 | Who approves priority policy and emergency-routing boundaries? | Municipal domain/service owner | Before operational use |
| OQ-STAKE-05 | Which identity and role model maps to municipal workforce reality? | Identity owner, security, domain | Before operational pilot |
| OQ-STAKE-06 | Who is controller, processor, or subprocessor for each deployment component? | Privacy/legal/service owner | Before real data |
| OQ-STAKE-07 | What independent accessibility scope is required for the deployment channel? | Accessibility/service owner | Before formal conformance claim |
| OQ-STAKE-08 | Which contractor and warranty terms apply, and what evidence standard is sufficient? | Legal/procurement/domain | Before warranty workflow |
| OQ-STAKE-09 | Which public datasets may be stored, transformed, and redistributed? | Data owner/legal | Before dataset inclusion |
| OQ-STAKE-10 | Who owns service support, incident response, deletion, and exit in a pilot? | Municipal service owner and supplier owner | Before pilot |

Open questions must move into the central decision, assumption, RAID, or requirement records as E00-06 and E00-05 are completed.

## 20. Acceptance traceability

| Issue #8 acceptance criterion | Result | Evidence |
|---|---|---|
| Groups, goals, concerns, influence, decision rights, information access | Pass | Sections 5, 6, and 8 |
| Required stakeholder coverage | Pass | Sections 5.1–5.6 |
| Company-reference topology | Pass | Section 9 |
| Solo-delivery mapping | Pass | Section 10 |
| Self-review versus independent review | Pass | Sections 10 and 15 |
| High-risk RACI | Pass | Sections 11–13 |
| Human authority over AI | Pass | Sections 7 and 12 |
| Contractor privacy boundary | Pass | Sections 5.3 and 8 |
| Deventer/Amsterdam non-customer boundary | Pass | Section 3 |
| Review-gap owner, trigger, evidence, status | Pass | Section 15 |
| Assumptions and open questions | Pass | Sections 18 and 19 |
| Consistency with approved product documents | Pass | Sections 2–4 and terminology throughout |
| Product Owner approval | Pass | Section 22; approval was expressed by merging PR #9, then recorded in this correction |

## 21. Change control

A material change requires document review when it:

- changes a stakeholder’s decision authority;
- exposes a new information class or recipient;
- adds a municipality, contractor, provider, or real participant;
- changes scope tier;
- enables real data, notification, integration, write-back, liability, or enforcement;
- changes the RACI accountable role;
- closes an external-review gap;
- claims compliance, validation, partnership, pilot, or production readiness.

The change must link to the issue, decision or ADR, evidence, reviewer, and affected requirements.

## 22. Approval record

| Role | Name | Decision | Date | Conditions/notes |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Approved | 2 August 2026 | Approval was expressed by merging PR #9; metadata was corrected immediately afterward. No external validation is implied. |
| Municipal service owner | Unassigned | External validation required | — | Required before municipal pilot authorization. |
| Municipal domain lead | Unassigned | External validation required | — | Required before municipal workflow and policy claims. |
| Privacy officer / FG delegate | Unassigned | External validation required | — | Required before lawful-basis, DPIA/FRAIA, retention, or real-data claims. |
| Security lead / CISO delegate | Unassigned | External validation required | — | Required before BIO2/security or operational-pilot claims. |
| Accessibility specialist | Unassigned | External validation required | — | Required before formal WCAG/EN 301 549 conformance claims. |
| Legal/procurement specialist | Unassigned | External validation required | — | Required before contractor, warranty, licence, or procurement claims. |

Product Owner approval freezes this stakeholder and responsibility baseline for continued Sprint 0 work. It does not close any external-review gap.
