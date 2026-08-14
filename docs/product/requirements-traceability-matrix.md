# Requirements Traceability Matrix

| Field | Value |
|---|---|
| Document ID | PROD-TRACE-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner approved — 3 August 2026 |
| Catalogue | PROD-REQ-001 v1.0 |
| Last updated | 14 August 2026 |

## 1. Purpose

This matrix provides bidirectional traceability between stakeholder/product intent, controlled requirements, architecture and risk controls, journeys, planned verification and evidence. A trace is a relationship, not proof. Every implementation and verification field is **Planned**, **Blocked** or **Later** until an actual PR, test result or reviewed artefact is linked.

## 2. Trace model

~~~mermaid
flowchart TB
    Source["Approved source / stakeholder need"] --> Req["Requirement ID"]
    Req --> Design["ADR / architecture / UX"]
    Req --> Risk["Risk / threat / privacy gap"]
    Req --> Work["Sprint issue / implementation PR"]
    Req --> Test["Acceptance test ID"]
    Test --> Evidence["Versioned evidence"]
    Evidence --> Gate["Human release decision"]
~~~

Trace rules:

- upstream sources justify requirements;
- downstream links show intended realization and verification;
- no design document counts as test evidence;
- no passing test grants legal, privacy, security, accessibility or municipal approval;
- blocked values stay blocked even when surrounding implementation exists;
- human release decisions remain separate from automated results.

## 3. Verification method codes

| Code | Method |
|---|---|
| AT | journey/acceptance test |
| API | API contract/integration test |
| AUTH | authorization/IDOR matrix |
| SEC | security negative/abuse test |
| PRIV | privacy/publication/telemetry test |
| A11Y | automated plus manual accessibility test |
| PERF | controlled performance measurement |
| RES | resilience/fault-injection test |
| REC | isolated backup/restore exercise |
| ARCH | architecture/dependency/configuration check |
| DOC | controlled document/review audit |
| LEG | accountable legal/licence decision |
| EXT | independent specialist/municipal review |

## 4. Citizen and public traceability

| Requirement | Upstream source | Design/journey trace | Risk/control trace | Planned test | Evidence state |
|---|---|---|---|---|---|
| FR-CIT-001 | UX-SB-001, PRIV-DC-001 | Citizen intake; context/container diagrams | tracking and intake threats | AT-CIT-001, API-CIT-001 | Planned |
| FR-CIT-002 | UX-WF-001 | Intake wireframes; location contract | location privacy/validation | AT-CIT-002 | Planned |
| FR-CIT-003 | SEC-TM-001, PRIV-DC-001 | Upload boundary; object zones | upload abuse, parser, malware, metadata | SEC-UP-001..008 | Planned |
| FR-CIT-004 | UX-WF-001 | Review step | unintended disclosure/incorrect submission | AT-CIT-003 | Planned |
| FR-CIT-005 | OPS-SLO-001 | DB transaction and receipt state | false success, duplicate retry | RES-CIT-001, API-CIT-002 | Planned |
| FR-CIT-006 | SEC-TM-001, PRIV-DC-001 | Public tracking projection | guessing, replay, leakage | AUTH-TRACK-001..006 | Planned |
| FR-CIT-007 | PRIV-DC-001, SEC-TM-001 | original/derivative split | unsafe publication/signed URL | PRIV-PUB-001..006 | Planned |
| FR-CIT-008 | UX-STATE-001 | recoverable draft state | session loss/local exposure | AT-CIT-004 | Planned |
| FR-CIT-009 | UX-STATE-001 | failure-state matrix | lost/duplicated accepted state | AT-CIT-005..011 | Planned |
| FR-PUB-001 | UX-WF-001, PRIV-DC-001 | public projection | IDOR/field/media disclosure | AUTH-PUB-001, PRIV-PUB-007 | Planned |
| FR-PUB-002 | UX-WF-001 | map/list equivalence | inaccessible map-only access | A11Y-PUB-001 | Planned |
| FR-PUB-003 | SRC-REG-001, ARCH-ENV-001 | public result metadata | stale/misrepresented source | AT-PUB-002 | Planned |

