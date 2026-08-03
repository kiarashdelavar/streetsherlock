# Sprint 1 Ready Backlog

| Field | Value |
|---|---|
| Document ID | DEL-S1-READY-001 |
| Version | 1.0 |
| Status | Approved |
| Sprint | Sprint 1 — Engineering foundation and platform controls |
| Owner | Kiarash Delavar |
| Product Owner approval | Approved under standing authorization — 3 August 2026 |
| Source | Master Project Specification v2.0; PROD-REQ-001 v1.0; PROD-TRACE-001 v1.0 |
| Last updated | 3 August 2026 |

## 1. Sprint goal

Create a clean-clone, testable engineering foundation in which synthetic persisted `Report` and `Incident` data travel from PostgreSQL through an authorized Spring API and generated TypeScript client to an accessible Next.js map and equivalent list.

The increment must also prove module boundaries, migrations, contracts, identity boundaries, privacy-safe diagnostics, deterministic fixtures, container builds and CI gates. It does not implement citizen intake, AI extraction, duplicate recommendations, privacy transformation, workflow automation or InfraProof.

## 2. Approval boundary

Product Owner approval accepts the Sprint 1 backlog structure, order, scope and Definition-of-Ready assessment. It does **not**:

- authorize implementation before Sprint 0 exit;
- accept any story as Done;
- claim that clean-clone, security, privacy, accessibility, recovery or performance evidence has passed;
- authorize real personal, municipal, contractor or KLIC data;
- authorize Demo, shadow-pilot or Production deployment;
- replace independent municipal, privacy, legal, security or accessibility review.

## 3. Backlog register

| Order | ID | Issue | Outcome | SP | Labels | Dependencies | Readiness |
|---:|---|---|---|---:|---|---|---|
| 1 | E01-01 | #31 | pinned monorepo and root commands | 5 | platform, enabler, P0, good-first-slice | none | Ready after E00-09 |
| 2 | E01-02 | #32 | Postgres/PostGIS/pgvector and Flyway | 5 | data, enabler, P0, data-licence risk | E01-01 | Scheduled |
| 3 | E01-03 | #33 | Spring modular monolith and boundary tests | 5 | API, enabler, P0 | E01-01 | Scheduled |
| 4 | E01-04 | #34 | accessible Next.js application shell | 5 | web, enabler, P0, accessibility risk | E01-01 | Scheduled |
| 5 | E01-05 | #35 | FastAPI health and contract stub | 3 | vision, enabler, P1, AI risk | E01-01 | Scheduled |
| 6 | E01-06 | #36 | OIDC/dev identity boundary and roles | 8 | API, enabler, P0, security/privacy risk | E01-03 | Scheduled |
| 7 | E01-07 | #37 | problem details, correlation, safe logging and health | 5 | API, enabler, P1, security/privacy risk | E01-03 | Scheduled |
| 8 | E01-08 | #38 | generated TypeScript client and drift gate | 5 | platform, enabler, P1, breaking-change | E01-03, E01-04 | Scheduled |
| 9 | E01-09 | #39 | CI matrix, empty migration, builds and scans | 8 | platform, enabler, P0, security risk | E01-01..05 | Scheduled |
| 10 | E01-10 | #40 | deterministic synthetic Deventer seed | 3 | data, enabler, P1, data/privacy risk | E01-02, E01-06 | Scheduled |
| 11 | E01-11 | #41 | persisted Report/Incident accessible map and list | 8 | web, story, P0, accessibility/privacy risk | E01-04, E01-08, E01-10 | Scheduled |
| 12 | E01-12 | #42 | deployment, rollback and environment skeletons | 3 | platform, enabler, P1, security/privacy risk | E01-09 | Scheduled |

Total planned effort: **63 story points**. This is a controlled scope forecast, not a productivity promise. The Product Owner must protect the vertical goal and may move E01-05 or E01-12 only through an explicit scope decision if capacity evidence requires it.

## 4. Execution waves

### Wave A — repeatable workspace

Start only E01-01. Exit when a clean clone has pinned runtimes, documented prerequisites and root validation commands. No second implementation issue may be In Progress.

### Wave B — independent foundations

After E01-01 is accepted, E01-02 through E01-05 may be worked in dependency-safe order. Solo WIP remains one implementation issue. Each component must start independently and fail clearly.

### Wave C — control boundaries

Implement E01-06 and E01-07 after the Spring boundary exists. Authentication is deny-by-default; diagnostics never expose secrets, tokens, citizen content or restricted fields.

### Wave D — contract and CI gates

E01-08 freezes generated-client discipline. E01-09 makes clean builds, migrations, contracts and minimum security checks merge gates. CI evidence is not production assurance.

### Wave E — first persisted vertical slice

E01-10 creates deterministic synthetic data. E01-11 proves Report/Incident separation through an authorized API and accessible map/list pair. This is the Sprint review centerpiece.

### Wave F — operational skeleton

E01-12 documents and tests the Local/CI/Demo promotion boundary. It cannot create an automatic route to a customer, shadow pilot or Production.

## 5. Definition-of-Ready audit

Each issue #31–#42 contains:

- a plain-language outcome and actor/problem;
- Sprint, epic, story points, owner and reviewers;
- requirement/evidence IDs and dependencies;
- explicit in-scope and out-of-scope boundaries;
- testable acceptance criteria;
- authorization, privacy, audit, API/schema/migration/event, source/licence/model, failure/recovery and accessibility impact;
- stable planned test IDs and evidence expectations;
- documentation updates and Definition-of-Done checklist.

