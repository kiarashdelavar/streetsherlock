# StreetSherlock RAID Log

## 1. Controlled-document metadata

| Field | Value |
|---|---|
| Requirement | E00-06 |
| Sprint | Sprint 0 — Product freeze and delivery governance |
| Document owner | Kiarash Delavar, Product Owner |
| Version | 1.0 |
| Status | Approved |
| Controlled baseline | Master Project Specification v2.0 |
| Related evidence | Product Charter v1.0; Hero Scenario v1.0; MVP Scope v1.0; Glossary v1.0; Stakeholder/RACI baseline |
| Last updated | 2 August 2026 |
| Review cadence | Weekly during active delivery; at every sprint review and release gate |

## 2. Purpose

This file is the central register for Risks, Assumptions, Issues, and Dependencies. It exists to make uncertainty visible, owned, reviewable, and traceable.

It is not evidence that a municipality, citizen, contractor, privacy officer, security reviewer, accessibility specialist, or legal reviewer has validated StreetSherlock.

## 3. Register rules

1. IDs are permanent and are never reused.
2. Closed entries remain in history; they are not deleted.
3. Every open entry has one owner, a next review or needed-by date, and a concrete action.
4. A solo owner may prepare evidence but cannot self-certify independent assurance.
5. A link to an issue, decision, ADR, requirement, test, or review record is added when available.
6. A material scope, data, authority, integration, AI, privacy, security, accessibility, or release change triggers an immediate review.
7. Dates use ISO format in future updates.
8. Unknown facts stay explicit; they are not converted into optimistic assumptions.
9. AI and automation cannot own or close an item.
10. Municipal, repair, warranty, liability, enforcement, and release decisions remain human-owned.

## 4. Definitions

| Register | Meaning | ID format |
|---|---|---|
| Risk | A possible future event that may harm an outcome | R-01, R-02 |
| Assumption | A condition currently believed for planning but not fully proven | A-01, A-02 |
| Issue | A problem that exists now and needs containment or resolution | I-01, I-02 |
| Dependency | An external decision, person, system, dataset, or deliverable needed by a date | D-01, D-02 |

## 5. Status vocabulary

| Register | Allowed statuses |
|---|---|
| Risk | Open, Mitigating, Monitoring, Realized, Closed |
| Assumption | Unvalidated, Testing, Validated, Invalidated, Expired |
| Issue | Open, Contained, Blocked, Resolved, Closed |
| Dependency | Planned, Waiting, Available, At risk, Blocked, Removed |

A status change requires a date, actor, reason, and evidence link in the history section or linked work item.

## 6. Risk scoring and escalation

Probability and impact use a 1–5 scale.

| Score | Probability | Impact |
|---:|---|---|
| 1 | Rare | Negligible |
| 2 | Unlikely | Minor |
| 3 | Possible | Material |
| 4 | Likely | Major |
| 5 | Almost certain | Critical |

Exposure equals Probability × Impact.

| Exposure | Rating | Minimum response |
|---:|---|---|
| 1–5 | Low | Review at sprint gate |
| 6–10 | Medium | Named mitigation and owner |
| 11–15 | High | Weekly review and contingency |
| 16–25 | Critical | Stop affected promotion or release until accepted by the proper authority |

Any risk involving personal-data exposure, authorization bypass, destructive data loss, hidden AI authority, unsafe public guidance, unsupported liability, or misleading compliance claims is escalated regardless of arithmetic score.

## 7. Risk register