## 5. Municipal workflow traceability

| Requirement | Upstream source | Design/journey trace | Risk/control trace | Planned test | Evidence state |
|---|---|---|---|---|---|
| FR-INT-001 | SEC-TM-001, NFR-001 | intake queue/container | IDOR, unbounded query, enumeration | AUTH-INT-001, PERF-QUERY-001 | Planned |
| FR-INT-002 | ARCH-DFD-001, UX-WF-001 | staff detail view | provenance confusion, restricted content | AT-INT-001 | Planned |
| FR-INT-003 | ADR-006, OPS-SLO-001 | advisory duplicate service | auto-merge, model failure/bias | AT-DUP-001, RES-AI-001 | Planned |
| FR-INT-004 | ARCH-SM-001, ADR-003 | assessment state machine | unauthorized/opaque decision | API-DEC-001, AUTH-DEC-001 | Planned |
| FR-INT-005 | ADR-006, SEC-TM-001 | override interaction | unaccountable override | API-DEC-002, DOC-AUD-001 | Planned |
| FR-INT-006 | UX-STATE-001 | conflict recovery state | lost update | API-CON-001, AT-CON-001 | Planned |
| FR-INT-007 | ADR-003, PRIV-DC-001 | publication gate | autonomous/unsafe publication | PRIV-PUB-008, AUTH-PUB-002 | Planned |
| FR-INT-008 | ADR-005, OPS-SLO-001 | transactional outbox | loss, replay, duplicate effect | RES-OUT-001..006 | Planned |
| FR-INT-009 | ARCH-ENV-001, UX-STATE-001 | degraded/manual states | false certainty/provider dependency | RES-DEP-001..006 | Planned |
| FR-INT-010 | ARCH-SM-001 | closure state transition | unauthorized closure | API-STATE-001, AUTH-STATE-001 | Planned |
| FR-INT-011 | ARCH-SM-001 | reopen transition | history mutation | API-STATE-002 | Planned |
| FR-INT-012 | ADR-004, OPS-SLO-001 | audit envelope | missing/tampered evidence | API-AUD-001, SEC-AUD-001 | Planned |

## 6. InfraProof later-release traceability

| Requirement | Source/design | Principal risk | Planned verification | Evidence state |
|---|---|---|---|---|
| FR-INF-001 | UX-WF-001 inspector concepts | offline conflict, excessive collection | AT-INF-001, PRIV-INF-001 | Later |
| FR-INF-002 | PRIV-DC-001, SEC-TM-001 | contractor IDOR/contact/original exposure | AUTH-CON-001..006 | Later |
| FR-INF-003 | ADR-003 | contractor becomes official decision-maker | API-CON-DEC-001 | Later |
| FR-INF-004 | PRIV-DC-001 | re-identification and unauthorized drill-down | PRIV-GOV-001, AUTH-GOV-001 | Later |
| FR-INF-005 | SRC-REG-001 | unlawful/unsupported KLIC use | LEG-KLIC-001, ARCH-FIX-001 | Blocked |

## 7. Data and integration traceability

| Requirement | Architecture/decision | Threat/privacy/source trace | Planned test | Evidence state |
|---|---|---|---|---|
| DR-001 | ADR-001, ADR-005, container diagram | authority confusion, workflow/cache truth | ARCH-AUTH-001 | Planned |
| DR-002 | ADR-002, DFD/object zones | privacy publication, signed URL | AUTH-OBJ-001, PRIV-OBJ-001 | Planned |
| DR-003 | provenance model/ERD | derivation ambiguity, unverifiable output | API-PROV-001, DOC-PROV-001 | Planned |
| DR-004 | source register | unclear licence, stale/current misclaim | LEG-SRC-001, ARCH-SRC-001 | Blocked in part |
| DR-005 | fixture manifest | tampering/non-reproducible demo | ARCH-FIX-001..004 | Planned |
| DR-006 | environment architecture | cross-environment promotion/restore | ARCH-ENV-001, REC-ENV-001 | Planned |
| DR-007 | privacy baseline, recovery plan | over-retention, resurrection after restore | PRIV-LIFE-001, REC-DEL-001 | Blocked |
| DR-008 | threat model, recovery plan | secret leakage/supply chain | SEC-SECRET-001..005 | Planned |

