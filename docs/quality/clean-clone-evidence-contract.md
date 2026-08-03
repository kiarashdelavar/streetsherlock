# Clean-Clone Evidence Contract

| Field | Value |
|---|---|
| Document ID | QA-CLONE-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner standing authorization — 3 August 2026 |
| Current execution state | Not Run — Sprint 1 engineering foundation pending |
| Applies to | Sprint 1 acceptance and later release candidates |

## 1. Purpose

This contract defines how StreetSherlock proves that a named revision can be obtained and operated from a clean machine without hidden developer state. Sprint 0 approves the protocol. It cannot pass the protocol before E01-01 and its dependent implementation exist.

## 2. Clean starting condition

The verifier starts from a disposable runner or fresh directory with:

- no previous repository checkout, generated files, package caches required for correctness, containers, volumes or application data;
- no untracked local configuration;
- only documented prerequisites at pinned supported versions;
- repository access and explicitly documented non-secret example configuration;
- secrets supplied through the approved CI/local secret mechanism, never committed;
- network availability recorded; the deterministic CI path must not require live municipal, AI, map, weather, mail or workflow services.

The repository revision, default branch, tag if any, and full commit SHA are recorded before execution. A dirty worktree invalidates the run.

## 3. Planned protocol

Command names below are acceptance interfaces to be implemented/frozen by E01-01. Until then their result is **Not Run**, not Failed.

| ID | Phase | Required behavior |
|---|---|---|
| CCT-001 | acquire | clone repository, select exact SHA, prove clean worktree |
| CCT-002 | inspect | README lists supported OS/runtime/container prerequisites and architecture boundary |
| CCT-003 | configure | create local config only from documented examples; detect missing/unknown secrets safely |
| CCT-004 | verify tools | one root command reports pinned Node, Java, Python, package-manager and container versions |
| CCT-005 | install | one documented root workflow restores locked dependencies reproducibly |
| CCT-006 | validate licences | dependency/source checks fail clearly on prohibited or unapproved material |
| CCT-007 | build | root build compiles web, API and vision stub without hidden files |
| CCT-008 | start dependencies | Local Compose starts only declared Local services with health checks |
| CCT-009 | migrate empty | Flyway migrates a new PostgreSQL/PostGIS/pgvector database from empty |
| CCT-010 | migrate repeat | second migration run is safe and produces no drift |
| CCT-011 | seed | deterministic synthetic seed loads with provenance labels and stable identifiers |
| CCT-012 | start apps | documented command starts intended services with bounded timeout and useful failures |
| CCT-013 | smoke | health/readiness and authorized persisted Report/Incident API checks pass |
| CCT-014 | accessible UI | distinct Report/Incident data appears in map and equivalent list with keyboard access |
| CCT-015 | contracts | OpenAPI/generated client and schema/module-boundary drift checks pass |
| CCT-016 | tests | declared unit, integration, authorization, privacy and UI smoke suites pass |
| CCT-017 | containers | declared images build and record immutable digests |
| CCT-018 | stop | documented stop command terminates processes without deleting evidence |
| CCT-019 | reset | explicit safe reset removes only named Local project data and recreates deterministically |
| CCT-020 | collect | machine-readable evidence bundle and limitations report are produced |

No destructive command may target an unresolved variable, home directory, filesystem root or broad Docker state. Reset must verify the project/environment identifier and require an explicit Local-only target.

## 4. Evidence manifest

A clean-clone record includes:

| Field | Requirement |
|---|---|
| run ID | unique and stable |
| source | repository URL, branch/tag and full SHA |
| runner | OS/architecture and disposable-runner identifier |
| tools | exact runtime, package-manager, Docker/Compose versions |
| time | UTC start/end and duration per phase |
| configuration | non-secret fingerprint and environment label |
| dependencies | lockfile hashes and resolved dependency reports |
| fixtures | provenance manifest ID and SHA-256 |
| database | extension versions, migration list and schema fingerprint |
| services | image digests, health/readiness results and ports without secrets |
| tests | test IDs, commands, expected/actual and report paths |
| telemetry scan | assertion that secrets/restricted markers are absent |
| outcome | Pass, Fail, Blocked or Invalid with failed phase |
| follow-up | linked issue, owner and retry condition |
| integrity | SHA-256 for retained evidence artefacts |

## 5. Pass and failure rules

A run passes only when CCT-001..020 pass in order on one unchanged commit and configuration. Manual repair, undocumented command, stale volume, prebuilt local artefact or live-provider dependency invalidates the run.

Failures must:

- stop at or clearly isolate the failing phase;
- preserve relevant privacy-safe diagnostics;
- avoid reporting later phases as passed unless independently valid;
- create a traceable remediation issue;
- leave no running external side effect;
- never expose secret values or restricted content.

Blocked external reviews do not invalidate a synthetic Local/CI foundation unless the run crosses their boundary. Real-data, Demo/pilot or Production claims require their own authorization and evidence.

## 6. Negative checks

The clean-clone suite must verify:

1. missing prerequisite produces one actionable message;
2. unsupported runtime is rejected before build;
3. missing secret names are reported without values;
4. wrong environment or non-Local reset aborts;
5. live external providers are not required for deterministic CI;
6. empty and repeated migrations behave safely;
7. unauthorized API request is denied without data leakage;
8. fixture and generated-client drift fail the gate;
9. restricted markers do not enter fixtures, logs, errors or evidence;
10. map-unavailable behavior preserves the equivalent list path;
11. service/provider failure is visible and does not invent business success;
12. cleanup affects only named project resources.

## 7. Relationship to delivery gates

- Sprint 0: approve this protocol; result remains Not Run.
- E01-01: implement pinned prerequisites and root command interfaces.
- E01-02..12: supply migration, service, contract, CI, seed, UI and environment evidence.
- Sprint 1 exit / Gate G1: execute the complete protocol on the accepted sprint revision.
- Later releases: repeat on every candidate and combine with the applicable hero, security, privacy, accessibility, evaluation, recovery and rollback evidence.

A previously passing run does not automatically apply to a new commit, dependency lock, migration, fixture manifest or environment.

## 8. Approval boundary

Product Owner approval dated 3 August 2026 accepts the clean-clone protocol, evidence schema and failure rules. It does not claim any command exists or has passed, activate Sprint 1 before E00-09, authorize real data or deployment, or establish production/compliance readiness.