| Ready rule | Result | Evidence or constraint |
|---|---|---|
| outcome and actor are clear | Pass | issue sections |
| requirement IDs and acceptance exist | Pass | issue metadata and checklists |
| dependencies are known | Pass | register and issue dependency fields |
| authorization roles are known | Pass | E01-06 plus deny-by-default acceptance |
| compatibility impact is assessed | Pass | issue impact sections |
| privacy/security/licence/AI/accessibility classified | Pass | labels and impact sections |
| fixtures/test approach exists | Pass | stable test IDs; synthetic fixtures only |
| item fits one sprint | Pass with forecast risk | maximum 8 SP; total capacity reviewed during planning |
| no unresolved decision changes core implementation | Pass for portfolio foundation | external customer values remain outside scope |
| Sprint 0 exit gate is complete | Pending | E00-09 must approve the final exit review |

Therefore the issue set is **content-ready but activation-blocked by E00-09**. E01-01 may move to Ready/In Progress only after the final Sprint 0 gate is merged.

## 6. Label policy applied

The issue set uses the controlled labels:

- area: `area:web`, `area:api`, `area:vision`, `area:data`, `area:platform`, `area:governance`;
- type: `type:story`, `type:enabler`;
- priority: `priority:p0`, `priority:p1`;
- risks: `risk:privacy`, `risk:security`, `risk:ai`, `risk:data-licence`, `risk:accessibility`;
- delivery: `good-first-slice`, `breaking-change`.

A label communicates triage context, not completed assurance. An issue can carry several risk labels without claiming that an independent specialist reviewed it.

## 7. WIP and branch rules

- One implementation issue may be In Progress.
- One review/fix item may be In Review.
- A spike may be active only when the implementation story is externally blocked.
- Each issue uses its own branch and PR.
- A PR links exactly one primary issue and mapped requirement/test IDs.
- No implementation may be bundled with later Sprint 2 or InfraProof work.
- Main must remain runnable after every merge.

## 8. Sprint acceptance path

Sprint 1 is accepted only when:

1. E01-01 through the Product Owner-confirmed sprint cut are merged;
2. a clean-clone run starts the intended Local stack;
3. migrations succeed from empty state and repeat safely;
4. module and contract drift gates pass;
5. unauthorized-role and privacy-safe diagnostics tests pass;
6. the synthetic seed is resettable and provenance-labelled;
7. persisted Report and Incident records appear as distinct concepts on map and equivalent list;
8. CI builds the containers and runs the declared checks;
9. known failures, limitations and deferred work are recorded;
10. the sprint review records exact commit/build/environment evidence.

A green happy-path screenshot is not sufficient evidence.

## 9. Cross-cutting red lines

- PostgreSQL is the sole authoritative business-state store.
- n8n, FastAPI, an AI provider, logs and observability cannot own municipal state or decisions.
- AI is not part of the Sprint 1 decision path.
- No report is deleted or silently merged.
- No raw personal data enters fixtures, logs, errors, screenshots or public output.
- Deventer is a synthetic scenario, not a customer/partner/pilot claim.
- No inaccessible map-only path is accepted.
- No direct unreviewed deployment or real external side effect is allowed.
- No compliance, production readiness, customer RPO/RTO or availability claim is made.

## 10. Risks and controls

| Risk | Trigger | Sprint 1 control | Owner |
|---|---|---|---|
| scope exceeds solo capacity | carry-over or parallel WIP | preserve E01-11 vertical goal; one-item WIP | Product Owner |
| showcase architecture slows delivery | tool without acceptance evidence | remove/defer unused technology; ADR change required | Engineering |
| authorization bypass | route/method lacks negative test | E01-06 deny-by-default matrix | Engineering/Security |
| personal data leakage | fixture/log/error contains content | synthetic-only data and telemetry negative tests | Engineering/Privacy |
| schema/contract drift | generated client differs | E01-08 drift gate | Engineering |
| migration failure | empty/repeat run fails | E01-02 and E01-09 migration gates | Engineering/QA |
| inaccessible GIS UX | map is only route | E01-11 equivalent list and accessibility tests | Web/Accessibility |
| false operational claim | Demo described as production | environment labels and limitations | Product Owner |

## 11. Open external validations

The following remain outside Sprint 1 developer authority:

- municipal workflow/policy correctness;
- lawful bases, notices, retention, DPIA/FRAIA and real-data authorization;
- independent security/BIO2/ASVS assessment;
- independent WCAG/EN 301 549 conformance;
- exact blocked Dutch source licences;
- customer identity, hosting, capacity, RPO/RTO, support and deployment authorization.

These do not block the synthetic Local/CI foundation unless a story tries to cross the approved portfolio boundary.

## 12. Trace actions

| Action | State after this package |
|---|---|
| TA-001 — create Sprint 1 issues for every MVP Must group relevant to the foundation | Completed for E01 scope; later MVP groups remain scheduled in Sprint 2 |
| TA-002 — assign concrete test paths | Planned inside implementation PRs |
| TA-008 — automate orphan/dangling-reference checks | Assigned to E01-09 |
| TA-009 — hero and clean-clone Sprint 0 evidence | Still open in next Sprint 0 package |
| TA-010 — final Sprint 0 trace audit | Still open for E00-09 |

## 13. Approval record

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Approved | 3 August 2026 | Sprint 1 issue structure, ordering, scope, labels and Definition-of-Ready baseline |
| Engineering/QA self-review | Completed | 3 August 2026 | issue completeness and dependency consistency |
| Municipal domain | Pending | — | workflow and policy correctness |
| Security | Pending | — | independent control verification |
| Privacy/legal | Pending | — | lawful processing and real-data use |
| Accessibility | Pending | — | independent conformance evidence |
| Platform/SRE | Pending | — | production capacity/recovery/deployment |

Approval is recorded under Kiarash Delavar's standing instruction to approve the remaining Sprint 0 packages by default. Every implementation and release decision remains separate.