## 8. Quality and governance traceability

| Requirement | Primary baseline | Planned verification | Blocking decision or gate | Evidence state |
|---|---|---|---|---|
| QR-SEC-001 | SEC-TM-001, NFR-001 | AUTH-MATRIX-001 | independent security review later | Planned |
| QR-SEC-002 | SEC-TM-001 | SEC-UP-001..008 | parser/AV design review | Planned |
| QR-SEC-003 | SEC-TM-001 | SEC-CAP-001..008 | key/custody design | Planned |
| QR-PRIV-001 | PRIV-DC-001, OPS-SLO-001 | PRIV-TEL-001..010 | processor/config decision | In progress — #37 covers PRIV-TEL-001..006; verification pending |
| QR-PRIV-002 | PRIV-DC-001 | EXT-PRIV-001 | lawful basis, notices, retention, DPIA | Blocked |
| QR-A11Y-001 | UX-STATE-001, NFR-001 | A11Y-CORE-001 | declared criteria/reviewer | Planned |
| QR-A11Y-002 | UX-WF-001, NFR-001 | A11Y-CORE-002 | independent accessibility review | Planned |
| QR-PERF-001 | NFR-001, OPS-SLO-001 | PERF-API-001 | declared demo profile | Planned |
| QR-PERF-002 | NFR-001, OPS-SLO-001 | PERF-MAP-001 | declared snapshot/profile | Planned |
| QR-PERF-003 | NFR-001, OPS-SLO-001 | PERF-DUP-001 | provider/profile | Planned |
| QR-REL-001 | OPS-SLO-001 | RES-HEALTH-001, RES-SUITE-001 | implemented fault controls | In progress — #37 covers health foundation; broader resilience planned |
| QR-REL-002 | ADR-005, OPS-SLO-001 | RES-OUT-001..006 | outbox implementation | Planned |
| QR-REC-001 | OPS-BR-001 | REC-ISO-001 | no customer RPO/RTO claim | Planned |
| QR-PORT-001 | ARCH-ENV-001, NFR-001 | CLONE-001 | Sprint 0 clean-clone package | Planned |
| QR-MAIN-001 | ADR register, NFR-001 | API-ERR-001..006, CONTRACT-001..006, ARCH-CI-001 | Sprint 1 CI implementation | In progress — #37 and #38 foundations; broader CI remains planned |
| GR-001 | glossary/RACI/governance logs | DOC-CTRL-001 | approval before merge | Planned |
| GR-002 | decision log | DOC-PR-001 | Product Owner decision | Planned |
| GR-003 | PROD-TRACE-001 | CONTRACT-001..006, DOC-TRACE-001 | zero unexplained orphans | In progress — #38 contract trace implemented; broader audit planned |
| GR-004 | RACI/external gap register | DOC-ASSURE-001 | accountable independent reviewer | Planned |
| GR-005 | ARCH-ENV-001 | DOC-ENV-GATE-001 | separate customer authorization | Planned |
| GR-006 | PROD-REQ-001 | DOC-CHANGE-001 | controlled impact analysis | Planned |

## 9. Source-to-requirement coverage