| ID | Risk | P | I | Exposure | Trigger / early warning | Mitigation | Contingency | Owner | Next review | Status |
|---|---|---:|---:|---:|---|---|---|---|---|---|
| R-01 | Scope exceeds realistic solo capacity | 4 | 4 | 16 Critical | Carry-over, growing WIP, or repeated cut-line changes | Protect StreetPulse MVP, one issue/branch at a time, split or defer work | Drop later InfraProof and nonessential tooling; replan release | Product Owner | 2026-08-09 | Mitigating |
| R-02 | Product drifts into replacing Signalen or another MOR intake tool | 3 | 4 | 12 High | Intake, queue, or generic ticketing dominates the demo | Enforce intelligence-layer positioning and adapter boundary | Remove conflicting capability and revise affected documents | Product Owner | 2026-08-09 | Mitigating |
| R-03 | A false duplicate recommendation hides or distorts a citizen report | 3 | 5 | 15 High | Reviewers accept weak candidates or reversals increase | Candidate-only design, preserved Reports, reversible links, evidence and audit | Disable recommendation, unlink safely, restore review queue, investigate | Product/Engineering | 2026-08-09 | Open |
| R-04 | AI or computer vision appears more certain than its evidence | 4 | 5 | 20 Critical | Unsupported confident output, missing provenance, low refusal rate | Calibrated limitations, evidence display, refusal paths, evaluation and human review | Disable model path and use deterministic/manual workflow | AI/Data owner, self-review only | 2026-08-09 | Open |
| R-05 | Photos or text expose personal or sensitive data | 3 | 5 | 15 High | Redaction miss, unrestricted original, public link, telemetry leak | Restricted originals, derived redacted media, access control, scanning and audit | Block publication, revoke access, preserve incident evidence, follow response process | Privacy/Security owner unassigned; Product coordinates | 2026-08-09 | Open |
| R-06 | Warranty logic is interpreted as automatic contractor fault or liability | 3 | 5 | 15 High | Product wording attributes blame or auto-opens a real case | Keep InfraProof later, use candidate language, require inspection/legal decision | Disable warranty workflow and correct communication/evidence | Legal/domain owner unassigned; Product coordinates | 2026-08-09 | Open |
| R-07 | Public data is stale, incomplete, or licence-incompatible | 4 | 4 | 16 Critical | Terms change, provenance missing, update date unknown | E00-07 source register, snapshots, attribution, freshness and licence review | Disable source, delete non-permitted copy, use synthetic data | Data/Legal owner unassigned; Product coordinates | 2026-08-09 | Open |
| R-08 | Technology-showcase architecture slows delivery | 4 | 4 | 16 Critical | Tool exists without a story, test, owner, or operational need | Map every component to acceptance evidence and remove unused technology | Simplify to the smallest working vertical slice | Engineering/Product | 2026-08-09 | Mitigating |
| R-09 | n8n becomes a hidden source of business state | 3 | 4 | 12 High | Workflow determines status or retry causes inconsistent records | Backend remains source of truth; outbox, idempotency, signed callbacks, recovery view | Pause workflows and replay from backend-owned state | Engineering | 2026-08-09 | Open |
| R-10 | Portfolio work is described as production-ready or compliant | 3 | 5 | 15 High | README/demo uses unverified compliance, partnership, or pilot claims | Controlled wording, limitation page, evidence gates, review gaps visible | Retract claim, publish correction, reassess affected material | Product Owner | 2026-08-09 | Mitigating |
| R-11 | Security, privacy, accessibility, or governance work arrives too late | 4 | 5 | 20 Critical | Release-blocking findings appear after implementation | Threat/privacy/accessibility/control tasks begin in Sprint 0 and remain in DoD | Stop release, remediate, narrow scope, obtain independent review | Product/Engineering; specialists unassigned | 2026-08-09 | Open |
| R-12 | No municipality or representative user validates value and workflow | 4 | 4 | 16 Critical | Only technical or self-feedback exists | Prepare ethical discovery plan and seek read-only scenario validation | Keep claims at portfolio level and remove municipal-value claims not evidenced | Product Owner | 2026-08-09 | Open |

## 8. Assumption register

