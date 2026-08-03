# Sprint 1 Engineering Foundation Plan

| Field | Value |
|---|---|
| Document ID | DEL-S1-PLAN-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner standing authorization — 3 August 2026 |
| Sprint goal | Build a reproducible, secure-by-default StreetPulse engineering foundation and one persisted Report/Incident read slice |
| Authorized environments | Local and CI |
| Authorized data | deterministic synthetic fixtures and separately approved precise-licence inputs only |

## 1. Sprint goal

Build the smallest credible engineering foundation that a clean clone can bootstrap, migrate, test and inspect. The sprint ends with persisted, clearly distinct `Report` and `Incident` records shown through authorized APIs and an accessible map/list interface.

This is a foundation sprint. It does not implement citizen submission, duplicate automation, priority decisions, InfraProof, real integrations, a pilot or production.

## 2. Entry decision

Sprint 1 starts after DEL-S0-EXIT-001 is merged. E01-01 is the first active issue. Every later issue must satisfy its dependency gate; issue creation alone does not make it runnable.

Entry conditions:

- Sprint 0 controlled baselines are on `main`;
- issues #31–#42 exist with acceptance criteria and planned evidence;
- real/personal/municipal/KLIC data remains prohibited;
- Local/CI boundaries are understood;
- no implementation is represented as verified before tests run;
- one issue and one branch/PR are active at a time unless an explicitly independent task is approved.

## 3. Ordered backlog and waves

| Wave | Issue | Outcome | Dependency gate |
|---|---|---|---|
| 1 | #31 E01-01 | pinned monorepo and root commands | Sprint 0 exit merged |
| 2 | #32 E01-02 | PostgreSQL/PostGIS/pgvector/Flyway Compose | #31 |
| 2 | #33 E01-03 | Spring Boot modular-monolith boundary | #31 |
| 2 | #34 E01-04 | Next.js application shell and accessible navigation | #31 |
| 2 | #35 E01-05 | FastAPI vision stub and typed health contract | #31 |
| 3 | #36 E01-06 | OpenAPI contract and generated TypeScript client | #33, #34 |
| 3 | #37 E01-07 | problem details, correlation, safe logging and health | #33 |
| 3 | #38 E01-08 | Report/Incident schema, migrations and persistence | #32, #33 |
| 3 | #39 E01-09 | CI matrix, migrations, containers and scans | #31–#35 |
| 4 | #40 E01-10 | deterministic synthetic source/fixture seed | #32, #38 |
| 4 | #41 E01-11 | authorized persisted map/list vertical slice | #34, #36, #38, #40 |
| 5 | #42 E01-12 | run clean-clone/foundation acceptance and close Sprint 1 | #31–#41 |

Within a wave, independent work may be reordered only after checking shared files, contracts and dependency risk. The solo-delivery default remains WIP 1.

## 4. Issue execution protocol

For each issue:

1. update `main` and confirm preceding dependency evidence;
2. create one `agent/{issue-description}` branch;
3. restate scope, requirements, risks, ADRs, test IDs and excluded work;
4. implement the smallest end-to-end behavior;
5. add positive, negative, authorization/privacy and failure/recovery tests that apply;
6. run the documented checks from a clean enough environment;
7. update traceability, run instructions and controlled design only when reality changed;
8. open one focused PR with expected/actual evidence and limitations;
9. review, merge and delete the branch before activating the next dependent item.

Do not batch all twelve issues into one branch. Do not silently broaden an issue because a later feature appears convenient.

## 5. Non-negotiable engineering rules

- PostgreSQL owns authoritative business state.
- `Report` and `Incident` are separate aggregates; no source report is deleted by linking.
- AI, CV, n8n, Sentry and external adapters are replaceable and never own official decisions.
- Authorization is deny by default and enforced server-side.
- Restricted originals, safe derivatives, public projections, audit data and operational telemetry remain separated.
- Logs/errors/evidence use allowlists and contain no secrets or restricted payloads.
- External providers fail visibly while persisted state and a human/manual path remain usable.
- Fixtures are deterministic, synthetic or precisely licensed and carry provenance/integrity metadata.
- Map functionality has an equivalent accessible list path.
- Migrations run from empty and repeatedly without hidden local state.
- A test result names commit/build, environment, fixture version, expected/actual result and limitations.