| Source baseline | Covered obligation areas | Requirement families | Coverage state |
|---|---|---|---|
| Product vision/scope and glossary | actors, vocabulary, MVP boundary, human authority | FR-CIT, FR-PUB, FR-INT, GR | Covered |
| Personas, stakeholders and RACI | visibility, decisions, solo/external roles | FR-*, GR-004/005 | Covered |
| Architecture diagrams | trust boundaries, state, data, authority | FR-INT, DR, QR | Covered |
| ADR-001..010 | database, storage, audit, outbox, advisory services, tenancy | FR-INT, DR, QR | Covered |
| RAID and decision logs | known risks, assumptions, dependencies, gaps | QR, GR, blocked decisions | Covered; remains living |
| Source/licence/provenance register | source permission, fixtures, integrity, KLIC | FR-PUB-003, FR-INF-005, DR-003..005 | Covered |
| Service blueprint/wireframes/state matrix | journeys, roles, accessibility, recovery | FR-CIT, FR-PUB, FR-INT, FR-INF, QR-A11Y | Covered |
| Threat model | abuse cases and control obligations | FR-CIT/INT, DR, QR-SEC | Covered |
| Privacy/data classification | classes, visibility, publication, retention, DPIA | FR-CIT/PUB/INF, DR-002/007/008, QR-PRIV | Covered; external gaps open |
| NFR/SLO/recovery/environment package | measurable targets, resilience, recovery, promotion | QR-PERF/REL/REC/PORT, DR-006/007 | Covered |
| Master Specification | Sprint scope and mandatory evidence | all families | Covered at Sprint 0 baseline; final audit pending E00-09 |

## 10. Requirement-to-work mapping

Sprint 1 implementation issues are now linked as work begins. Links indicate scope and do not by themselves prove verification or acceptance.