| ID | Assumption | Current evidence | Validation action | Needed by / expiry | Impact if false | Owner | Status |
|---|---|---|---|---|---|---|---|
| A-01 | In an integration scenario, the existing MOR intake remains authoritative for report intake | Approved Product Charter positioning | Validate with a municipal service/system owner before any pilot claim | Before shadow-pilot proposal | Revisit positioning, boundaries, and adapters through change control | Product Owner | Unvalidated |
| A-02 | One Report represents one submitted observation and an Incident represents the managed real-world problem | Approved Glossary v1.0 | Domain workshop with operators and counterexamples | Before municipal-correctness claim | Revise model, requirements, migrations, API, and UX before implementation depends on it | Product/Domain | Testing |
| A-03 | Synthetic Deventer scenarios are sufficient for a portfolio MVP demonstration | Approved Hero Scenario and MVP Scope | Run the acceptance walkthrough without real personal data | Before v0.1.0 demo | Redesign the scenario; do not import real data as a shortcut | Product/QA | Testing |
| A-04 | The six frozen categories cover enough variation to test the MVP workflow | Approved MVP Scope v1.0 | Trace each category to examples and acceptance scenarios | E00-05 | Adjust examples only through controlled scope change | Product/Domain | Testing |
| A-05 | An authorized human reviewer exists in any operational deployment | Stakeholder/RACI baseline | Map actual roles and authorization with a municipality | Before operational pilot | Recommendations cannot produce operational links or priority changes | Municipal service/domain owner unassigned | Unvalidated |
| A-06 | Category, time, location, text, and optional media provide enough evidence for advisory duplicate retrieval | Product hypothesis only | Define dataset and evaluate candidates by category/slice | Before model promotion | Use manual review or narrower deterministic retrieval | AI/Data | Unvalidated |
| A-07 | Factor-level explanations can help reviewers without overstating certainty | Hero Scenario hypothesis | Compare reviewer decisions with and without explanations | Before operational-value claim | Remove or redesign the explanation and score | Product/AI/Domain | Unvalidated |
| A-08 | Contractors can work from a minimized package without citizen identity | Stakeholder/RACI baseline | Privacy, domain, legal, and field workflow review | Before any contractor workflow | Redesign workflow; never expose identity by default | Privacy/Domain/Legal unassigned | Unvalidated |
| A-09 | PostgreSQL extensions and local supporting services can run in the target development environment | Master Specification architecture proposal | Prove with clean-clone Compose acceptance test | Sprint 1 foundation | Use a documented compatible development fallback or revise ADR | Engineering | Unvalidated |
| A-10 | A local Ollama-compatible model can support development without becoming a hard product dependency | Master Specification proposal | Benchmark defined model/provider interface on available hardware | Before AI implementation | Use deterministic stubs or alternate approved provider through the same boundary | AI/Engineering | Unvalidated |
| A-11 | A licence-compatible public snapshot can improve engineering/evaluation without creating redistribution risk | No licence approval yet | Complete E00-07 provenance and licence review | Before adding any public snapshot | Use synthetic-only datasets | Data/Legal unassigned | Unvalidated |
| A-12 | One developer can deliver the vertical slice while maintaining governance and test evidence | Current solo-delivery plan | Review velocity, WIP, defects, and carry-over each sprint | Every sprint review | Reduce scope, extend schedule, or seek contributors/reviewers | Product Owner | Testing |

## 9. Issue register

| ID | Current issue | Severity | Containment | Resolution target | Owner | Evidence / link | Status |
|---|---|---|---|---|---|---|---|
| I-01 | E00-04 was merged before controlled approval metadata was recorded | Medium | Separate correction PR; do not repeat approval-after-merge | Merge PR #10 and keep the deviation visible | Product Owner | PR #10; Issue #8 | Contained |
| I-02 | No named municipal domain or operational reviewer has validated workflow semantics | High | Keep all municipal-correctness and pilot claims prohibited | Identify reviewers and run structured scenario/domain review before pilot claim | Product Owner | REV-001 in stakeholder baseline | Open |
| I-03 | Privacy, security, accessibility, legal, and independent release reviewers are unassigned | High | Keep external validations open and production/pilot gates unavailable | Assign real reviewers only when a real deployment or formal review exists | Product Owner coordinates | REV-003 to REV-005, REV-011, REV-012 | Open |
| I-04 | Public/synthetic source licence and provenance decisions are not baselined | High | Synthetic-only data boundary; no unreviewed dataset committed | Complete E00-07 | Product/Data | E00-07 | Open |
| I-05 | Testable MVP requirement catalogue and traceability matrix are not yet baselined | High | No application coding begins from informal requirements | Complete and approve E00-05 | Product/QA | E00-05 | Open |
| I-06 | Service blueprint, wireframes, and accessibility journey evidence are not baselined | Medium | Use approved hero flow only; no final UI claims | Complete E00-08 | UX/Product | E00-08 | Open |
| I-07 | Architecture proposals have not yet been reviewed through ADRs | High | Keep technical decisions Proposed and do not treat the Master Specification as accepted ADR evidence | Complete Day 2 diagrams and ADR review | Engineering | Decision log D-09 to D-18 | Open |
| I-08 | E00-06 was merged before controlled approval metadata was recorded | Medium | Preserve the deviation and correct metadata in a separate PR | Merge the E00-06 approval-cleanup PR; require explicit approval before future merges | Product Owner | PR #12 and E00-06 approval-cleanup PR | Contained |

## 10. Dependency register