## 6. Change control

Stop and create/update a controlled decision before proceeding when work:

- changes the Report/Incident boundary or human decision authority;
- introduces a new provider, source, model, data class, licence or environment;
- changes an API/state/event contract outside the active issue;
- crosses from Local/CI into Demo, pilot or Production;
- introduces real citizen, municipal, contractor or KLIC data;
- changes retention, deletion, backup or public visibility;
- weakens an accepted security/privacy/accessibility control;
- expands InfraProof or Sprint 2 scope into Sprint 1.

A reversible implementation detail consistent with approved baselines may be decided in the issue/PR; a material architecture/product/governance change requires impact analysis and the appropriate ADR or baseline update.

## 7. Evidence expectations

Minimum evidence per implementation PR:

| Area | Evidence |
|---|---|
| source | exact commit and focused diff |
| environment | Local/CI label, tool versions and non-secret configuration fingerprint |
| build | reproducible command and result |
| tests | IDs, expected/actual, machine-readable report |
| data | fixture manifest, provenance and hashes |
| database | migration list/schema assertion where applicable |
| authorization/privacy | negative result and restricted-marker scan where applicable |
| failure/recovery | unavailable/invalid/retry behavior |
| accessibility | automated and manual keyboard/semantic result for changed UI |
| limitations | explicit Not Run, Blocked, Later and external-review items |
| trace | requirement, risk/ADR, issue, PR and evidence links |

Screenshots may support visual review but do not prove authorization, privacy, data integrity, migrations, idempotency or recovery.

## 8. Sprint controls and stop conditions

Sprint work pauses when:

- a required dependency is missing or contradictory;
- a critical/high security, privacy, authorization or integrity defect is found;
- tests expose restricted data, secrets or unsafe publication;
- a required source/licence decision is unclear;
- schema/API/generated-client drift cannot be explained;
- clean-clone behavior depends on hidden files, stale volumes or live external services;
- a proposed shortcut makes AI/workflow state authoritative;
- scope requires an external decision or authorization that remains pending.

Record the blocker and owner; do not fabricate a developer-owned resolution for an external gap.

## 9. Exit gate

Sprint 1 closes only when:

- issues #31–#42 meet their Definition of Done or an approved scope change records why not;
- one clean revision runs the applicable QA-CLONE-001 phases;
- the foundation acceptance slice persists and reads separate Report/Incident records;
- map/list parity and core keyboard/error states are evidenced;
- empty/repeated migrations, health, problem responses and contract drift checks pass;
- CI checks and container builds are reproducible;
- fixtures are synthetic, traceable and privacy-safe;
- no open critical/high safety, authorization, privacy or integrity failure remains;
- traceability links actual implementation and test evidence;
- all unsupported production/compliance/pilot claims remain absent.

QA-HERO-001's full 14-step product journey is not a Sprint 1 foundation exit requirement unless the Master Specification explicitly assigns a subset. The full hero remains a later MVP/release gate.

## 10. Sprint 1 decision boundary

Product Owner approval authorizes implementation of issues #31–#42 in Local/CI with synthetic data. It does not authorize:

- real citizen, municipal, contractor or KLIC data;
- live municipal integrations or write-back;
- Demo publication, shadow pilot or Production;
- autonomous duplicate, priority, status, repair, warranty or contractor decisions;
- InfraProof implementation;
- Sprint 2 work;
- a licensed public release before E00-10 implementation obligations pass;
- GDPR, BIO2, ASVS, WCAG, EN 301 549, accuracy, reliability or production-readiness claims.

## 11. Approval record

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Approved | 3 August 2026 | Sprint 1 goal, ordering, WIP, evidence and exit gates |
| Engineering/QA self-review | Completed | 3 August 2026 | dependency and test-plan consistency |
| Independent assurance roles | Pending | — | retained at their future gates |

Approval is recorded under Kiarash Delavar's standing instruction to approve the remaining Sprint 0 packages by default.