| Work item | Requirements | Tests/evidence | State |
|---|---|---|---|
| [E01-07 #37](https://github.com/kiarashdelavar/streetsherlock/issues/37) | QR-PRIV-001; QR-REL-001; QR-MAIN-001 | API-ERR-001..006; PRIV-TEL-001..006; RES-HEALTH-001; [evidence](../testing/e01-07-observability.md) | Implemented; Local/CI test passed before merge |
| [E01-08 #38](https://github.com/kiarashdelavar/streetsherlock/issues/38) | QR-MAIN-001; GR-003 | CONTRACT-001..006; [evidence](../testing/e01-08-openapi-contract.md) | In progress; branch evidence pending independent rerun |
| [E01-09 #39](https://github.com/kiarashdelavar/streetsherlock/issues/39) | QR-MAIN-001; QR-PORT-001; QR-SEC-001 | CI-001..012; SEC-SUPPLY-001..004; [evidence](../testing/e01-09-ci-foundation.md) | In progress; first GitHub CI run pending |
Remaining Sprint 1 backlog work shall:

1. create at least one issue for every MVP **Must** requirement;
2. reference all applicable requirement, threat/risk, ADR, journey and test IDs;
3. include safe failure/recovery acceptance criteria;
4. identify blocked external values without assigning them to a developer as if solvable by code;
5. keep later InfraProof requirements outside Sprint 1 unless Product Owner changes scope;
6. link implementation PRs and exact test/evidence paths after they exist.

| Work state | Meaning |
|---|---|
| Unplanned | no Sprint issue yet; acceptable only before ready-backlog package |
| Ready | issue has scope, dependencies, acceptance and trace IDs |
| In progress | branch/PR exists |
| Implemented | code/config merged; verification may still be missing |
| Verified | declared test evidence passed for named build/environment |
| Accepted | Product Owner/human release decision recorded |
| Blocked | accountable external decision/evidence missing |

Current state for all MVP requirements: **Unplanned/Planned evidence**. This is expected during Sprint 0.

## 11. Orphan and consistency checks

The trace audit shall fail or report an explicit approved gap when:

- a requirement has no upstream source;
- an MVP Must has no acceptance condition or test ID;
- a Sprint issue has no requirement ID;
- a test has no requirement;
- an evidence record has no test/build/environment;
- a requirement claims Verified without evidence;
- an external gap is represented as developer-complete;
- a later requirement appears in MVP without scope approval;
- a source/ADR/threat ID is dangling;
- a changed requirement does not update downstream work/tests;
- a deleted/superseded requirement loses historical trace;
- a public/privacy/security requirement has no negative test.

Initial manual audit:

| Check | Result | Note |
|---|---|---|
| Catalogue requirements without source | 0 | every row has controlled source(s) |
| MVP Must without acceptance | 0 | catalogue acceptance present |
| Requirements without planned verification | 0 | matrix test/method present |
| Requirements falsely marked implemented/verified | 0 | all Planned, Blocked or Later |
| External decisions falsely closed | 0 | eight gaps remain explicit |
| Sprint implementation issues missing | Expected | ready-backlog package remains |
| Exact evidence links missing | Expected | implementation has not begun |

## 12. Evidence record minimum

Each future evidence record contains:

- evidence ID and test ID;
- requirement IDs;
- source commit/build/release;
- environment and configuration;
- fixture/dataset manifest and versions;
- execution time and responsible person/system;
- expected and actual result;
- pass/fail/unknown;
- raw artefact path/hash where applicable;
- limitations, exclusions and follow-up issue;
- reviewer/acceptance decision where required.

Screenshots alone are not sufficient evidence for security, privacy, data integrity, recovery or exact-once behavior.

## 13. Change-impact matrix

| Change type | Mandatory re-check |
|---|---|
| actor/role/visibility | RACI, authorization, privacy, UX, audit tests |
| business state/decision | state machine, ERD, audit, outbox, concurrency |
| upload/media | threat model, privacy classes, object zones, limits, recovery |
| AI/CV/model/prompt | advisory authority, provenance, evaluation, privacy, fallback |
| source/dataset | licence, provenance, fixture manifest, freshness, claims |
| n8n/integration | outbox, authentication, replay, data minimization, manual recovery |
| environment/hosting | privacy, security, secrets, telemetry, backup, release gate |
| retention/deletion | privacy decision, objects, backups, restore and audit |
| performance target | workload profile, SLI/SLO, capacity and evidence |
| later-release scope | Product Owner approval, architecture/risk/privacy/backlog impact |

## 14. Open trace actions

| Action ID | Action | Owner | Due gate | State |
|---|---|---|---|---|
| TA-001 | create Sprint 1 issues for every MVP Must group | Product Owner/Developer | ready-backlog package | Open |
| TA-002 | assign concrete test paths when test harness exists | QA/Developer | implementation PR | Open |
| TA-003 | link exact threat IDs rather than topic groups where practical | Security | security review | Open |
| TA-004 | resolve exact source product/licence gaps | Legal/Data owner | before affected source use | Blocked |
| TA-005 | approve privacy lifecycle and DPIA decisions | Municipality/Privacy/Legal | before real data | Blocked |
| TA-006 | define customer capacity, SLO and recovery values | Municipality/Platform/Product | before pilot | Blocked |
| TA-007 | obtain independent accessibility evidence | Accessibility specialist | before claim/pilot | Blocked |
| TA-008 | run automated orphan/dangling-reference check | Developer/QA | Sprint 1 CI | Open |
| TA-009 | run hero acceptance and clean-clone evidence package | QA/Developer | Sprint 0 exit | Open |
| TA-010 | perform final Sprint 0 trace audit | Product Owner | E00-09 | Open |

## 15. Approval

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Approved | 3 August 2026 | Sprint 0 trace structure, coverage and planned verification only; implementation evidence, release acceptance and external assurance remain pending |
| Municipal domain owner | Pending | — | municipal requirement correctness |
| Privacy officer / FG | Pending | — | privacy requirement and lifecycle trace |
| Security reviewer | Pending | — | threat/control/test trace |
| Accessibility reviewer | Pending | — | accessibility requirement/test trace |
| Platform/SRE reviewer | Pending | — | SLO/recovery/environment trace |
| Legal/licence reviewer | Pending | — | source and disclosure trace |