| ID | Dependency | Type / provider | Required by | Fallback | Owner | Evidence / link | Status |
|---|---|---|---|---|---|---|---|
| D-01 | Requirement catalogue and traceability matrix | Internal deliverable E00-05 | Sprint 1 backlog approval | Do not start implementation tickets | Product/QA | E00-05 | Planned |
| D-02 | Source licence and provenance review | Internal plus external legal/data expertise, E00-07 | Before any public-data snapshot | Synthetic-only data | Product/Data | E00-07 | Planned |
| D-03 | Service blueprint and wireframes | Internal deliverable E00-08 | Before frontend story readiness | Use hero acceptance flow only; no final UI | Product/UX | E00-08 | Planned |
| D-04 | Architecture diagrams and ADR decisions | Internal technical review | Before affected Sprint 1 implementation | Keep choices Proposed; run time-boxed spike if needed | Engineering | ADR-001 to ADR-010 | Planned |
| D-05 | Named independent municipal, privacy, security, accessibility, legal, and QA reviewers | External people/organizations | Before relevant pilot, compliance, or production claim | Stay at portfolio/demo tier | Product Owner coordinates | REV-001 to REV-012 | Waiting |
| D-06 | Real municipal API, data mapping, identity, and service ownership agreements | External municipality/system owners | Before integration or shadow pilot | Synthetic adapters and no write-back | Pilot/integration owner unassigned | Pilot entry criteria | Waiting |
| D-07 | Representative historical data and ground truth | External data owner/domain reviewers | Before model performance or value claims | Synthetic evaluation with explicit limits | Data/AI | Future dataset card | Waiting |
| D-08 | Suitable local AI runtime and hardware capacity | Local environment/provider | Before AI service implementation | Deterministic stub and provider interface | Engineering/AI | Future ADR-005 and benchmark | Planned |
| D-09 | Repository licence and disclosure strategy | Product/legal decision E00-10 | Before public release | Keep repository private and make no reuse promise | Product Owner; legal review if needed | E00-10 | Planned |

## 11. Cross-register rules

- When a risk occurs, mark it Realized and create or link an Issue.
- When an assumption is invalidated, review affected decisions, requirements, ADRs, estimates, and risks.
- When a dependency becomes Blocked, apply its fallback and reassess the release cut line.
- When an issue changes product or architecture direction, create or update a Decision record.
- When external evidence closes a gap, record reviewer identity, scope, date, result, conditions, and evidence. A placeholder name is insufficient.
- A closed item may be reopened with a new history entry; its original history remains immutable.

## 12. Review and escalation cadence

| Trigger | Required action |
|---|---|
| Weekly active-delivery review | Review Critical/High risks, overdue assumptions, open High issues, and At-risk/Blocked dependencies |
| Sprint planning | Confirm every selected item has no hidden blocked dependency |
| Sprint review | Update all registers, record realized risks, expired assumptions, and new decisions |
| Before data/model promotion | Review data, licence, privacy, security, evaluation, and reviewer dependencies |
| Before release | No unaccepted Critical exposure; residual risk owners and limitations recorded |
| Scope-tier promotion | Obtain the accountable external approvals defined by the stakeholder/RACI baseline |
| Security/privacy/authority incident | Stop affected work, contain, preserve evidence, and escalate immediately |

## 13. Update history

| Date | Actor | Change | Evidence |
|---|---|---|---|
| 2026-08-02 | Kiarash Delavar / delivery agent | Created initial RAID baseline for E00-06 | Issue #11 and PR #12 |
| 2026-08-02 | Kiarash Delavar / delivery agent | Recorded Product Owner approval after merge and preserved the process deviation | PR #12 and E00-06 approval-cleanup PR |

## 14. Acceptance traceability

| Issue #11 criterion | Result | Evidence |
|---|---|---|
| Four linked registers | Pass | Sections 7–10 |
| Stable IDs, statuses, owners, dates, evidence/fallback | Pass | Sections 3–10 |
| Twelve initial programme risks | Pass | Section 7 |
| Known assumptions and open questions centralized/traced | Pass | Sections 8–10 |
| Current assurance/licence/stakeholder/delivery gaps visible | Pass | Sections 9–10 |
| Risk scoring and escalation | Pass | Sections 6 and 12 |
| Human authority and external assurance boundary | Pass | Sections 2–3, 7–12 |
| No unrelated/code changes | Pass | PR #12 and PR #13 changed only the intended E00-06 documentation files |
| Product Owner approval before merge | Not met — process deviation recorded | PR #12 was merged before controlled approval metadata was recorded; Section 15 records the later approval without rewriting history |

## 15. Approval record

| Role | Name | Decision | Date | Conditions / notes |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Approved | 2 August 2026 | Approval was expressed by merging PR #12 and recorded afterward. This does not approve Proposed architecture decisions or imply external validation. |
| Municipal domain reviewer | Unassigned | External validation required | — | Required before municipal workflow claims |
| Privacy reviewer | Unassigned | External validation required | — | Required before real personal data or privacy-compliance claims |
| Security reviewer | Unassigned | External validation required | — | Required before security/BIO2 claims or operational pilot |
| Accessibility reviewer | Unassigned | External validation required | — | Required before formal conformance claims |
| Legal/data-licence reviewer | Unassigned | External validation required | — | Required before relevant dataset, contractor, warranty, or procurement claims |
